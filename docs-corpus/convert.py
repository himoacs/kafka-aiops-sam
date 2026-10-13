"""Convert the Apache Kafka docs (kafka-site, Hugo Markdown + generated HTML) into a grep-friendly corpus
for the kafka-docs SAM skill. Stdlib only.

Prose pages  -> references/<section>/<page>.md  (frontmatter: title, source_url, kafka_version, source_path)
Generated    -> references/reference/<name>.md   one `## <entry>` block per config option / error code / metric,
                each with a `Docs:` URL so a grep hit with context carries its own citation.
"""
import argparse, html, re, sys
from html.parser import HTMLParser
from pathlib import Path

PROSE_SECTIONS = ["operations", "security", "design", "implementation", "kafka-connect", "configuration"]
GETTING_STARTED = ["upgrade.md", "zk2kraft.md", "compatibility.md"]
# generated file -> (reference name, kind, heading for the file)
GENERATED = {
    "kafka_config.html": ("broker-configs", "config", "Broker configs"),
    "topic_config.html": ("topic-configs", "config", "Topic configs"),
    "group_config.html": ("group-configs", "config", "Group configs"),
    "producer_config.html": ("producer-configs", "config", "Producer configs"),
    "consumer_config.html": ("consumer-configs", "config", "Consumer configs"),
    "admin_client_config.html": ("admin-client-configs", "config", "Admin client configs"),
    "connect_config.html": ("connect-configs", "config", "Kafka Connect worker configs"),
    "remote_log_manager_config.html": ("tiered-storage-configs", "config", "Tiered storage (remote log manager) configs"),
    "protocol_errors.html": ("error-codes", "table", "Protocol error codes"),
    "producer_metrics.html": ("metrics-producer", "table", "Producer metrics"),
    "consumer_metrics.html": ("metrics-consumer", "table", "Consumer metrics"),
    "connect_metrics.html": ("metrics-connect", "table", "Kafka Connect metrics"),
}
INCLUDE = re.compile(r'\{\{<\s*include-html\s+file="[^"]*?/generated/([^"]+)"\s*>\}\}')
SHORTCODE = re.compile(r'\{\{[<%].*?[>%]\}\}', re.S)
LICENSE = re.compile(r'<!--\s*Licensed to the Apache Software Foundation.*?-->', re.S)


class Inline(HTMLParser):
    """HTML fragment -> compact Markdown text (code spans, lists, paragraphs)."""
    def __init__(self):
        super().__init__(convert_charrefs=True); self.out = []
    def handle_starttag(self, t, a):
        if t == "code": self.out.append("`")
        elif t == "li": self.out.append("\n- ")
        elif t in ("p", "br", "ul", "ol"): self.out.append("\n\n" if t == "p" else "\n")
    def handle_endtag(self, t):
        if t == "code": self.out.append("`")
    def handle_data(self, d): self.out.append(d)
    def text(self):
        s = "".join(self.out)
        s = re.sub(r"[ \t]+", " ", s); s = re.sub(r"\n[ \t]+", "\n", s); s = re.sub(r"\n{3,}", "\n\n", s)
        return s.strip()

def md(fragment):
    p = Inline(); p.feed(fragment); return p.text()

def frontmatter(**kv):
    return "---\n" + "".join(f"{k}: {v}\n" for k, v in kv.items()) + "---\n\n"

def slug(rel):
    """Hugo drops parentheses from URL slugs; use the same slug for file names so grep hits and URLs agree."""
    return re.sub(r"[()]", "", rel)

def page_url(base, rel):
    rel = slug(rel)
    rel = rel[:-3] if rel.endswith(".md") else rel
    if rel.endswith("_index"): rel = rel[: -len("_index")]
    return f"{base}/{rel}".rstrip("/") + "/"

def parse_meta(text):
    m = re.match(r"---\n(.*?)\n---\n", text, re.S)
    title = ""
    if m:
        t = re.search(r"^title:\s*(.+)$", m.group(1), re.M)
        title = t.group(1).strip().strip("'\"") if t else ""
        text = text[m.end():]
    return title, text

def convert_prose(src, out, base, version, include_pages, stats):
    files = []
    for sec in PROSE_SECTIONS:
        files += sorted((src / sec).rglob("*.md"))
    files += [src / "getting-started" / n for n in GETTING_STARTED if (src / "getting-started" / n).exists()]
    for f in files:
        rel = f.relative_to(src).as_posix()
        title, body = parse_meta(f.read_text(encoding="utf-8"))
        body = LICENSE.sub("", body)
        body = INCLUDE.sub(lambda m: f"\n> Reference table for this section: see `reference/{GENERATED[m.group(1)][0]}.md` "
                           f"(search it, do not read whole).\n" if m.group(1) in GENERATED else "\n", body)
        body = SHORTCODE.sub("", body).strip()
        if len(body) < 40: continue
        dest = out / slug(rel)
        dest.parent.mkdir(parents=True, exist_ok=True)
        dest.write_text(frontmatter(title=title or f.stem, source_url=page_url(base, rel), kafka_version=version,
                                    source_path=f"content/en/{src.name}/{rel}") + f"# {title or f.stem}\n\nDocs: {page_url(base, rel)}\n\n{body}\n", encoding="utf-8")
        stats["pages"] += 1

def find_include_pages(src, base):
    """generated file -> URL of the page that embeds it (searched across ALL pages)."""
    m = {}
    for f in src.rglob("*.md"):
        rel = f.relative_to(src).as_posix()
        if rel.startswith("documentation/"): continue
        for g in INCLUDE.findall(f.read_text(encoding="utf-8")):
            m.setdefault(g, page_url(base, rel))
    return m

def convert_config(raw, url):
    blocks = []
    for li in re.findall(r"<li>(.*?)</li>", raw, re.S):
        h = re.search(r'<h4><a id="([^"]+)"></a>(?:<a id="([^"]*)" href="([^"]*)">)?([^<]+)', li)
        if not h: continue
        name, anchor = h.group(4).strip(), (h.group(3) or "#" + h.group(1))
        desc = re.search(r"</h4>\s*(.*?)\s*<table", li, re.S)
        rows = re.findall(r"<tr><th>(.*?)</th><td>(.*?)</td></tr>", li, re.S)
        lines = [f"## {name}", "", md(desc.group(1)) if desc else "", ""]
        lines += [f"- **{md(k).rstrip(':')}:** {md(v) or '(empty)'}" for k, v in rows]
        lines += [f"- **Docs:** {url}{anchor}", ""]
        blocks.append("\n".join(lines))
    return blocks

def convert_table(raw, url, headings):
    blocks = []
    rows = re.findall(r"<tr>(.*?)</tr>", raw, re.S)
    if not rows: return blocks
    header = [md(h) for h in re.findall(r"<th>(.*?)</th>", rows[0], re.S)]
    for r in rows[1:]:
        cells = [md(c) for c in re.findall(r"<td>(.*?)</td>", r, re.S)]
        if not cells or not cells[0]: continue
        title = cells[0] + (f" (code {cells[1]})" if header[:2] == ["Error", "Code"] and len(cells) > 1 else "")
        lines = [f"## {title}", ""]
        lines += [f"- **{h}:** {c or '(empty)'}" for h, c in zip(header[1:], cells[1:])]
        lines += [f"- **Docs:** {url}", ""]
        blocks.append("\n".join(lines))
    return blocks

def convert_generated(src, out, base, version, include_pages, stats):
    ref = out / "reference"; ref.mkdir(parents=True, exist_ok=True)
    for fname, (name, kind, heading) in GENERATED.items():
        f = src / "generated" / fname
        if not f.exists(): print(f"warn: missing {fname}", file=sys.stderr); continue
        url = include_pages.get(fname, f"{base}/")
        raw = f.read_text(encoding="utf-8")
        blocks = convert_config(raw, url) if kind == "config" else convert_table(raw, url, None)
        if not blocks: print(f"warn: no entries parsed from {fname}", file=sys.stderr); continue
        (ref / f"{name}.md").write_text(
            frontmatter(title=heading, source_url=url, kafka_version=version, source_path=f"content/en/{src.name}/generated/{fname}")
            + f"# {heading} (Apache Kafka {version})\n\nOne `## <entry>` block per item. Search with grep (case-insensitive, ~10 context lines); do not read whole.\n\n"
            + "\n".join(blocks), encoding="utf-8")
        stats["entries"] += len(blocks); stats["ref_files"] += 1

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--src", required=True); ap.add_argument("--out", required=True)
    ap.add_argument("--version", required=True); ap.add_argument("--version-dir", required=True); ap.add_argument("--sha", required=True)
    a = ap.parse_args()
    src, out = Path(a.src), Path(a.out)
    base = f"https://kafka.apache.org/{a.version_dir}"
    stats = {"pages": 0, "ref_files": 0, "entries": 0}
    inc = find_include_pages(src, base)
    convert_prose(src, out, base, a.version, inc, stats)
    convert_generated(src, out, base, a.version, inc, stats)
    files = sorted(p.relative_to(out).as_posix() for p in out.rglob("*.md"))
    total = sum((out / p).stat().st_size for p in files)
    (out / "MANIFEST.md").write_text(
        f"# kafka-docs corpus manifest\n\n- Source: https://github.com/apache/kafka-site (Apache-2.0), `content/en/{a.version_dir}/`\n"
        f"- Commit: `{a.sha}`\n- Kafka version: {a.version}\n- Prose pages: {stats['pages']}; reference files: {stats['ref_files']}; "
        f"reference entries: {stats['entries']}\n- Total size: {total/1024:.0f} KB across {len(files)} files\n- Excluded: Kafka Streams docs, protocol message schemas, connect transforms/predicates, mirror configs\n\n## Files\n\n"
        + "".join(f"- {p}\n" for p in files), encoding="utf-8")
    print(f"pages={stats['pages']} ref_files={stats['ref_files']} entries={stats['entries']} size={total/1024:.0f}KB")

if __name__ == "__main__":
    main()
