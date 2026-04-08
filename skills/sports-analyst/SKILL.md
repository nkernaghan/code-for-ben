---
name: sports-analyst
description: Build NCAAB prediction models using multiple rating systems (Torvik, HCA, Vegas lines), bracket simulation, and projection accuracy validation. Specialized for March Madness forecasting and tournament analysis.
---

# Sports Analyst — NCAAB Specialization

Build accurate NCAAB prediction models by combining multiple rating systems, historical trends, and tournament dynamics. This skill covers Torvik ratings, home court advantage (HCA), Vegas line interpretation, bracket simulation, and accuracy measurement.

## Rating Systems

### Torvik Ratings (RPI Alternative)
- Adjusted offensive & defensive efficiency
- Updated daily, accounts for opponent strength
- Source: `torvik.org` or via API
- Strength: predictive power for tournament play

### Home Court Advantage (HCA)
- Historical advantage by conference
- Venues with altitude, crowd size effects
- Neutral site games (tournament games)
- Typical range: 2-4 points depending on venue

### Vegas Lines / Market Consensus
- Opening and closing lines (sharp money)
- Public betting trends (when they diverge)
- Sharp money moves early; public fades later
- Line movement tells you what sharps think

### RPI / Strength of Record (SOR)
- Simple rating system (legacy)
- Historical comparison baseline
- Over-weights quality wins
- Less reliable than Torvik but useful as sanity check

## Model Building Pattern

### 1. Data Collection
```
Torvik ratings (daily)
    ↓
Vegas lines (at game time)
    ↓
Historical results (all games played)
    ↓
Tournament seeds & pairings (March)
```

### 2. Feature Engineering
- Torvik diff (team A rating - team B rating)
- HCA adjustment (if team A home or neutral)
- Vegas spread vs. model prediction (signals sharp info)
- Rest days (back-to-back games effect)
- Recent form (last 10 games)
- Conference strength (tournament field context)

### 3. Model Training
- Logistic regression (simple baseline)
- Gradient boosting (better for non-linear effects)
- Train on historical seasons (exclude current year for validation)
- Validate on held-out season
- Measure: accuracy, calibration (predicted % vs actual %)

### 4. Blending Approaches
- **Market-based:** Torvik diff only (simple)
- **Vegas-informed:** Torvik + Vegas line as input
- **Ensemble:** Average predictions from multiple models
- **Consensus:** (Torvik + Vegas + Historical) / 3

## Bracket Simulation

### Seeding Logic
- 1-16 matchups (1 seed almost always wins)
- Chalk: higher seed wins (68-70% accuracy historically)
- Upsets: lower seeds win 30-32% of games

### Confidence-Based Simulation
- For each game, use model predicted win %
- Simulate tournament 10,000x (Monte Carlo)
- Track: final four appearance rate, champion rate by team
- Visualize: upset probability heatmap

### Evaluation
- Compare simulated outcomes vs. actual tournament
- Measure: teams that appeared in simulations but lost early
- Refine model if systematic biases appear

## Key Metrics

### Calibration
- Predicted 60% → games should be 60-65% actual win rate
- If model says 60% but team wins 80%, model is overconfident
- Use Brier score: (predicted % - actual %)²

### Accuracy
- Overall: % of games predicted correctly
- vs. Spread: how often you beat Vegas line
- vs. Vegas: does your model disagree with market?

### Tournament Performance
- Which teams does your model get right/wrong?
- Conference biases (overvalue/undervalue certain conferences)?
- Seed biases (higher seeds too favored/unfavored)?

## Common Pitfalls

❌ **Ignoring Vegas lines** — Market is efficient; if your model disagrees, investigate why
❌ **Over-fitting to recent form** — March Madness is a different game (neutral sites, pressure)
❌ **Torvik recency bias** — Tournament is close to season end; use season-long ratings, not last week
❌ **Seeds as causation** — Better teams get 1 seeds; seeds don't make teams better
❌ **Ignoring tournament travel** — Some regions have advantages (nearby fans, short travel)
❌ **Bracket inflation** — Overconfident in simulations = unrealistic upset probabilities

## Implementation Checklist

- [ ] Pull Torvik ratings (or historical Torvik data)
- [ ] Scrape Vegas opening/closing lines (or archive)
- [ ] Collect historical NCAAB game results (50+ seasons if available)
- [ ] Calculate HCA by conference (historical average)
- [ ] Build features: Torvik diff, HCA, rest days, recent form
- [ ] Train model on 90% of data; validate on 10%
- [ ] Measure calibration (Brier score)
- [ ] Measure accuracy vs. Vegas spread
- [ ] Simulate bracket 10,000x; compare to actual results
- [ ] Document model biases (conference, seed, venue)
- [ ] Update forecasts as season progresses
- [ ] Compare final 4 predictions to actual Final 4

## Data Sources

- **Torvik:** `torvik.org` (daily updates)
- **Vegas lines:** Sports Reference, Covers.com (historical), ESPN (live)
- **Game results:** Sports Reference, ESPN, Kenpom (historical), `cbssports.com`
- **Tournament brackets:** NCAA.org, ESPN (seeding, pairings)
- **Venue info:** NCAA tournament locations (same venues historically)

## Model Refinement Questions

- Does Torvik diff alone beat Vegas spread? (If not, Vegas has extra info)
- Which conferences are under/overvalued? (Investigate by looking at residuals)
- Do home games have higher win % for HCA-adjusted teams? (Validate HCA assumption)
- Are recent upsets predictable? (Look at ratings before game vs. after)
- How does your model perform on Elite 8 and Final 4? (Harder games = different dynamics)

## Tournament Dynamics

**Sweet 16+ games are different:**
- Higher variance (better teams can lose)
- Neutral sites level playing field
- Elite teams are over-seeded relative to actual strength
- Cinderella teams (11+ seeds) more common due to variance

**Adjust for:**
- Neutral site (reduce HCA)
- Team experience (Final Four repeats do better)
- Playing nearby (geographic advantage)
- Coaching matchups (some coaches excel in tournaments)
