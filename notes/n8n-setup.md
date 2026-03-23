# n8n Local Setup

## Overview
n8n runs locally on each machine (not cloud). Workflows synced via GitHub repo: github.com/nkernaghan/n8n-workflows

## Installation (run on each machine)
```bash
brew install node@20
brew link node@20 --force --overwrite
npm install -g n8n
n8n start
```

## Requirements
- Node 20 (not 25 — isolated-vm fails to compile on Node 25)
- ~/.zshrc must have: `export PATH="/opt/homebrew/opt/node@20/bin:$PATH"`

## Running n8n
- Foreground: `n8n start` (terminal must stay open)
- Background: `nohup n8n start &`
- URL: http://localhost:5678
- API key: 82cf6bee-4a61-4e7b-99c4-02e605e54c4d

## MCP Config
Already in .mcp.json — points to http://localhost:5678/api/v1

## Workflow Sync
- Workflows stored in: ~/Desktop/n8n-workflows (github.com/nkernaghan/n8n-workflows)
- Use n8n's built-in Source Control (Settings → Source Control) to push/pull workflows
- Scheduled triggers only fire on machines where n8n is actively running
