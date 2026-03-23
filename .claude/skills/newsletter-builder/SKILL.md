---
name: newsletter-builder
description: Design and implement professional newsletters with multi-section structure, content curation, HTML templates, and automation. Specialized for AI/Crypto daily newsletters with news aggregation and formatting.
---

# Newsletter Builder

Design and build professional newsletters with content curation, HTML templating, scheduling, and multi-section structure. This skill covers editorial planning, content sources, template design, automation, and analytics.

## Newsletter Architecture

### Section Structure (AI/Crypto Example)
1. **Headline** — One major story (AI or Crypto)
2. **AI News** — Top 3-5 major AI announcements/research
3. **Crypto Markets** — Price moves, market news, on-chain signals
4. **Bitcoin Price** — Daily close, 24h change, macro context
5. **Call-to-Action** — Link to full coverage or archive

### Content Types

**AI Section:**
- New model releases (Claude, GPT-5, Gemini)
- Research papers & breakthroughs
- Company announcements (OpenAI, Anthropic, Google)
- Regulatory updates (EU AI Act, Biden EO)
- Funding rounds & M&A

**Crypto Section:**
- Major market moves (Bitcoin, Ethereum, altcoins)
- Protocol updates (Solana, Ethereum roadmap)
- Regulatory news (SEC, CFTC, international)
- DeFi developments (new protocols, hacks, recoveries)
- Institutional adoption

**Bitcoin Section:**
- Daily closing price
- 24h % change & range
- Weekly/monthly context
- Macro context (inflation, Fed, market sentiment)

## Content Curation Workflow

### Daily Schedule
- **8 AM:** Scan news sources (1 hour)
- **9 AM:** Write first draft (1.5 hours)
- **10:30 AM:** Review & edit (30 min)
- **11 AM:** Format & send (30 min)

### News Sources

**AI:**
- `news.ycombinator.com` (tech news)
- `reddit.com/r/MachineLearning` (research)
- `The Block` (crypto + AI)
- Twitter/X (company announcements)
- ArXiv (papers)

**Crypto:**
- CoinMarketCap (prices & market data)
- Crypto Twitter / Farcaster
- The Block (crypto focused)
- Cointelegraph (news aggregator)
- On-chain: Nansen, Glassnode (analytics)

**Bitcoin:**
- CoinGecko or CoinMarketCap (price)
- Bitcoin Magazine
- Federal Reserve (macro)
- CNBC/Bloomberg (market sentiment)

## HTML Email Template

```html
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <style>
    body { font-family: -apple-system, BlinkMacSystemFont, sans-serif; line-height: 1.6; }
    .container { max-width: 600px; margin: 0 auto; padding: 20px; }
    h1 { color: #000; font-size: 24px; }
    h2 { color: #333; font-size: 18px; border-left: 4px solid #2563eb; padding-left: 12px; margin-top: 20px; }
    .news-item { margin-bottom: 16px; }
    .source { color: #666; font-size: 12px; }
    .cta { background: #2563eb; color: white; padding: 12px 24px; border-radius: 6px; text-decoration: none; display: inline-block; margin-top: 20px; }
    .footer { color: #999; font-size: 12px; margin-top: 30px; border-top: 1px solid #eee; padding-top: 20px; }
  </style>
</head>
<body>
  <div class="container">
    <h1>🤖 AI & Crypto Daily — March 19, 2026</h1>

    <h2>Top Story: [Headline]</h2>
    <div class="news-item">
      <p>[Summary paragraph]</p>
      <p class="source">Source: [Link]</p>
    </div>

    <h2>🚀 AI News</h2>
    <div class="news-item">
      <strong>1. [Headline]</strong>
      <p>[2-3 sentence summary]</p>
      <p class="source">→ [Link]</p>
    </div>
    <!-- Repeat for items 2-5 -->

    <h2>💰 Crypto Markets</h2>
    <div class="news-item">
      <strong>1. [Market move headline]</strong>
      <p>[Context, why it matters]</p>
      <p class="source">→ [Link if applicable]</p>
    </div>
    <!-- Repeat for items 2-5 -->

    <h2>₿ Bitcoin: $[Price]</h2>
    <div class="news-item">
      <p>24h: <strong>[+X.X%]</strong> | Range: $[Low] – $[High]</p>
      <p>Macro context: [2-3 sentences on Fed, inflation, or sentiment]</p>
    </div>

    <a href="[archive-link]" class="cta">Read Full Coverage</a>

    <div class="footer">
      <p>© 2026 AI & Crypto Daily. Unsubscribe | Update Preferences</p>
    </div>
  </div>
</body>
</html>
```

## Automation Setup

### Tools
- **Curation:** n8n (workflow automation), Make (Zapier alternative)
- **Writing:** Claude API (headline summarization)
- **Email:** Substack, Buttondown, or SendGrid
- **Scheduling:** n8n, zapier, or native tool
- **Analytics:** Substack, Mailchimp, or custom tracking

### Workflow
```
RSS feeds / News APIs
    ↓
Filter & rank (Claude API for scoring)
    ↓
Summarize top stories
    ↓
Generate HTML email
    ↓
Send via email provider
    ↓
Track opens & clicks
    ↓
Analytics dashboard
```

## Editorial Checklist

### Per Email
- [ ] Accurate headlines (no clickbait)
- [ ] Summaries are factual (no speculation)
- [ ] Links are working (test before send)
- [ ] Bitcoin price is current (within 1 hour)
- [ ] HTML renders correctly (test in major clients)
- [ ] No duplicate stories
- [ ] Tone is consistent
- [ ] Grammar & spelling checked
- [ ] Call-to-action is clear
- [ ] Footer has unsubscribe link (legal requirement)

### Weekly
- [ ] Measure open rate (target: 30%+)
- [ ] Measure click-through rate (target: 5%+)
- [ ] Track subscriber growth
- [ ] Review feedback (replies, unsubscribes)
- [ ] Adjust section balance if needed

### Monthly
- [ ] Analyze most-read stories (what topics resonate?)
- [ ] Test new section or format
- [ ] Review sources (are they accurate?)
- [ ] Update template if stale
- [ ] Plan upcoming specials (end-of-month recap, etc.)

## Distribution Strategy

### Primary Channel
- Email (owned audience, highest engagement)
- Subject line is critical (test variants)

### Secondary Channels
- Twitter/X thread (summary, drive to newsletter)
- LinkedIn (professional angle)
- Discord/Telegram (community)
- Blog/archive (SEO, searchability)

### Growth
- Link in email signature
- Referral incentives (free tiers, premium access)
- Guest post on complementary newsletters
- Sponsorship (if monetized)

## Monetization Options

- **Sponsorships:** Crypto projects, trading tools, exchanges (US $500-5K per placement)
- **Premium tier:** Extra analysis, alerts, exclusive research (Substack Pro)
- **Affiliate links:** Exchanges, trading bots, research tools (5-20% commission)
- **Ads:** Programmatic or direct sales

## Analytics to Track

- **Open rate:** % of recipients who opened email
- **Click rate:** % of recipients who clicked a link
- **Unsubscribe rate:** Should be <0.5% per send
- **Bounce rate:** Hard bounces = bad email addresses
- **List growth:** New subscribers vs. churn
- **Traffic to site:** Newsletter link clicks

## Common Pitfalls

❌ **Inconsistent sending** — Skip a day → readers forget to expect it
❌ **Overly long** — More than 5 min to read → unsubscribes
❌ **Poor subject lines** — No intrigue, too generic
❌ **Stale content** — News from yesterday = not compelling
❌ **Too promotional** — Reader feels sold to → churn
❌ **Mobile rendering broken** — 60%+ open on mobile; test!
❌ **Broken links** — Looks unprofessional, kills CTR

## Ideal Format

- **Length:** 300-500 words (3-5 min read)
- **Subject line:** 40-50 characters, curiosity + specificity
- **Sections:** 5-6 sections max (too many = overwhelming)
- **Links:** 5-10 outbound links (not more)
- **Images:** Minimal (only if they add value, can slow load)
- **Frequency:** Daily (consistency) or 2-3x/week (sustainable)

## Template Personalization

- Greet subscriber by first name
- Track which sections they click most
- Recommend content based on past engagement
- A/B test subject lines
- Segmentation: VIP readers get early access
