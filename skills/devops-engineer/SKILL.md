---
name: devops-engineer
description: Design, deploy, and maintain scalable infrastructure for web services, trading bots, and scheduled jobs. Covers CI/CD pipelines, monitoring, alerting, and infrastructure as code.
---

# DevOps Engineer

Build and maintain infrastructure for applications, bots, and services. This skill covers deployment strategies, monitoring, alerting, CI/CD pipelines, and infrastructure management.

## Deployment Architecture

### Components
```
Code Repository (GitHub)
    ↓
CI/CD Pipeline (GitHub Actions, n8n, self-hosted)
    ↓
Build & Test
    ↓
Deploy (staging → production)
    ↓
Running Service (cloud VM, Docker, k8s)
    ↓
Monitoring & Alerts (uptime, errors, latency)
    ↓
Logging & Observability (what went wrong?)
```

## Deployment Platforms

### Cloud (Recommended for most)
- **Vercel:** Frontend/Next.js (easiest for web apps)
- **Railway:** Full-stack with postgres (good for small projects)
- **Fly.io:** Docker containers (scalable, simple)
- **AWS EC2:** VPS (most control, most complex)
- **DigitalOcean:** VPS alternative (simpler than AWS)

### Self-Hosted (For crypto/trading bots)
- **Raspberry Pi:** Low cost, runs 24/7 at home
- **Dedicated server:** Bare metal, full control
- **VPS on Linode/Hetzner:** Cheap Linux servers
- **Home server:** If you have reliable internet

## CI/CD Pipeline

### GitHub Actions (Free, built-in)
```yaml
name: Deploy
on:
  push:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - run: npm install
      - run: npm test  # Only deploy if tests pass
      - run: npm run build

  deploy:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Deploy to Railway
        run: |
          curl -X POST https://api.railway.app/deploy \
            -H "Authorization: Bearer ${{ secrets.RAILWAY_TOKEN }}" \
            -d '{"branch": "main"}'
```

### Manual Deployment (For simple bots)
```bash
# Pull latest code
git pull origin main

# Install dependencies
pip install -r requirements.txt

# Run bot
python bot.py &
```

## Monitoring & Alerting

### What to Monitor

**Uptime:**
- Is the service running? (ping test)
- Response time (latency)
- Error rate (5xx responses)

**Business Metrics:**
- Trading bot: Daily P&L, win rate, Sharpe ratio
- Newsletter: Send rate, open rate, unsubscribe rate
- Bracket model: Prediction accuracy, error rate

**System Metrics:**
- CPU usage
- Memory usage
- Disk space
- Network I/O

### Monitoring Tools

- **UptimeRobot:** Free uptime monitoring (ping test)
- **Datadog:** APM + monitoring (paid, comprehensive)
- **New Relic:** Application performance monitoring
- **Prometheus + Grafana:** Open-source (self-hosted)
- **CloudWatch:** AWS monitoring (if using AWS)

### Alerting Rules

**Example: Trading Bot**
```
Alert if daily P&L < -$1000  (major loss)
Alert if bot hasn't traded in 24 hours  (stuck)
Alert if latency > 5 seconds  (API slow)
Alert if error rate > 5%  (something broken)
```

**Example: Newsletter**
```
Alert if send rate drops 50% (automation broken?)
Alert if storage quota > 80% (running out of space)
Alert if API rate limit exceeded (hitting limits)
```

### Alert Destinations
- Email (critical issues)
- Slack (team visibility)
- SMS (on-call rotation)
- PagerDuty (escalation for urgent)

## Logging & Observability

### Logging Best Practices

```python
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def execute_trade(order):
    logger.info(f"Executing order: {order}")  # What happened
    try:
        result = api.submit_order(order)
        logger.info(f"Order filled: {result}")
    except Exception as e:
        logger.error(f"Order failed: {e}", exc_info=True)  # Include traceback
        raise
```

### Log Levels
- **DEBUG:** Development only (too noisy for production)
- **INFO:** Important events (trade executed, bot started)
- **WARNING:** Unexpected but recoverable (low balance, slow API)
- **ERROR:** Errors that need attention (failed trade, API timeout)
- **CRITICAL:** System breaking errors (out of memory, database down)

### Centralized Logging

```
Local logs
    ↓
Log aggregation (ELK stack, Datadog, Splunk)
    ↓
Searchable, alertable
    ↓
Historical analysis
```

**Tools:**
- **ELK Stack:** Elasticsearch + Logstash + Kibana (open-source)
- **Datadog Logs:** Centralized logging (paid)
- **Splunk:** Enterprise logging (expensive)

## Infrastructure as Code

### Example: Terraform (IaC)
```hcl
# main.tf
provider "aws" {
  region = "us-east-1"
}

resource "aws_ec2_instance" "trading_bot" {
  ami           = "ami-0c02fb55956c7d316"  # Ubuntu
  instance_type = "t2.micro"

  tags = {
    Name = "trading-bot"
  }
}
```

### Benefits
- Reproducible infrastructure (can recreate in minutes)
- Version control (track changes)
- Disaster recovery (redeploy if server dies)

## Secrets Management

### Never commit secrets
```bash
# ❌ WRONG
export API_KEY="sk-1234567890"
git add .env && git commit -m "add api key"

# ✅ RIGHT
echo ".env" >> .gitignore
export API_KEY=$(cat ~/.keys/api_key)
```

### Secret Storage
- **GitHub Secrets:** For CI/CD
- **Environment variables:** For local development
- **Vault:** Centralized secret management
- **AWS Secrets Manager:** If using AWS

## Deployment Checklist

**Before Deploying:**
- [ ] Code reviewed (peer review)
- [ ] Tests passing (automated tests)
- [ ] Staging tested (manual smoke test)
- [ ] Database migrated (if schema changed)
- [ ] Secrets configured (API keys set)
- [ ] Monitoring enabled (alerts configured)
- [ ] Rollback plan (can we revert?)

**After Deploying:**
- [ ] Monitoring dashboard checked (no alerts?)
- [ ] Logs reviewed (no errors?)
- [ ] Business metrics confirmed (still working?)
- [ ] User-facing features tested (no visible bugs?)

## Disaster Recovery

### Backups
- **Database:** Daily backups, test restores monthly
- **Code:** GitHub is your backup (use branches)
- **Secrets:** Backup to secure location (not with code)
- **Config:** Version control (Terraform, docker-compose)

### Runbook (How to recover)
```
If trading bot stops:
  1. Check logs: tail -f /var/log/bot.log
  2. Restart: systemctl restart trading-bot
  3. Monitor: Check P&L, watch for errors
  4. If still broken: rollback to previous version

If database fails:
  1. Restore from backup: aws s3 cp s3://backups/db-2026-03-19.sql .
  2. Import: psql < db-2026-03-19.sql
  3. Validate: SELECT COUNT(*) FROM trades
  4. Restart application
```

## Common Issues & Solutions

### Bot Process Died Unexpectedly
```bash
# Install supervisor to auto-restart
sudo apt install supervisor

# Create config
[program:trading-bot]
command=python /path/to/bot.py
autostart=true
autorestart=true
redirect_stderr=true
stdout_logfile=/var/log/bot.log
```

### Out of Disk Space
```bash
# Check what's taking space
du -sh /* | sort -rh

# Common culprits: logs, database
# Solution: rotate old logs, archive old data
```

### Memory Leak (Process grows in size)
```bash
# Profile memory usage
python -m memory_profiler bot.py

# Look for: accumulating lists, unclosed connections
```

### API Rate Limit Exceeded
```python
# Add exponential backoff
import time
from random import random

def retry_with_backoff(func, max_retries=5):
    for attempt in range(max_retries):
        try:
            return func()
        except RateLimitError:
            wait_time = (2 ** attempt) + random()  # Exponential backoff
            print(f"Rate limited, retrying in {wait_time:.1f}s")
            time.sleep(wait_time)
```

## Production Checklist

- [ ] 99.9% uptime target (monitor, alert)
- [ ] Automated backups (test restores)
- [ ] Logging configured (search, alert)
- [ ] Monitoring active (CPU, memory, error rate, business metrics)
- [ ] Secrets secured (not in code, rotated regularly)
- [ ] CI/CD pipeline (automated tests, deployments)
- [ ] Runbooks documented (recovery procedures)
- [ ] On-call rotation (who responds to alerts?)
- [ ] Cost monitoring (monthly AWS/Fly.io bill reasonable?)
- [ ] Security review (auth, encryption, rate limiting)
