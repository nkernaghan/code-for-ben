# Claude Code Brain

Complete collection of skills, agents, commands, and MCP server configs for Claude Code.

## Setup

```bash
# Clone
git clone https://github.com/nkernaghan/code-for-ben.git
cd code-for-ben

# Copy skills, agents, and commands
cp -R skills/ ~/.claude/skills/
cp -R agents/ ~/.claude/agents/
cp -R commands/ ~/.claude/commands/

# Copy MCP config (edit API keys first)
cp mcp-servers.json ~/.claude/.mcp.json
```

## What's Included

### Skills (51)

| Category | Skills |
|----------|--------|
| **Workflow** | brainstorming, writing-plans, executing-plans, systematic-debugging, test-driven-development, verification-before-completion, dispatching-parallel-agents, subagent-driven-development, requesting-code-review, receiving-code-review, finishing-a-development-branch, using-git-worktrees, using-superpowers |
| **Backend** | senior-backend, senior-security |
| **Frontend** | frontend-design, webapp-testing, canvas-design, theme-factory |
| **Documents** | docx, pdf-processing-pro, spreadsheet_builder, document_builder, human-writing |
| **Solana/Web3** | build, dflow, svm, phantom |
| **Research** | market-researcher, last30days, research_verifier |
| **Trading** | trading-bot-architect, quant_analyst |
| **DevOps** | devops-engineer, performance-optimizer |
| **Obsidian** | obsidian-markdown, obsidian-cli, obsidian-bases, json-canvas |
| **Code Quality** | code-reviewer, reviewer, security_guard |
| **Other** | skill-creator, writing-skills, builder, orchestrator, automation_engineer, newsletter-builder, curriculum-architect, sports-analyst, defuddle |

### Agents (14)

Specialized sub-agents for the Agent tool:

- backend-architect, code-review-agent, context-manager, database-admin, debugger, frontend-developer, plan-reviewer, python-pro, research-orchestrator, search-specialist, task-decomposition-expert, technical-researcher, technical-writer, ui-ux-designer

### Commands (17)

Slash commands: `/bot`, `/brainstorm`, `/build`, `/curriculum`, `/deploy`, `/dflow`, `/docs`, `/newsletter`, `/obsidian`, `/optimize`, `/quant`, `/research`, `/review`, `/security`, `/sports`, `/svm`, `/ui`

### MCP Servers

`mcp-servers.json` — template config for:
- **fetch** — web fetching
- **playwright** — browser automation and testing
- **memory** — persistent memory via knowledge graph
- **n8n** — workflow automation (requires your own API key)

## Keeping Updated

```bash
cd code-for-ben && git pull
cp -R skills/ ~/.claude/skills/
cp -R agents/ ~/.claude/agents/
cp -R commands/ ~/.claude/commands/
```
