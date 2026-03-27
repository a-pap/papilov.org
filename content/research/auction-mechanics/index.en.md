---
title: "Auction Mechanics: From Christie's to Google Ads"
date: 2026-03-27
lastmod: 2026-03-27
version: "2.0"
status: "finished"
confidence: "likely"
description: "Four auction formats, two Nobel Prizes, one theorem — and why the rules of bidding determine price, not the other way around. From Christie's and 5G spectrum to programmatic advertising and EU ETS."
tags: ["economics", "auction-theory", "programmatic", "mechanism-design", "game-theory"]
series: "Information ≠ Understanding"
ai_disclosure: "Research conducted with Claude (Anthropic). Human editorial direction and domain expertise."
license: "CC BY-NC 4.0"
---

New Zealand, 1990. The government hires consulting firm NERA to design a radio spectrum auction. NERA recommends the Vickrey auction — a format whose theoretical foundations would earn a Nobel Prize six years later. Expected revenue: NZ$250 million. Actual revenue: NZ$36 million. One bidder offered NZ$100,000 and paid NZ$6. Another bid NZ$7 million and paid NZ$5,000.

One wrong choice of auction format cost the treasury NZ$214 million.

In 2019, Google changed the auction format for the $48 billion programmatic advertising market. In 2021, the FCC raised $81 billion in a C-band spectrum auction — a world record. The EU ETS has generated €245 billion from auctioning the right to pollute since 2013. In every case, it wasn't the good that determined the price — **the auction rules determined the price**.

## Four Basic Auctions

Every auction in the world is a combination of two variables: open or sealed bids, and whether the winner pays their own price or someone else's.

<div class="compare">
  <div class="compare-col col-a">
    <h4>First-Price (pay your bid)</h4>
    <div class="compare-item"><strong>Dutch (open, descending)</strong><span>Price falls from ceiling. First to say "stop" wins and pays current price. Strategy: wait longer = cheaper, but risk losing.</span></div>
    <div class="compare-item"><strong>Sealed first-price (closed)</strong><span>Tenders, government procurement, programmatic ads since 2019. All submit bids in sealed envelopes. Highest wins. Strategy: bid shading — bid below true value.</span></div>
  </div>
  <div class="compare-col col-b">
    <h4>Second-Price (pay 2nd bid)</h4>
    <div class="compare-item"><strong>English (open, ascending)</strong><span>Christie's, Sotheby's. Price rises. Last bidder standing wins and pays just above second-highest. Strategy: bid up to your true valuation, no higher.</span></div>
    <div class="compare-item"><strong>Vickrey (sealed second-price)</strong><span>Nobel Prize 1996. Highest bid wins, but pays second price. eBay's proxy bidding. Dominant strategy: bid exactly your true valuation.</span></div>
  </div>
</div>

<div class="highlight-box">
<strong>Strategic equivalence:</strong>
Dutch ≈ Sealed first-price (same strategy, different pacing). English ≈ Vickrey (same outcome — winner pays ~second valuation). Two pairs that look different but are strategically identical.
</div>

## How It Works: One Item, Three Prices

Three bidders value a painting at $100, $80, and $50. What happens under different rules?

<div class="fw-grid">
  <div class="fw-card fw-card--red">
    <h4>First-Price Sealed</h4>
    <div class="fw-sub">Optimal bid with n=3: b(v) = v × ⅔</div>
    <ul class="fw-list">
      <li>Bidder A: values $100, bids $67 — wins</li>
      <li>Bidder B: values $80, bids $53</li>
      <li>Bidder C: values $50, bids $33</li>
      <li>Seller receives: $67</li>
    </ul>
  </div>
  <div class="fw-card fw-card--green">
    <h4>Vickrey (Second-Price)</h4>
    <div class="fw-sub">Dominant strategy: bid your true value</div>
    <ul class="fw-list">
      <li>Bidder A: values $100, bids $100 — wins</li>
      <li>Bidder B: values $80, bids $80</li>
      <li>Bidder C: values $50, bids $50</li>
      <li>Seller receives: $80 (second bid)</li>
    </ul>
  </div>
  <div class="fw-card fw-card--blue">
    <h4>English (Open Ascending)</h4>
    <div class="fw-sub">Price rises until one bidder remains</div>
    <ul class="fw-list">
      <li>C drops out at $50</li>
      <li>B drops out at $80</li>
      <li>A wins, pays $81 (one step above B)</li>
      <li>Seller receives: ≈$80</li>
    </ul>
  </div>
</div>

### Bidding Formulas

<div class="psych-grid">
  <div class="psych-card">
    <h4>Second-Price (Vickrey)</h4>
    <p>b(v) = v. Bid your true value. Always. Dominant strategy — independent of number of participants and their behavior.</p>
    <div class="big">b(v) = v</div>
  </div>
  <div class="psych-card">
    <h4>First-Price (Sealed)</h4>
    <p>b(v) = v × (n−1)/n. With 2 bidders: shade 50%. With 10: shade 10%. More competition → more aggressive bids.</p>
    <div class="big">b = v·(n−1)/n</div>
  </div>
</div>

### Revenue Equivalence Theorem

<div class="highlight-box">
<strong>E[Revenue<sub>FP</sub>] = E[Revenue<sub>SP</sub>] = (n−1)/(n+1)</strong>
With n bidders drawing values from U[0,1], the <em>expected</em> seller revenue is identical across all four formats. The key word is expected: in any single auction prices differ, but across many they converge. Vickrey 1961 (2 bidders), Riley & Samuelson 1981 (general case) → Nobel Prize 1996.
</div>

**Conditions:** independent private values, risk neutrality, symmetric bidders, no collusion. In reality, every condition is violated — making format choice a critical decision.

| Condition | If holds | If violated | Real example |
|-----------|----------|-------------|--------------|
| Independent private values | All formats equal | English yields more (less winner's curse) | Oil exploration: correlated values |
| Risk neutrality | RE works | First-price yields more (risk-averse bidders shade less) | Government contracts |
| Symmetric bidders | RE works | Strong bidder shades more; weak overbids | NZ 1990: incumbent vs newcomer |
| No collusion | RE works | Second-price → floor manipulation. English → ring bidding | Header bidding SSPs |

## The New Zealand Disaster

<div class="metrics">
<div class="metric"><div class="val val--red">NZ$250M</div><div class="desc">expected revenue</div></div>
<div class="metric"><div class="val val--red">NZ$36M</div><div class="desc">actual revenue</div></div>
<div class="metric"><div class="val val--red">86%</div><div class="desc">revenue lost</div></div>
</div>

Specific lots:

| Lot | Bid | Paid | Discount |
|-----|-----|------|----------|
| Radio frequency license | NZ$100,000 | NZ$6 | 99.994% |
| Radio frequency license | NZ$7,000,000 | NZ$5,000 | 99.93% |
| National cellular license | NZ$101,000,000 | NZ$11,000,000 | 89.1% |
| Sky Network TV, Lot 1 | NZ$2,371,000 | NZ$401,000 | 83.1% |

<div class="highlight-box">
<strong>Three design errors:</strong>
(1) No minimum price (reserve price) — you could bid $6. (2) Sold identical licenses through separate Vickrey auctions instead of a unified uniform-price auction. (3) Asymmetric participants (incumbents vs newcomers) — revenue equivalence breaks down.
</div>

## Comprehensive Format Comparison

| Parameter | English (ascending) | Dutch (descending) | First-Price (sealed) | Vickrey (second-price) |
|-----------|--------------------|--------------------|---------------------|----------------------|
| Strategy | Bid up to v | Bid shading | Bid shading | b(v) = v (dominant) |
| Winner pays | ≈ 2nd valuation | Own bid | Own bid | 2nd bid |
| Info revealed | High — see bids | Low — one price | Zero | Medium — 2 prices |
| Speed | Slow (minutes–hours) | Very fast | One round | One round |
| Collusion resistance | Low — visible bidding | High | High | Medium |
| Winner's curse | Less dangerous | Dangerous | Most dangerous | Absent — pay 2nd price |
| Used in | Christie's, eBay, FCC SMRA | Aalsmeer flowers, Google IPO, Treasury | Procurement, tenders, programmatic (2019+) | RTB (2007–2017), Google Ads (GSP variant) |

## Ad Auctions: 100 Milliseconds and $500 Billion

Advertising auctions are the most massive in history: trillions of auctions per day. Their 12-year evolution recapitulated the path auction theory traveled over 50 years.

<div class="timeline">
  <div class="tl-item"><div class="tl-dot tl-dot--green"></div><div class="tl-year">2007</div><div class="tl-title">RTB and second-price auctions</div><div class="tl-desc">Birth of programmatic: SSPs run real-time Vickrey auctions. Highest bidder wins and pays second price + $0.01. Truthful bidding — everyone bids their true value.</div></div>
  <div class="tl-item"><div class="tl-dot tl-dot--red"></div><div class="tl-year">~2012</div><div class="tl-title">Waterfall: cascade of inefficiency</div><div class="tl-desc">Publishers call ad networks sequentially: Google first, then rest. An $8 bid from the third SSP never beats the $5 price from the first — it's never seen. Loss: 20–40% of revenue.</div></div>
  <div class="tl-item"><div class="tl-dot tl-dot--green"></div><div class="tl-year">2014–15</div><div class="tl-title">Header bidding: simultaneous auctions</div><div class="tl-desc">Revolution. All SSPs receive bid requests simultaneously. Prebid.js (2015, open source) becomes the standard. 84% of top 10K US sites. RPM growth 30–40%. Sequential → simultaneous auction.</div></div>
  <div class="tl-item"><div class="tl-dot tl-dot--green"></div><div class="tl-year">2017</div><div class="tl-title">Exchanges switch to first-price</div><div class="tl-desc">OpenX, Rubicon Project and others drop second-price. Reason: in header bidding, second-price enables SSP floor-price manipulation. First-price is simpler and more transparent.</div></div>
  <div class="tl-item"><div class="tl-dot tl-dot--green"></div><div class="tl-year">2019</div><div class="tl-title">Google Ad Manager → unified first-price</div><div class="tl-desc">Google — the last major exchange. Eliminates "last look" privilege. Unified auction = one first price for all. Bid shading becomes mandatory. The $48B market shifts overnight.</div></div>
  <div class="tl-item"><div class="tl-dot"></div><div class="tl-year">2021</div><div class="tl-title">AdSense → first-price. Full circle.</div><div class="tl-desc">The last second-price bastion in Google falls. Theory said second-price → truthful. Practice: first-price + bid shading. Bid shading can take up to 20% of publisher revenue.</div></div>
</div>

<div class="highlight-box">
<strong>Summary:</strong>
Ad industry traveled from Vickrey (2007) to first-price (2019) in 12 years — for the same reasons Vickrey described in 1961: when values correlate, bidders are asymmetric, and intermediaries exist, second-price creates manipulation opportunities. The theory wasn't wrong — the conditions of application were.
</div>

## Auctions in Finance

Financial markets are auctions with different names. Treasury, IPO, buyback — the same mechanisms everywhere.

<div class="fw-grid">
  <div class="fw-card fw-card--blue">
    <h4>US Treasury Bills</h4>
    <div class="fw-sub">Dutch / uniform-price auction</div>
    <div class="fw-tags"><span>$23T+ debt</span></div>
    <ul class="fw-list">
      <li>Fed NY sells government bonds via Dutch auction</li>
      <li>Primary dealers bid with desired yield</li>
      <li>All winners pay a single price</li>
    </ul>
  </div>
  <div class="fw-card fw-card--green">
    <h4>Google IPO, 2004</h4>
    <div class="fw-sub">Modified Dutch auction</div>
    <div class="fw-tags"><span>$1.67B raised</span></div>
    <ul class="fw-list">
      <li>Investors specified price and volume</li>
      <li>Final price $85 — uniform for all</li>
      <li>First day: +18%. Goal: minimize underpricing</li>
    </ul>
  </div>
  <div class="fw-card fw-card--purple">
    <h4>Stock Exchanges</h4>
    <div class="fw-sub">Continuous double auction</div>
    <div class="fw-tags"><span>~$120T/year</span></div>
    <ul class="fw-list">
      <li>NYSE, NASDAQ — buyers and sellers bid simultaneously</li>
      <li>Trade on bid/ask intersection</li>
      <li>Billions of trades daily</li>
    </ul>
  </div>
</div>

<div class="fw-grid">
  <div class="fw-card fw-card--red">
    <h4>EU ETS Carbon Market</h4>
    <div class="fw-sub">Sealed uniform-price</div>
    <div class="fw-tags"><span>€245B since 2013</span><span>€39B/year</span></div>
    <ul class="fw-list">
      <li>Weekly auctions on EEX exchange</li>
      <li>Average 2024 price: €65/tCO₂ (peak 2023: €100+)</li>
      <li>599M allowances sold in 2024</li>
    </ul>
  </div>
  <div class="fw-card fw-card--blue">
    <h4>Energy Markets</h4>
    <div class="fw-sub">Uniform-price merit order</div>
    <div class="fw-tags"><span>€60–300/MWh</span></div>
    <ul class="fw-list">
      <li>EPEX SPOT (Europe), PJM (US): hourly bids</li>
      <li>Cheapest sources (solar, wind) first, then expensive (gas)</li>
      <li>Marginal price = last generator activated</li>
    </ul>
  </div>
  <div class="fw-card fw-card--green">
    <h4>FCC Spectrum Auctions</h4>
    <div class="fw-sub">SMRA (Milgrom-Wilson design)</div>
    <div class="fw-tags"><span>$81B record</span></div>
    <ul class="fw-list">
      <li>C-band auction 2021 — world record</li>
      <li>Nobel Prize 2020 for auction design</li>
      <li>Simultaneous multiple round auction</li>
    </ul>
  </div>
</div>

## Auctions in Technology

<div class="fw-grid">
  <div class="fw-card fw-card--blue">
    <h4>AWS Spot Instances</h4>
    <div class="fw-sub">Up to 90% discount on idle EC2 capacity</div>
    <ul class="fw-list">
      <li>Since 2009: auction for unused compute</li>
      <li>In 2017 switched from pure auction to smoothed pricing</li>
      <li>Interruption: 30 sec – 2 min notice</li>
    </ul>
  </div>
  <div class="fw-card fw-card--purple">
    <h4>Ethereum Gas (EIP-1559)</h4>
    <div class="fw-sub">First-price → hybrid mechanism</div>
    <ul class="fw-list">
      <li>Pre-2021: pure first-price auction for block space</li>
      <li>Post-EIP-1559: base fee (algorithmic) + priority tip</li>
      <li>36% reduction in fee volatility</li>
    </ul>
  </div>
  <div class="fw-card fw-card--green">
    <h4>Domain Auctions</h4>
    <div class="fw-sub">English auction + reserve price</div>
    <ul class="fw-list">
      <li>GoDaddy, NameJet, DropCatch for expired domains</li>
      <li>voice.com sold for $30M (2019)</li>
      <li>Premium domains via sealed-bid on Sedo/Afternic</li>
    </ul>
  </div>
</div>

<div class="highlight-box">
<strong>Pattern:</strong>
The same evolution repeats everywhere. Start with a pure auction (AWS Spot 2009, Ethereum pre-1559, programmatic 2007). Over time, transition to a hybrid: auction mechanism + algorithmic pricing. Pure auctions are too volatile for production systems. Stability beats theoretical optimality.
</div>

## Where Auctions Are Heading

| Trend | Timeframe | Description |
|-------|-----------|-------------|
| AI Bidding Agents | Now → 2027 | ML algorithms already do bid shading (Google, TTD). Next: autonomous agents trading without humans. Risk: algorithmic collusion. |
| Privacy-Preserving Auctions | Now → 2028 | Apple ATT, Privacy Sandbox, EU DSA — user data disappearing. On-device bidding, federated auctions, contextual signals. |
| Combinatorial Auctions | 2025+ | FCC Incentive Auction (2017) — first major combinatorial auction. NP-hard, solved with SAT-solvers. Next: 5G/6G shared spectrum. |
| Dynamic Mechanism Design | 2026+ | Classical theory covers one-shot auctions. Reality: billions of repeated auctions with learning participants. |
| Real-Time Energy Markets | 2025+ | P2P electricity auctions between households. Pilots in Australia (Power Ledger), Germany (Sonnen). |
| Auctions → Automatic Markets | Long-term | AWS Spot is no longer an auction — it's algorithmic pricing. Pure auctions dissolve into dynamic pricing. The foundation — auction theory — remains. |

### Evolution: From Gavel to Algorithm

| Era | Mechanism | Speed | Participants | Example |
|-----|-----------|-------|-------------|---------|
| Pre-20th century | English, Dutch | Minutes–hours | People in a room | Christie's (1766), Aalsmeer (1911) |
| 1960–1990 | Sealed-bid, Vickrey | Days–weeks | Companies + governments | NZ Spectrum 1990, US Treasury |
| 1994–2010 | SMRA, combinatorial | Weeks–months | Telecoms + regulators | FCC Auctions (Milgrom/Wilson) |
| 2007–2019 | RTB second → first-price | 100ms | DSP/SSP algorithms | Programmatic, header bidding |
| 2020+ | ML bid agents + hybrid | Microseconds | AI vs AI | Auto-bidding, Spot pricing, EIP-1559 |

## One Lesson

Rules determine behavior. Behavior determines price. **Whoever designs the rules owns the market.**

The same radio waves cost between $0.001 and $0.875 per MHz/pop — an 875× difference. The same ad generates 30–40% more or less revenue depending on the auction format. The same carbon costs €5 or €100 — depending on cap-and-trade rules.

An auction is not a gavel at Christie's. It's a model of any market with competition for a scarce resource.
