# CLAUDE.md

This is a **Claude Code configuration repository** — not a software project. It contains reusable prompts, skills, slash commands, and scripts for configuring Claude Code across projects.

## Repo Layout

| Path | Purpose |
|------|---------|
| `.claude/commands/` | Slash commands (`/build`, `/review`, `/security`, `/plan`) |
| `.claude/settings.local.json` | Local MCP server settings (not committed) |
| `.mcp.json` | MCP servers: `fetch` + `playwright` |
| `prompts/brain.md` | Brain Router — mode/skill/MCP routing system prompt |
| `prompts/default.md` | Default hybrid agent system prompt |
| `skills/` | Modular skill definitions (orchestrator, builder, reviewer, etc.) |
| `scripts/bootstrap_project.sh` | Bootstrap script for new projects |
| `templates/` | Reusable project templates |
| `notes/` | Working notes |

## Slash Commands

- `/plan <task>` — Classify and plan a task (Orchestrator skill)
- `/build <goal>` — Build an artifact (Builder skill)
- `/review <target>` — Code review (Reviewer skill)
- `/security <target>` — Security audit (Security Guard skill)

## Brain Router

The default system prompt for all sessions is defined in [`prompts/brain.md`](prompts/brain.md).

It routes every task through:
1. **MODE** selection (RESEARCH / PLAN / BUILD / DEBUG / DOCS / DATA / AUTOMATION / SECURITY / QUANT)
2. **Skill routing** (Orchestrator → Builder → Reviewer etc.)
3. **MCP tool routing** (lightest tool that works)
4. **Structured output** (MODE → Plan → Execute → Verify → Security → Deliverable)

Safety rules: no secrets stored, no live trades without explicit "GO LIVE", no `.env` commits.

## MCP Servers

- `web-fetch` — HTTP fetch for web content (`@modelcontextprotocol/server-fetch`)
- `filesystem-access` — Read/write local files (`@modelcontextprotocol/server-filesystem`)
- `github-integration` — GitHub repos/PRs/diffs (`@modelcontextprotocol/server-github`, needs token)
- `postgresql-integration` — Postgres queries (`@modelcontextprotocol/server-postgres`, needs connection string)
- `memory-integration` — Persistent memory (`@modelcontextprotocol/server-memory`)

## Universal Development Guidelines

### Code Quality Standards
- Write clean, readable, and maintainable code
- Follow consistent naming conventions across the project
- Use meaningful variable and function names
- Keep functions focused and single-purpose
- Add comments for complex logic and business rules

### Git Workflow
- Use descriptive commit messages following conventional commits format
- Create feature branches for new development
- Keep commits atomic and focused on single changes
- Use pull requests for code review before merging
- Maintain a clean commit history

### Documentation
- Keep README.md files up to date
- Document public APIs and interfaces
- Include usage examples for complex features
- Maintain inline code documentation
- Update documentation when making changes

### Testing Approach
- Write tests for new features and bug fixes
- Maintain good test coverage
- Use descriptive test names that explain the expected behavior
- Organize tests logically by feature or module
- Run tests before committing changes

### Security Best Practices
- Never commit sensitive information (API keys, passwords, tokens)
- Use environment variables for configuration
- Validate input data and sanitize outputs
- Follow principle of least privilege
- Keep dependencies updated

## Project Structure Guidelines

### File Organization
- Group related files in logical directories
- Use consistent file and folder naming conventions
- Separate source code from configuration files
- Keep build artifacts out of version control
- Organize assets and resources appropriately

### Configuration Management
- Use configuration files for environment-specific settings
- Centralize configuration in dedicated files
- Use environment variables for sensitive or environment-specific data
- Document configuration options and their purposes
- Provide example configuration files

## Development Workflow

### Before Starting Work
1. Pull latest changes from main branch
2. Create a new feature branch
3. Review existing code and architecture
4. Plan the implementation approach

### During Development
1. Make incremental commits with clear messages
2. Run tests frequently to catch issues early
3. Follow established coding standards
4. Update documentation as needed

### Before Submitting
1. Run full test suite
2. Check code quality and formatting
3. Update documentation if necessary
4. Create clear pull request description

## Common Patterns

### Error Handling
- Use appropriate error handling mechanisms for the language
- Provide meaningful error messages
- Log errors appropriately for debugging
- Handle edge cases gracefully
- Don't expose sensitive information in error messages

### Performance Considerations
- Profile code for performance bottlenecks
- Optimize database queries and API calls
- Use caching where appropriate
- Consider memory usage and resource management
- Monitor and measure performance metrics

### Code Reusability
- Extract common functionality into reusable modules
- Use dependency injection for better testability
- Create utility functions for repeated operations
- Design interfaces for extensibility
- Follow DRY (Don't Repeat Yourself) principle

## Review Checklist

Before marking any task as complete:
- [ ] Code follows established conventions
- [ ] Tests are written and passing
- [ ] Documentation is updated
- [ ] Security considerations are addressed
- [ ] Performance impact is considered
- [ ] Code is reviewed for maintainability