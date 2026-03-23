# Blockchain Forensics Planning Framework
## Federal Agency Approach + Helius + AI Architecture

---

## Part 1: How Federal Agencies Conduct Blockchain Forensics

### Core Methodology (IRS-CI, FBI, DEA Pattern)

**Phase 1: Initial Investigation & Source Identification**
- Identify entry/exit points (exchange KYC data, bank transfers)
- Map blockchain address to known entities via:
  - Exchange deposit/withdrawal patterns
  - Public address labels and OSINT
  - Behavioral clustering (similar tx patterns = likely same entity)
- Establish timeline of illicit activity

**Phase 2: Transaction Tracing & Flow Analysis**
- Follow the money across blockchain(s)
- Identify mixing/tumbling tactics (CoinJoin, privacy pools, DEX swaps)
- Create transaction graphs with node (wallet) and edge (tx) relationships
- Flag high-risk patterns:
  - Rapid consolidation/fragmentation
  - Round-number transactions (signs of timing evasion)
  - Dormant period before movement (intent obfuscation)

**Phase 3: Entity Clustering & Attribution**
- Group addresses belonging to same actor using heuristics:
  - Input/output co-spending (same tx inputs)
  - Temporal proximity + value thresholds
  - Interaction patterns (A always sends to B, then B to C)
- Link to known entities (exchanges, services, criminal infrastructure)
- Risk-score each entity cluster

**Phase 4: Evidence Preservation & Chain of Custody**
- Full transaction history with timestamps and amounts
- Snapshot blockchain state at key moments
- Document all inferences and their confidence levels
- Reproducible audit trail (can others verify the trace?)

**Phase 5: Cross-Chain Analysis** (newer)
- Track bridges (Wormhole, Stargate, etc.)
- Map DeFi interactions (swaps, yield farming, lending)
- Identify novel obfuscation (cross-chain mixers, atomic swaps)

### Key Principles Federal Agencies Follow
1. **Transparency over cleverness** — every connection must be explainable to a judge/jury
2. **Heuristic confidence levels** — not all inferences are equal; tag certainty
3. **Multiple data sources** — blockchain alone isn't enough; correlate with KYC, exchange APIs, OSINT
4. **Decentralization-aware** — no single source of truth; must handle forks, reorgs, missing data
5. **Regulatory compliance** — findings must hold up in court; sealing, warrants, proper handling

---

## Part 2: Mapping to Helius + AI Stack

### What Helius Provides
- **Solana-native indexing**: token transfers, NFT trades, program interactions, account state
- **RPC enhancement**: DAS (Digital Asset Standard) for NFTs, parsed transactions, rich metadata
- **Webhook system**: real-time alerts when specified addresses transact
- **Balance snapshots**: historical balances at any slot

### Helius Gaps for Federal Forensics
- ❌ No built-in cross-chain support (Ethereum, Bitcoin require separate systems)
- ❌ No entity clustering (all addresses treated as independent)
- ❌ No risk scoring or anomaly detection
- ❌ No OSINT/labeling framework (exchange APIs, sanctioned lists)
- ❌ Limited pattern recognition (need custom logic)

### AI/ML Layer to Bridge Gaps

**Component 1: Entity Clustering Engine**
- Input: Helius transaction graph (addresses, amounts, timestamps)
- Algorithm:
  - Heuristic-based first pass (input/output co-spending, temporal proximity)
  - Embedding-based clustering (represent address behavior as vectors: tx frequency, token types, value ranges)
  - Graph neural networks (learn from labeled examples: known exchange wallets, known services)
- Output: Probabilistic entity groups with confidence scores
- Example: 5 addresses cluster together with 94% confidence as one user

**Component 2: Anomaly Detection**
- Baseline each entity's behavior (e.g., "normally sends $500 USDC to exchange daily")
- Flag deviations:
  - Sudden large tx
  - New recipient address
  - Time-of-day anomaly
  - Token type shift
- Confidence scoring: is this suspicious or normal variance?

**Component 3: Risk Scoring Model**
- Supervised ML trained on known illicit addresses (Chainalysis data, sanctioned lists, FBI intelligence)
- Features:
  - Clustering properties (does this group interact with known bad actors?)
  - Behavioral anomalies (score from Component 2)
  - On-chain footprint (age, interaction diversity, cross-chain activity)
  - Regulatory factors (tokens linked to sanctions, high-risk jurisdictions)
- Output: Risk score 0-100 for each entity cluster
- Confidence interval: "risk 72±8" is more honest than "risk 72"

**Component 4: Pattern Recognition**
- LLM-based summarization of transaction chains
- Generate natural-language narrative: "Entity A withdrew from Exchange B on 3/15, sent to Tornado mixing service, emerged in 4 fragments across 5 addresses, then consolidated at Exchange C"
- Timeline visualization (ASCII or graph)
- Hypothesis generation: "This pattern suggests timing evasion + value fragmentation"

**Component 5: Multi-Chain Bridge Tracking**
- Monitor Wormhole/Stargate events tied to tracked addresses
- Flag cross-chain movements with lag time estimates
- Link back to Helius data when tokens re-enter Solana

---

## Part 3: Architecture (High Level)

```
┌─────────────────────────────────────────────────────────────┐
│                    Federal Forensics Pipeline                │
└─────────────────────────────────────────────────────────────┘

INPUT LAYER
├─ Helius RPC (Solana indexing)
├─ Historical blockchain data (archive node / Helius API)
├─ OSINT sources (exchange lists, sanctioned addresses, public labels)
└─ External APIs (bridge monitoring, DEX routing)

PROCESSING LAYER
├─ Transaction Graph Builder
│  └─ Raw tx → standardized schema (from_addr, to_addr, amt, token, ts)
│
├─ Entity Clustering Engine (AI)
│  ├─ Heuristic clustering (input/output co-spend)
│  ├─ Embedding model (address behavior vectors)
│  └─ Output: probabilistic entity groups
│
├─ Anomaly Detection (ML)
│  ├─ Baseline behavioral profiles per entity
│  └─ Flag deviations with confidence
│
├─ Risk Scoring (Supervised ML)
│  ├─ Train on known illicit/licit examples
│  └─ Score each entity cluster
│
├─ Pattern Recognition (LLM)
│  ├─ Summarize transaction chains
│  └─ Generate narratives + timelines
│
└─ Multi-Chain Linker
   ├─ Track bridges (Wormhole, etc.)
   └─ Link back to Solana graph

OUTPUT LAYER
├─ Investigation Report
│  ├─ Entity summary (name, confidence, risk score)
│  ├─ Transaction narrative (who, what, when, where, how much)
│  ├─ Evidence file (reproducible, chain of custody)
│  └─ Inferences with confidence levels
│
├─ Alert System
│  ├─ New risky tx detected → alert investigator
│  └─ Cross-chain movement detected → alert
│
└─ Dashboard
   ├─ Entity graph visualization
   ├─ Timeline view
   └─ Risk heatmap
```

---

## Part 4: Key Design Decisions

### Decision 1: Confidence Levels
**Federal agencies must show their work.** Every inference needs:
- What data supports it?
- How certain are we (e.g., 85% confident these 5 addresses are one entity)?
- What assumptions did we make?

**Implementation**: Tag every output with:
```json
{
  "inference": "addresses [A, B, C] likely controlled by same entity",
  "confidence": 0.85,
  "basis": "input/output co-spending x3 + temporal proximity <30s",
  "assumptions": "assumes no address reuse across unrelated actors"
}
```

### Decision 2: Auditability
**Every finding must be reproducible.** If we say "Entity X transferred Y tokens to Z," a different analyst running the same code should get the same result.

**Implementation**:
- Snapshot Helius data at query time
- Version all AI models
- Log all hyperparameters
- Store edge cases / manual overrides separately
- Unit tests for clustering logic

### Decision 3: Privacy & Scope
**Track only necessary addresses.** Don't run forensics on every Solana address—focus on:
- Seed addresses (known bad actors, seized wallets, investigation targets)
- 1st/2nd degree neighbors (direct interactions)
- Stop at 3rd degree unless justified

**Implementation**: Explicit allowlist of "investigation targets," then expand graph systematically.

### Decision 4: AI as Assistant, Not Authority
**Humans make the final call.** AI flags anomalies, clusters addresses, generates hypotheses—but investigators must validate and decide.

**Implementation**:
- LLM summaries are suggestions, not conclusions
- Anomaly score 85% doesn't mean "guilty"—it means "worthy of deeper look"
- All risk scores are rebuttable with manual review

---

## Part 5: What We'd Need to Build

(Not building yet—just what's required to ship this)

### Core Infrastructure
1. **Helius Indexer** — query Solana graph, cache locally (Postgres)
2. **Entity Clustering Service** — group addresses, maintain entity state
3. **Risk Scorer** — ML model (trained data TBD), inference API
4. **Anomaly Detector** — baselines + deviation scoring
5. **LLM Summarizer** — narrative generation from tx chains
6. **Bridge Tracker** — monitor Wormhole/Stargate events
7. **Evidence Exporter** — reproducible audit trail

### Data Requirements
- Solana mainnet historical data (via Helius)
- Known entity labels (exchanges, services, sanctioned addresses)
- Training data for risk scoring (Chainalysis, OFAC list, public historical cases)
- Behavioral baselines (normal vs. suspicious for different address types)

### Compliance & Ops
- Chain-of-custody procedures (who accessed what, when)
- Warrant/legal review process (which addresses can we investigate?)
- Regular model retraining (risk profiles evolve)
- Audit logging (all API calls, model updates, manual overrides)

---

## Part 6: Rough Timeline (If We Built This)

| Phase | Effort | Duration | Output |
|-------|--------|----------|--------|
| **Research** | Light | 1 week | Finalize training data, model approach, compliance requirements |
| **MVP** | Medium | 4 weeks | Helius indexer + heuristic clustering + basic risk scoring |
| **Refinement** | Medium | 3 weeks | Anomaly detection, LLM summaries, bridge tracking |
| **Testing & Validation** | Heavy | 2-3 weeks | Backtest against known cases, legal review, audit trail |
| **Operations** | Ongoing | N/A | Model retraining, alert tuning, case analysis |

---

## Part 7: Open Questions (For Decision-Making)

1. **Single-chain vs. multi-chain**: Start Solana-only (Helius advantage), or build cross-chain from day 1?
2. **Training data source**: Use public (Chainalysis, OFAC) or do we have proprietary intel?
3. **Real-time vs. batch**: Webhooks for live alerts, or nightly batch analysis?
4. **UI/UX**: Investigator dashboard or headless API only?
5. **False positive tolerance**: Risk score 60-70 is noisy—what threshold do we use to alert?
6. **Regulatory standing**: Are we building for a federal agency (DOJ/IRS/FBI) or private compliance firm? (Changes legal/technical requirements)

---

## Summary

**Federal approach**: Trace, cluster, score, verify. Transparency and auditability over cleverness.

**Helius fit**: Solana-native data layer (good). Needs AI for clustering, anomaly detection, risk scoring, cross-chain linking (Medium complexity).

**AI role**: Entity clustering (unsupervised → supervised), anomaly detection (statistical baselines), risk scoring (supervised classification), pattern summarization (LLM). Human always validates before conclusions.

**Feasibility**: 8-12 weeks to MVP, 4-6 weeks to production-grade with legal review. Helius API is solid; the hard part is training data + model validation.
