# Claude Code Brain

Skills, agents, and commands for Claude Code. Drop these into your `~/.claude/` directory to use them.

## Setup

```bash
# Clone the repo
git clone https://github.com/nkernaghan/code-for-ben.git

# Copy skills into your Claude config
cp -R code-for-ben/skills/ ~/.claude/skills/
cp -R code-for-ben/agents/ ~/.claude/agents/
cp -R code-for-ben/commands/ ~/.claude/commands/
```

## What's Included

### Skills (46)
Drop-in skill modules that activate automatically based on context.

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
| **Other** | skill-creator, writing-skills, code-reviewer, reviewer, security_guard, builder, orchestrator, automation_engineer, newsletter-builder, curriculum-architect, sports-analyst, defuddle |

### Agents (14)
Specialized sub-agents for the Agent tool.

- backend-architect, code-review-agent, context-manager, database-admin, debugger, frontend-developer, plan-reviewer, python-pro, research-orchestrator, search-specialist, task-decomposition-expert, technical-researcher, technical-writer, ui-ux-designer

### Commands (17)
Slash commands (`/build`, `/review`, `/security`, `/plan`, etc.)

## Keeping Updated
Pull latest and re-copy:
```bash
cd code-for-ben && git pull && cp -R skills/ ~/.claude/skills/ && cp -R agents/ ~/.claude/agents/ && cp -R commands/ ~/.claude/commands/
```
