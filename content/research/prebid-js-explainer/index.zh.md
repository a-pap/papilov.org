---
title: "Prebid.js：程序化变现标准的运作机制"
date: 2026-03-27
lastmod: 2026-03-27
version: "2.0"
status: "finished"
confidence: "certain"
description: "深度解析每年处理数万亿次广告拍卖的技术——从机制到商业影响。面向决策者。"
tags: ["adtech", "programmatic", "header-bidding", "prebid", "monetization"]
series: "信息 ≠ 理解"
ai_disclosure: "Research conducted with Claude (Anthropic). Human editorial direction and domain expertise."
license: "CC BY-NC 4.0"
robots: "noindex"
---

程序化广告是一个5950亿美元的市场（2024年），预计到2028年将达到7790亿美元。约90%的数字展示广告通过自动方式购买。在发布商基础设施的核心，是一个被超过10,000家公司使用的开源库：Prebid.js。

本分析面向决策者：Prebid的功能、工作原理、它如何成为行业标准，以及哪些杠杆决定业务结果。

<div class="metrics">
<div class="metric"><div class="val">300+</div><div class="desc">竞价适配器</div></div>
<div class="metric"><div class="val">~90%</div><div class="desc">展示广告 = 程序化</div></div>
<div class="metric"><div class="val">$203B</div><div class="desc">美国程序化广告 2026</div></div>
<div class="metric"><div class="val">10K+</div><div class="desc">使用Prebid的企业</div></div>
</div>

## 问题：瀑布流模式损失收入

发布商历史上通过**瀑布流**销售库存——广告网络按优先级依次调用。第一个接受价格的网络获得展示。其他网络从未参与竞争，即使它们愿意支付更多。

**Header Bidding**解决了这个问题：所有买家同时出价，最高价获胜。Prebid.js是成为浏览器端Header Bidding行业标准的开源库。

<div class="compare">
  <div class="compare-col col-a">
    <h4>瀑布流</h4>
    <div class="compare-item"><strong>网络A（优先级1）</strong><span>$2.00——默认获胜</span></div>
    <div class="compare-item"><strong>网络B（优先级2）</strong><span>从未被询问</span></div>
    <div class="compare-item"><strong>网络C（优先级3）</strong><span>本可出价$5.00——从未被询问</span></div>
    <div class="compare-item"><strong>结果</strong><span>展示以$2.00售出</span></div>
  </div>
  <div class="compare-col col-b">
    <h4>Header Bidding (Prebid)</h4>
    <div class="compare-item"><strong>网络A</strong><span>$2.00</span></div>
    <div class="compare-item"><strong>网络B</strong><span>$3.10</span></div>
    <div class="compare-item"><strong>网络C</strong><span>$5.00——获胜</span></div>
    <div class="compare-item"><strong>结果</strong><span>全部并行竞价 → $5.00获胜（+150%）</span></div>
  </div>
</div>

<div class="metrics">
<div class="metric"><div class="val val--green">+20–50%</div><div class="desc">瀑布流 → Header Bidding提升</div></div>
<div class="metric"><div class="val val--green">+70%</div><div class="desc">The Telegraph（案例研究）</div></div>
<div class="metric"><div class="val val--green">+25–50%</div><div class="desc">CPM提升，Future plc</div></div>
<div class="metric"><div class="val val--green">30–40%</div><div class="desc">平均组合提升（AdPushup）</div></div>
</div>

## 运作方式：约1000毫秒内5个步骤

<div class="flow-steps">
<div class="flow-step"><div><div class="flow-num">1</div><div class="flow-line"></div></div><div class="flow-body"><h4>页面加载 → 拍卖开始</h4><p>Prebid.js识别广告位并同时向所有已连接的买家发送竞价请求。</p><span class="flow-tag">~0ms</span></div></div>
<div class="flow-step"><div><div class="flow-num">2</div><div class="flow-line"></div></div><div class="flow-body"><h4>买家回应出价</h4><p>每个DSP/SSP接收广告位数据并返回出价或放弃。全部并行进行。</p><span class="flow-tag">200–800ms</span></div></div>
<div class="flow-step"><div><div class="flow-num">3</div><div class="flow-line"></div></div><div class="flow-body"><h4>超时淘汰慢速响应者</h4><p>未及时响应者被排除。用户体验保护机制。</p><span class="flow-tag">超时：1000–1500ms</span></div></div>
<div class="flow-step"><div><div class="flow-num">4</div><div class="flow-line"></div></div><div class="flow-body"><h4>最佳出价 → 广告服务器</h4><p>胜出的出价发送到Google Ad Manager，与直接交易和AdX竞争。</p><span class="flow-tag">~50ms</span></div></div>
<div class="flow-step"><div><div class="flow-num">5</div><div class="flow-line"></div></div><div class="flow-body"><h4>广告服务器选择赢家 → 展示广告</h4><p>GAM比较所有来源并投放出价最高的创意素材。</p><span class="flow-tag">总计~1100ms</span></div></div>
</div>

<div class="highlight-box">
<strong>Prebid不会替代广告服务器。</strong>
它在决策<em>之前</em>创造竞争，提高每次展示的有效价格。
</div>

## 市场背景

<div class="metrics">
<div class="metric"><div class="val val--blue">$1.14T</div><div class="desc">全球广告市场 2025</div></div>
<div class="metric"><div class="val val--blue">$595B</div><div class="desc">程序化广告（全球）2024</div></div>
<div class="metric"><div class="val val--blue">$203B</div><div class="desc">美国程序化展示广告 2026</div></div>
</div>

ANA供应链研究（2023年）发现，广告主每花费一美元，只有**36美分**到达发布商手中。到2025年第三季度，这一比例提高到**47.1美分**（+11个百分点），但每年仍有268亿美元因供应链低效而损失。

<div class="dollar-flow">
<div class="dollar-node"><div class="dollar-box">广告主</div><div class="dollar-amt">$1.00</div></div>
<div class="dollar-arr">→</div>
<div class="dollar-node"><div class="dollar-box">DSP + SSP费用</div><div class="dollar-amt" style="color: var(--purple-soft)">−29¢</div><div class="dollar-note">交易费用</div></div>
<div class="dollar-arr">→</div>
<div class="dollar-node"><div class="dollar-box">浪费</div><div class="dollar-amt" style="color: var(--red-soft)">−24¢</div><div class="dollar-note">无效流量、MFA</div></div>
<div class="dollar-arr">→</div>
<div class="dollar-node"><div class="dollar-box">发布商</div><div class="dollar-amt" style="color: var(--green-soft)">47¢</div><div class="dollar-note">原为36¢</div></div>
</div>

<div class="metrics">
<div class="metric"><div class="val val--red">$26.8B</div><div class="desc">年度供应链损失</div></div>
<div class="metric"><div class="val val--green">47.1%</div><div class="desc">发布商份额（原为36%）</div></div>
<div class="metric"><div class="val val--green">0.8%</div><div class="desc">MFA库存（历史最低）</div></div>
<div class="metric"><div class="val val--blue">87.8%</div><div class="desc">PMP份额（原为64.5%）</div></div>
</div>

## Google反垄断：Prebid为何更加重要

2025年4月，美国联邦法院裁定Google非法垄断了发布商广告服务器和广告交易市场。欧盟罚款29.5亿欧元。德克萨斯州和解金额为13.75亿美元。美国司法部寻求剥离AdX。

<div class="metrics">
<div class="metric"><div class="val val--red">~90%</div><div class="desc">Google广告服务器市场份额</div></div>
<div class="metric"><div class="val val--red">€2.95B</div><div class="desc">欧盟罚款</div></div>
<div class="metric"><div class="val val--red">$1.375B</div><div class="desc">德克萨斯州和解金额</div></div>
</div>

> "Google故意实施了一系列反竞争行为，以获取和维持在发布商广告服务器和广告交易市场的垄断地位。"
> — Leonie Brinkema法官，2025年4月17日

对Prebid而言，这是一个**结构性利好**。如果Google必须将其广告服务器与交易平台拆分，厂商中立的拍卖解决方案将成为关键基础设施。

## 三种架构

| 参数 | 客户端 | 服务端 | 混合 |
|------|--------|--------|------|
| 拍卖 | 浏览器 | 服务器 | 两者 |
| 买家数量 | 15–20（上限） | 无限制 | 5–8 + 其余（最优） |
| 延迟 | 随买家增加而增长 | −40% | 可控 |
| Cookie访问 | 完整（最高CPM） | 受限（CPM降低20–40%） | 关键买家完整访问 |
| 最适合 | 中型发布商 | CTV、应用、AMP | 大型发布商 |

<div class="highlight-box">
<strong>混合模式是行业标准：</strong>
5–8个关键买家在客户端 + 其余在服务端。Prebid Server可实现高达40%的延迟降低。
</div>

## 业务杠杆

### 超时：收入与用户体验的平衡

<div class="bars">
  <div class="bar-row"><div class="label">800ms</div><div class="track"><div class="fill" style="width:55%">~55%</div></div><div class="pct">~55%</div></div>
  <div class="bar-row"><div class="label">1000ms ←</div><div class="track"><div class="fill" style="width:75%">~75%</div></div><div class="pct">~75%</div></div>
  <div class="bar-row"><div class="label">1200ms</div><div class="track"><div class="fill" style="width:88%">~88%</div></div><div class="pct">~88%</div></div>
  <div class="bar-row"><div class="label">1500ms</div><div class="track"><div class="fill" style="width:95%">~95%</div></div><div class="pct">~95%</div></div>
</div>

### 价格粒度

| 类型 | 步长 | GAM行项数 | 收入损失 |
|------|------|-----------|----------|
| 低 | $0.50 | ~40 | 最高$0.49（较高） |
| 中 | $0.10 | ~200 | 最高$0.09（中等） |
| 高 | $0.01 | ~2,000 | $0.009（极低） |
| 自定义 | 可变 | 优化 | 可控（推荐） |

### 买家选择：边际递减效应

<div class="bars">
  <div class="bar-row"><div class="label">3个买家</div><div class="track"><div class="fill" style="width:60%">~60%</div></div><div class="pct">~60%</div></div>
  <div class="bar-row"><div class="label">5个买家</div><div class="track"><div class="fill" style="width:80%">~80%</div></div><div class="pct">~80%</div></div>
  <div class="bar-row"><div class="label">8个买家 ←</div><div class="track"><div class="fill" style="width:92%">~92%</div></div><div class="pct">~92%</div></div>
  <div class="bar-row"><div class="label">15个买家</div><div class="track"><div class="fill" style="width:97%">~97%</div></div><div class="pct">~97%</div></div>
  <div class="bar-row muted"><div class="label">20+个买家</div><div class="track"><div class="fill" style="width:99%">~99%</div></div><div class="pct">延迟↑</div></div>
</div>

80%的增量收入来自前5–7个买家。最佳数量：客户端约8个。

## 各地区CPM

平均横幅CPM（SSP端，2024年）：

<div class="bars">
  <div class="bar-row"><div class="label">美国</div><div class="track"><div class="fill" style="width:100%">$1.43</div></div><div class="pct">$1.43</div></div>
  <div class="bar-row"><div class="label">英国</div><div class="track"><div class="fill" style="width:73%">$1.05</div></div><div class="pct">$1.05</div></div>
  <div class="bar-row"><div class="label">德国</div><div class="track"><div class="fill" style="width:63%">$0.90</div></div><div class="pct">$0.90</div></div>
  <div class="bar-row"><div class="label">法国</div><div class="track"><div class="fill" style="width:56%">$0.80</div></div><div class="pct">$0.80</div></div>
  <div class="bar-row"><div class="label">巴西</div><div class="track"><div class="fill" style="width:35%">$0.50</div></div><div class="pct">$0.50</div></div>
  <div class="bar-row"><div class="label">印度</div><div class="track"><div class="fill" style="width:17%">$0.25</div></div><div class="pct">$0.25</div></div>
</div>

8倍的价差决定了变现经济学。2025年第一季度：美国展示广告CPM同比下降33–42%（因创纪录的政治广告年之后）。到2025年12月：展示广告同比+6.3%，视频广告同比+33.2%。这种波动性凸显了动态底价的必要性——这正是Prebid的Floors Module所实现的功能。

## 隐私：后Cookie时代的适应

<div class="badge-list">
<div class="badge-item"><span class="badge-dot" style="background: var(--green-soft)"></span>用户ID — UID2、SharedID、EUID、LiveRamp</div>
<div class="badge-item"><span class="badge-dot" style="background: var(--blue-soft)"></span>第一方数据</div>
<div class="badge-item"><span class="badge-dot" style="background: var(--purple-soft)"></span>Topics API / Protected Audiences</div>
<div class="badge-item"><span class="badge-dot" style="background: var(--yellow-soft)"></span>GDPR / CCPA / GPP 合规授权</div>
</div>

<div class="metrics">
<div class="metric"><div class="val val--blue">40%</div><div class="desc">美国营销人员将第一方数据作为主要定向手段（2025年）</div></div>
<div class="metric"><div class="val val--green">60–80%</div><div class="desc">使用Prebid User ID时CPM保留率（对比无身份识别）</div></div>
</div>

## 超越展示广告

| 格式 | 架构 | 市场 |
|------|------|------|
| 展示广告 | 客户端 + 服务端 | 核心程序化广告 |
| 视频（流内） | 客户端 + 服务端 | 最高CPM |
| 移动应用内 | SDK → 服务端 | 71%为程序化 |
| CTV / OTT | 仅服务端 | 44%份额（2025年Q2），>$45B |
| 零售媒体 | 服务端 | 2026年达$30B+，同比+29% |
| DOOH | 服务端 | 自2019年增长+400% |

<div class="metrics">
<div class="metric"><div class="val val--blue">$110B+</div><div class="desc">美国程序化视频 2026</div></div>
<div class="metric"><div class="val val--blue">44%</div><div class="desc">CTV份额（2025年Q2，原为28%）</div></div>
<div class="metric"><div class="val val--blue">$30B+</div><div class="desc">零售媒体 2026年</div></div>
</div>

## 生态系统与竞争对手

<div class="timeline">
  <div class="tl-item"><div class="tl-dot tl-dot--green"></div><div class="tl-year">2015</div><div class="tl-title">Prebid.js发布（AppNexus + 合作伙伴）</div><div class="tl-desc">开源Header Bidding库正式发布。</div></div>
  <div class="tl-item"><div class="tl-dot tl-dot--green"></div><div class="tl-year">2017</div><div class="tl-title">Prebid Server + 移动SDK</div><div class="tl-desc">新增服务端拍卖和移动端支持。</div></div>
  <div class="tl-item"><div class="tl-dot tl-dot--green"></div><div class="tl-year">2019–20</div><div class="tl-title">美国95%顶级发布商采用Header Bidding</div><div class="tl-desc">Header Bidding成为行业规范。</div></div>
  <div class="tl-item"><div class="tl-dot"></div><div class="tl-year">2021–22</div><div class="tl-title">User ID、Floors、GDPR模块</div><div class="tl-desc">隐私时代的模块扩展了平台功能。</div></div>
  <div class="tl-item"><div class="tl-dot tl-dot--green"></div><div class="tl-year">2024–25</div><div class="tl-title">v11、CTV、300+适配器、PAAPI</div><div class="tl-desc">多格式扩展和后Cookie时代准备就绪。</div></div>
  <div class="tl-item"><div class="tl-dot"></div><div class="tl-year">2025–26</div><div class="tl-title">Google反垄断 → 中立基础设施更加关键</div><div class="tl-desc">法院裁决加速了向厂商中立解决方案的转变。</div></div>
</div>

| 解决方案 | 类型 | 差异化优势 | 锁定程度 |
|----------|------|-----------|----------|
| Prebid.js | 开源 | 中立、可审计 | 无 |
| Amazon TAM | 专有 | 绑定Amazon DSP | 中等 |
| Google Open Bidding | GAM内服务端 | 利益冲突 | 高 |
| Index Exchange | 专有 | 高质量，但依赖供应商 | 中等 |

Prebid与TAM和Open Bidding并行运行。根据Roxot数据，客户端和服务端Header Bidding各产生约22%的程序化收入，而AdX占约56%。

## Prebid的局限性

<div class="psych-grid">
  <div class="psych-card">
    <h4>不优化广告位布局</h4>
    <p>广告位的位置和尺寸是发布商的决策——Prebid处理需求端，而非供给端布局。</p>
  </div>
  <div class="psych-card">
    <h4>不替代广告服务器</h4>
    <p>GAM仍然是直接交易、频次控制和最终决策所必需的。</p>
  </div>
  <div class="psych-card">
    <h4>不解决流量质量问题</h4>
    <p>机器人流量、低可见度和无效流量是Prebid范围之外的根源性问题。</p>
  </div>
  <div class="psych-card">
    <h4>非即插即用</h4>
    <p>这是一个工程工具，需要持续的配置优化和监控。</p>
  </div>
</div>

## 结论

2026年没有Header Bidding意味着放弃**20–40%的程序化收入**。战略问题不是"我们是否需要Prebid"，而是**哪种配置最优**。随着Google反垄断裁决和后Cookie转型，厂商中立的解决方案比以往任何时候都更加重要。

<div class="metrics">
<div class="metric"><div class="val val--green">+20–50%</div><div class="desc">瀑布流 → Header Bidding</div></div>
<div class="metric"><div class="val val--green">+5–15%</div><div class="desc">+ 服务端</div></div>
<div class="metric"><div class="val val--green">+3–10%</div><div class="desc">配置优化</div></div>
</div>

---

### 来源

1. [Prebid.org](https://prebid.org/) 2. [Prebid.js GitHub](https://github.com/prebid/Prebid.js) 3. [ANA Q2 2025](https://www.ana.net/content/show/id/pr-2025-08-programmatictrans) 4. [ANA Q3 2025](https://www.ana.net/content/show/id/pr-2025-11-transparency) 5. [ANA 2023 Study](https://drupal.unglobalcompact.org/cmo-blueprint-for-sustainable-growth/resources/ana-programmatic-media-supply-chain-transparency) 6. [dentsu](https://www.dentsu.com/news-releases/global-ad-spend-set-to-surpass-one-trillion-for-the-first-time-in-2026-as-the-algorithmic-era-redefines-growth) 7. [Basis](https://basis.com/blog/7-programmatic-advertising-trends-shaping-2026) 8. [eMarketer](https://www.emarketer.com/content/worldwide-programmatic-ad-spending-2025) 9. [AsterioBid](https://asteriobid.com/cpm_trends_banners_2024) 10. [DataBeat](https://databeat.io/blog/us-programmatic-trends-december-2025/) 11. [Digiday](https://digiday.com/media/header-bidding-publishers-boosting-cpms-much-50-percent/) 12. [Digiday Research](https://digiday.com/media/digiday-research-header-bidding-and-first-price-auctions-boost-publisher-revenues/) 13. [AdPushup](https://www.adpushup.com/blog/header-bidding-analytics-using-data-to-optimize-your-stack/) 14. [Mile.tech](https://www.mile.tech/blog/prebid-server) 15. [Criteo](https://www.criteo.com/blog/header-bidding-demystified-client-side-vs-server-side/) 16. [US v. Google](https://en.wikipedia.org/wiki/United_States_v._Google_LLC_(2023)) 17. [Axios](https://www.axios.com/2025/04/17/google-ad-tech-monopoly-antitrust-ruling) 18. [Raptive](https://raptive.com/blog/what-the-dojs-ruling-on-google-means-for-creators-and-publishers/) 19. [Kluwer](https://legalblogs.wolterskluwer.com/competition-blog/impact-of-the-ec-decision-on-googles-adtech-stakeholder-analysis-and-remedies/) 20. [Roxot](https://roxot.com/report/sell-side-programmatic-us-2019) 21. [Enlyft](https://enlyft.com/tech/products/prebid) 22. [6sense](https://6sense.com/tech/libraries-and-widgets/prebid-market-share) 23. [Marketing Brew](https://www.marketingbrew.com/stories/2025/12/09/total-global-ad-revenue-grew-nearly-9-in-2025-wpp-media) 24. [Prebid Server Docs](https://docs.prebid.org/dev-docs/pbsBidAdapter-video-overview.html)
