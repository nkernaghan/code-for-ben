---
name: performance-optimizer
description: Profile, benchmark, and optimize code and systems for speed, latency, and throughput. Specialized for data pipelines, trading systems, and web services.
---

# Performance Optimizer

Profile bottlenecks, benchmark implementations, and optimize code for speed, latency, and resource efficiency. This skill covers profiling methodology, optimization strategies, and validation.

## Optimization Framework

### Phase 1: Measure (Establish Baseline)
- **Profiling:** Where is time spent? (CPU, I/O, memory)
- **Benchmarking:** How fast is it now? (throughput, latency, tail latency)
- **Baseline:** Record before/after metrics

### Phase 2: Analyze (Identify Root Causes)
- **Hotspots:** Which functions consume 80% of time?
- **Bottlenecks:** I/O, computation, memory, network?
- **Inefficiencies:** Redundant work, N+1 queries, poor algorithm?

### Phase 3: Optimize (Apply Improvements)
- **Algorithmic:** Better algorithm (quicksort vs. bubblesort)
- **Caching:** Avoid recomputation
- **Parallelization:** Use multiple cores/threads
- **Infrastructure:** Better hardware, database optimization

### Phase 4: Validate (Confirm Improvements)
- **Rerun benchmarks:** Measure impact
- **Regression tests:** Ensure correctness (optimized code that's broken = useless)
- **Document:** Why this optimization, what's the gain?

## Profiling Tools by Language

### Python
- **cProfile:** CPU profiling (which functions take time?)
- **memory_profiler:** Memory profiling (line-by-line memory usage)
- **py-spy:** Low-overhead sampling profiler (good for production)
- **scalene:** Modern profiler (CPU, memory, GPU)

### JavaScript/Node
- **node --prof:** Built-in CPU profiler
- **clinic.js:** Node.js performance profiling
- **New Relic, DataDog:** APM tools (production profiling)

### Go
- **pprof:** Built-in profiling (CPU, memory, goroutines)
- **go test -bench:** Benchmark comparisons
- **trace:** Detailed execution tracing

### Solana (on-chain)
- **Helius gRPC/LaserStream:** Real-time transaction profiling
- **Solana CLI `--transaction-details`:** Compute unit analysis
- **Local validator logs:** Slot-by-slot performance

## Optimization Strategies

### Algorithmic Optimization
- Replace O(n²) with O(n log n): sorting, searching
- Replace O(n) with O(log n): binary search, hash tables
- Reduce constant factors: vectorization, SIMD

**Example: NCAAB model accuracy**
- Slow: For each team, loop through all opponents (O(n²))
- Fast: Pre-compute opponent ratings in hash table, O(1) lookup

### Caching Strategies
- **Memoization:** Cache function results (avoid recomputation)
- **Redis cache:** Shared cache across services
- **Local cache:** In-process memory (fastest)

**Example: Trading bot signals**
- Slow: Recalculate Torvik diff for every game each day
- Fast: Cache daily Torvik ratings, reuse all day

### I/O Optimization
- **Batch queries:** 1 bulk query > 100 individual queries (N+1 problem)
- **Connection pooling:** Reuse database connections
- **Async I/O:** Fetch data in parallel, not sequentially

**Example: Newsletter content curation**
- Slow: Query each news source one-by-one (wait for each response)
- Fast: Fetch all sources in parallel, aggregate

### Parallelization
- **Multi-threading:** Multiple threads (I/O-bound tasks)
- **Multi-processing:** Multiple processes (CPU-bound tasks)
- **Async/await:** Non-blocking I/O
- **GPU:** Massively parallel computation (rare, specialized)

**Example: Bracket simulation**
- Slow: Run 10,000 simulations sequentially (hours)
- Fast: Split across 8 cores, run 1,250 per core (minutes)

### Database Optimization
- **Indexes:** Fast lookups on frequently queried columns
- **Query optimization:** SELECT * vs. SELECT specific columns
- **Denormalization:** Trade storage for speed (copy data to avoid joins)
- **Partitioning:** Split large tables into smaller pieces

## Benchmarking Best Practices

### Methodology
```python
import time

def benchmark(func, iterations=100):
    start = time.perf_counter()
    for _ in range(iterations):
        func()
    end = time.perf_counter()
    return (end - start) / iterations
```

### Realistic Conditions
- **Warmup runs:** JIT compilation, cache warm-up
- **Multiple iterations:** Average out noise
- **Tail latency:** Measure p99, not just average
- **Real data:** Use production data if possible
- **Varied sizes:** Benchmark with small and large inputs

### Metrics to Report
- **Mean latency:** Average time per operation
- **Tail latency (p95, p99):** Worst-case latency (important for real-time systems)
- **Throughput:** Operations per second
- **Memory usage:** RAM consumed
- **CPU utilization:** % of cores used

## Common Performance Issues

### N+1 Query Problem
```python
# Slow: 101 queries (1 + N)
games = db.query("SELECT * FROM games WHERE season = 2025")
for game in games:
    team_a = db.query("SELECT * FROM teams WHERE id = ?", game.team_a_id)  # +100 queries

# Fast: 2 queries
games = db.query("SELECT * FROM games WHERE season = 2025")
team_ids = [g.team_a_id for g in games]
teams = db.query("SELECT * FROM teams WHERE id IN (?)", team_ids)
```

### Regex in Loops
```python
# Slow: Compile regex 1000s of times
import re
for item in large_list:
    if re.search(r"pattern", item):  # Recompile each time
        pass

# Fast: Compile once, use many times
pattern = re.compile(r"pattern")
for item in large_list:
    if pattern.search(item):  # No recompilation
        pass
```

### Deep Copies vs. Shallow Copies
```python
# Slow: Copying entire object 1000s of times
for i in range(10000):
    copy = deepcopy(large_object)  # Expensive

# Fast: Only copy what you need
for i in range(10000):
    copy = {"field1": large_object["field1"]}  # Cheap
```

## Optimization Checklist

- [ ] Established baseline (before metrics)
- [ ] Profiled to identify hotspots (where is time spent?)
- [ ] Analyzed bottleneck (I/O? computation? memory?)
- [ ] Applied optimization (cache, algorithm, parallelization, etc.)
- [ ] Rerun benchmarks (measured improvement)
- [ ] Regression tested (optimized code is still correct?)
- [ ] Documented (why this optimization? what's the cost?)
- [ ] Monitored in production (still fast? didn't break?)

## When NOT to Optimize

❌ **Premature optimization:** Optimize after profiling, not before
❌ **Wrong bottleneck:** Spending weeks optimizing 5% of runtime
❌ **Readability sacrifice:** Code so optimized it's unmaintainable
❌ **Micro-optimizations:** Saving 1ms when problem is 100ms doesn't matter
❌ **No regression testing:** Optimizations introduce bugs

## Common Pitfalls

❌ **Over-optimization:** Diminishing returns (last 10% takes 90% of effort)
❌ **Single-threaded benchmarking:** Multi-core systems have different characteristics
❌ **Ignoring garbage collection:** GC pauses can dominate latency
❌ **Cache misses:** CPU cache is fast; RAM is slow (50-100x difference)

## Reporting Improvements

**Template:**
```
Optimization: [Name]
Bottleneck: [What was slow]
Improvement: [Before] → [After]
Impact: [% faster, latency reduction, throughput increase]
Cost: [Additional memory? Complexity increase?]
Validation: [Regression tested? Production metrics?]
```

**Example:**
```
Optimization: Batch query for team ratings
Bottleneck: N+1 queries (1 per game per day)
Improvement: 100 individual queries → 1 batch query
Impact: 50ms per game → 2ms (25x faster)
Cost: Minimal (no additional memory)
Validation: Scores match original, no regressions
```
