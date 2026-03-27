---
title: "Auction Mechanics: From Christie's to Google Ads"
date: 2026-03-27
lastmod: 2026-03-27
version: "1.0"
status: "in-progress"
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

Every market with a scarce resource is an auction. Auction rules determine not just the price, but the behavior of participants. The same good under different rules yields different prices, different efficiency, and different information distribution. Understanding this reveals the hidden mechanics of markets — from radio frequencies to ad impressions, from cloud computing to carbon allowances.

<div style="margin: 2rem 0; padding: 1.5rem; border: 1px solid var(--border-color); border-radius: 8px; background: var(--bg-secondary);">

**[Open the interactive explainer →](/research/auction-mechanics/infographic.html)**

9 sections: four auction types · bidding math · Revenue Equivalence · the New Zealand disaster · comparison tables · ad auction evolution · auctions in finance · auctions in IT · trends and future.

</div>

## Four Basic Auctions

Every auction in the world is a combination of two variables: open or sealed bids, and whether the winner pays their own price or someone else's.

**English** (Christie's, Sotheby's) — price rises, last bidder standing wins. **Dutch** (Aalsmeer flower auction, Google's 2004 IPO, US Treasury) — price falls, first to accept wins. **First-price sealed-bid** — government procurement, tenders, programmatic advertising since 2019. **Second-price sealed-bid (Vickrey)** — Nobel Prize 1996, the basis of RTB 2007–2017, eBay's proxy bidding mechanism.

Vickrey's key insight: in a second-price auction, the dominant strategy is to bid exactly your true valuation. In first-price — always shade your bid. The Revenue Equivalence Theorem states that **in expectation** (across repeated auctions with random valuations) all four formats yield the same seller revenue. But this holds only under strict conditions: independent valuations, risk neutrality, symmetric bidders, no collusion. In reality, every condition is violated — making format choice a critical decision.

## Ad Auctions: 100 Milliseconds and $500 Billion

Advertising auctions are the most massive in history: trillions of auctions per day. Their 12-year evolution recapitulated the path auction theory traveled over 50 years.

RTB in 2007 started with Vickrey auctions (second-price). In 2014–2015, header bidding (Prebid.js) broke Google's last-look monopoly. By 2017, all major exchanges had switched to first-price. In 2019, Google — the last holdout — dropped second-price in Ad Manager. In 2021, AdSense followed.

The reason: when intermediaries (SSPs, DSPs) sit between buyer and seller, second-price creates opportunities for floor-price manipulation. First-price is simpler and more transparent — but requires algorithmic bid shading, which can take up to 20% of publisher revenue.

## Beyond Advertising

The same auction mechanisms operate in cloud computing (AWS Spot Instances — up to 90% discount through idle capacity auctions), stock exchanges (continuous double auction — $120 trillion/year), carbon markets (EU ETS — €39 billion/year), Ethereum (EIP-1559 replaced pure first-price gas auction with a hybrid), and energy markets (merit order on EPEX SPOT).

One pattern repeats everywhere: start with a pure auction → gradually transition to a hybrid of auction + algorithmic pricing. Pure auctions are too volatile for production systems.

## One Lesson

Rules determine behavior. Behavior determines price. Whoever designs the rules owns the market.

The same radio waves cost between $0.001 and $0.875 per MHz/pop — an 875× difference. The same ad generates 30–40% more or less revenue depending on the auction format. The same carbon costs €5 or €100 — depending on cap-and-trade rules.

An auction is not a gavel at Christie's. It's a model of any market with competition for a scarce resource.

---

*This article is being expanded. Upcoming sections: VCG mechanism and search advertising, combinatorial auctions and the FCC Incentive Auction, AI bidding agents and algorithmic collusion.*
