---
name: trading-bot-architect
description: Design and build sophisticated multi-agent crypto trading bots with risk management, backtesting, and coordination strategies. Specialized for systems like Polymarket copy-trading with multiple independent traders.
---

# Trading Bot Architect

Design and implement production-ready crypto trading bots with multiple agents, risk management, and backtesting. This skill covers bot architecture, trader coordination, signal routing, risk controls, and performance monitoring.

## Core Responsibilities

1. **Multi-Agent Architecture** — Coordinate multiple independent traders/strategies
2. **Signal & Execution Flow** — Market data → signals → trader decisions → execution
3. **Risk Management** — Position sizing, drawdown limits, correlation hedging
4. **Backtesting Framework** — Historical validation and performance measurement
5. **Live Monitoring** — Real-time metrics, alert thresholds, circuit breakers
6. **State Management** — Trader equity, fills, slippage tracking

## Trader Types

### Copy-Trading (Polymarket style)
- Follow N independent traders with different models
- Aggregate signals: consensus, weighted voting, or independent execution
- Track each trader's P&L separately
- Replicate trades with optional position sizing

### Signal-Based
- Technical indicators → buy/sell signals
- ML predictions → confidence scores
- On-chain metrics → alpha signals
- Risk parity or momentum weighting

### Market-Making / Arbitrage
- Spread optimization
- Inventory management
- Pair trading & cross-market arb
- Latency-sensitive execution

## Architecture Pattern

```
Market Data Sources
    ↓
Signal Engine (Technical, ML, On-Chain)
    ↓
Trader Strategies (Independent decision-making)
    ↓
Aggregator (Consensus/voting/weighting)
    ↓
Risk Filter (Position limits, correlation checks)
    ↓
Execution Engine (Batch orders, slippage management)
    ↓
Settlement & Tracking (Fill prices, P&L, slippage)
    ↓
Monitoring & Alerts (Real-time metrics, drawdown triggers)
```

## Risk Management Rules

### Per-Trader Limits
- Max position size (% of equity)
- Max leverage ratio
- Max open positions at once
- Max daily loss (stop-loss trigger)

### Portfolio Limits
- Max correlation between traders
- Max sector/asset concentration
- Max drawdown threshold (pause trading)
- Max slippage tolerance

### Execution Rules
- Order size limits (market impact)
- Time-weighted average price (TWAP) for large orders
- Minimum liquidity check before execution
- Partial fills handling

## Backtesting Checklist

- [ ] Historical data quality (gaps, outliers)
- [ ] Realistic slippage modeling (bid-ask, market depth)
- [ ] Transaction costs included (fees, priority fees on Solana)
- [ ] Trader correlation in backtest matches live
- [ ] Drawdown analysis (max DD, recovery time)
- [ ] Sharpe ratio, Sortino, and max drawdown comparison
- [ ] Out-of-sample validation (train/test split)
- [ ] Monte Carlo simulation for robustness
- [ ] Forward-test before live deployment

## Live Monitoring Metrics

**Per Trader:**
- Win rate, average win/loss
- Sharpe ratio, max drawdown
- Equity curve (total P&L over time)
- Trade frequency & latency

**Portfolio:**
- Total equity, daily P&L, cumulative P&L
- Correlation matrix (trader pairs)
- Sector/asset breakdown
- Current vs. max drawdown

**Execution:**
- Average slippage vs. expected
- Partial fill rate
- Order cancellation rate
- Execution latency (order → fill)

## Common Pitfalls

❌ **Over-optimization** — Too many rules → brittle bot; overfits backtest
❌ **Survivor bias** — Only including traders that were profitable historically
❌ **Correlation surprise** — Traders move together during crisis (look decorrelated, move together live)
❌ **Slippage underestimation** — Assumes taker prices; reality is worse at scale
❌ **State inconsistency** — Fills don't match blockchain (missed fills, partial fills)
❌ **No circuit breaker** — Bot keeps trading during flash crash

## Implementation Flow

1. **Design phase**
   - Define trader types and decision rules
   - Risk limits and correlation targets
   - Execution strategy (batch vs. immediate)

2. **Backtest phase**
   - Gather historical data for traders/signals
   - Implement realistic slippage and costs
   - Run backtest with out-of-sample validation
   - Measure Sharpe, drawdown, transaction costs

3. **Paper trading phase**
   - Run on live data without real money
   - Track execution latency and slippage
   - Validate state consistency with blockchain
   - Measure signal quality in real-time

4. **Live deployment**
   - Start with small position sizes (1% of capital)
   - Monitor daily: correlation, P&L, slippage
   - Gradually increase capital if drawdown < threshold
   - Adjust risk limits based on live performance

## Tools & Frameworks

- **Backtesting:** Backtrader, VectorBT, custom Python
- **Live execution:** dflow (Solana), CCXT (multi-exchange), native APIs
- **Data:** Helius (Solana on-chain), Coingecko (prices), TradingView (OHLCV)
- **Monitoring:** Prometheus metrics, Grafana dashboards, Discord alerts
- **State:** Redis (live fills), PostgreSQL (historical trades)

## Questions to Ask

- How many traders/signals are you aggregating?
- What's the target Sharpe ratio and acceptable max drawdown?
- Are traders independent or correlated? (If correlated, need diversification)
- What's your latency tolerance? (Market-making needs <100ms; copy-trading can be slower)
- What blockchain/DEX? (Solana? Ethereum? Multi-chain?)
- How much capital to start? (Determines position sizing and slippage impact)
