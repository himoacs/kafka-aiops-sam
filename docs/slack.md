# Optional: Slack

The Slack entrypoint lets people message a bot and get the orchestrator's answer in the thread. It uses Slack
Socket Mode: the connection goes **outbound** from SAM to Slack, so no public URL is needed.

1. Create a Slack app and enable Socket Mode, following Solace's guide:
   [Slack Entrypoints](https://docs.solace.com/Agent-Mesh/Framework/building/entrypoints/slack/index.htm). You need
   a Bot token (`xoxb-...`) with the scopes that page lists, and an App-level token (`xapp-...`) with the
   `connections:write` scope. Scopes differ between Solace's pages and community posts, so use the current
   official list.
2. Put the tokens in `sam/.env` as `SLACK_BOT_TOKEN` and `SLACK_APP_TOKEN`.
3. `scripts/apply.sh --with-slack`.
4. Message the bot. It routes to `kafka_orchestrator_agent` (`sam/entrypoints/aiops_slack.yaml`).

Slack messages and answers pass through Slack, so apply the data-handling question in [security.md](security.md)
to what people may ask about.
