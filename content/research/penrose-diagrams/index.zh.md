---
title: "彭罗斯图"
date: 2026-03-22
lastmod: 2026-03-23
version: "2.0"
status: "finished"
confidence: "certain"
description: "如何将无限的时空放在一张有限的纸上——以及为什么这很重要。共形图的视觉指南：闵可夫斯基、史瓦西、德西特、反德西特。"
tags: ["物理学", "广义相对论", "彭罗斯图", "黑洞", "宇宙学"]
series: "物理学解读"
ai_disclosure: "研究由Claude（Anthropic）辅助完成。编辑方向与领域专业知识由作者提供。"
license: "CC BY-NC 4.0"
robots: "noindex"
---

时空是无限的。光可以永远传播。黑洞将一个点压缩到零。如何在一张有限的纸上画出这一切？

罗杰·彭罗斯在1960年代初给出的答案：共形紧化。一种数学变换，将无穷远压缩为有限的点和线，同时保留因果物理中唯一重要的东西——光锥结构。

这一工具如此强大，以至于它现在出现在广义相对论几乎每一个重大成果中——从奇点定理到全息原理，从时空分类到引力波携带能量的证明。

## 问题

到1960年代初，广义相对论陷入了危机。史瓦西在1916年找到了他的黑洞解，但它假设完美的球对称——自然界中从未出现的条件。大多数物理学家，包括爱因斯坦，都认为任何实际偏差都会阻止奇点形成。黑洞是否真实存在，还是仅仅是理想化数学的产物？这个问题悬而未决近50年。

问题在于：现有工具无法处理时空的全局结构。要理解"无穷远处"发生了什么，需要一次看到整个时空。

## 灵感

方法在三个关键时刻汇聚：1963年《物理评论快报》的一篇短文，同年勒乌什暑期学校的三场详细讲座，以及1965年的奇点定理——诺贝尔委员会后来称之为"自爱因斯坦以来对广义相对论最重要的贡献"。

定理的关键在1964年秋天伦敦的一次散步中出现。彭罗斯与同事伊沃尔·罗宾逊走到一个路口，停下交谈看交通——就在那一刻，"被困表面"的概念闪入他的脑海。这个想法，结合共形方法，证明了广义相对论中奇点的不可避免性。

## 工作原理

如果只关心因果性，就不需要保留距离——只需保留光锥结构。共形变换将度规重新标度一个因子Ω²，保持角度不变。光仍以45°行进。无穷远被压缩为有限边界。无限时空装入有限图表，因果结构完好无损。

## 所有图的五条规则

<div class="metrics">
  <div class="metric"><div class="val">↑</div><div class="desc">时间向上流动</div></div>
  <div class="metric"><div class="val">↔</div><div class="desc">空间水平延伸</div></div>
  <div class="metric"><div class="val">45°</div><div class="desc">光始终以45°行进</div></div>
  <div class="metric"><div class="val">&gt;45°</div><div class="desc">有质量物体：更陡的路径</div></div>
  <div class="metric"><div class="val">S²</div><div class="desc">每个点代表一个2-球面</div></div>
</div>

## 四种基本时空

**闵可夫斯基——菱形。** 平坦时空，无引力。五个边界组件：类时未来和过去无穷（i⁺, i⁻），类空无穷（i⁰），以及类光未来和过去无穷（I⁺, I⁻）——光线抵达和起源的表面。引力波能量在I⁺上定义——这个概念只有通过彭罗斯的共形边界才变得严格。

<div style="text-align:center; margin: 2rem 0; padding: 1.5rem; background: var(--bg-secondary); border: 1px solid var(--border); border-radius: 8px;">
<svg viewBox="0 0 460 500" xmlns="http://www.w3.org/2000/svg" style="max-width: 420px; width: 100%;">
  <defs>
    <marker id="arr" markerWidth="6" markerHeight="4" refX="6" refY="2" orient="auto">
      <polygon points="0 0, 6 2, 0 4" fill="var(--text-tertiary)"/>
    </marker>
  </defs>
  <polygon points="230,40 410,250 230,460 50,250" fill="var(--bg-secondary)" stroke="var(--blue-soft)" stroke-width="1.5" opacity="0.7"/>
  <line x1="230" y1="40" x2="410" y2="250" stroke="var(--red-soft)" stroke-width="2" opacity="0.7"/>
  <line x1="230" y1="40" x2="50" y2="250" stroke="var(--red-soft)" stroke-width="2" opacity="0.7"/>
  <line x1="50" y1="250" x2="230" y2="460" stroke="var(--blue-soft)" stroke-width="2" opacity="0.7"/>
  <line x1="410" y1="250" x2="230" y2="460" stroke="var(--blue-soft)" stroke-width="2" opacity="0.7"/>
  <line x1="230" y1="450" x2="230" y2="50" stroke="var(--text-tertiary)" stroke-width="1" marker-end="url(#arr)" opacity="0.4"/>
  <line x1="60" y1="250" x2="400" y2="250" stroke="var(--text-tertiary)" stroke-width="1" marker-end="url(#arr)" opacity="0.4"/>
  <circle cx="230" cy="300" r="4" fill="var(--text-secondary)" opacity="0.9"/>
  <line x1="230" y1="300" x2="310" y2="220" stroke="var(--text-secondary)" stroke-width="1.5" stroke-dasharray="5,4" opacity="0.5"/>
  <line x1="230" y1="300" x2="150" y2="220" stroke="var(--text-secondary)" stroke-width="1.5" stroke-dasharray="5,4" opacity="0.5"/>
  <polygon points="230,300 310,220 150,220" fill="var(--text-tertiary)" opacity="0.06" stroke="none"/>
  <path d="M 230,420 Q 245,350 240,300 Q 235,250 230,80" fill="none" stroke="var(--text)" stroke-width="1.5" opacity="0.3" stroke-dasharray="2,3"/>
  <circle cx="230" cy="40" r="5" fill="var(--red-soft)"/>
  <text x="230" y="28" text-anchor="middle" font-family="var(--font-body)" font-size="14" fill="var(--red-soft)" font-style="italic">i⁺</text>
  <text x="230" y="16" text-anchor="middle" font-family="var(--font-mono)" font-size="9" fill="var(--text-tertiary)">未来类时 ∞</text>
  <circle cx="230" cy="460" r="5" fill="var(--blue-soft)"/>
  <text x="230" y="482" text-anchor="middle" font-family="var(--font-body)" font-size="14" fill="var(--blue-soft)" font-style="italic">i⁻</text>
  <text x="230" y="496" text-anchor="middle" font-family="var(--font-mono)" font-size="9" fill="var(--text-tertiary)">过去类时 ∞</text>
  <circle cx="410" cy="250" r="5" fill="var(--text-secondary)"/>
  <text x="432" y="245" font-family="var(--font-body)" font-size="14" fill="var(--text-secondary)" font-style="italic">i⁰</text>
  <text x="432" y="260" font-family="var(--font-mono)" font-size="9" fill="var(--text-tertiary)">类空 ∞</text>
  <circle cx="50" cy="250" r="5" fill="var(--text-secondary)"/>
  <text x="28" y="245" text-anchor="end" font-family="var(--font-body)" font-size="14" fill="var(--text-secondary)" font-style="italic">i⁰</text>
  <text x="340" y="135" font-family="var(--font-body)" font-size="13" fill="var(--red-soft)" font-style="italic" transform="rotate(-45,340,135)">I⁺</text>
  <text x="120" y="135" font-family="var(--font-body)" font-size="13" fill="var(--red-soft)" font-style="italic" transform="rotate(45,120,135)">I⁺</text>
  <text x="340" y="370" font-family="var(--font-body)" font-size="13" fill="var(--blue-soft)" font-style="italic" transform="rotate(45,340,370)">I⁻</text>
  <text x="120" y="370" font-family="var(--font-body)" font-size="13" fill="var(--blue-soft)" font-style="italic" transform="rotate(-45,120,370)">I⁻</text>
  <text x="316" y="216" font-family="var(--font-mono)" font-size="9" fill="var(--text-secondary)">光线 (45°)</text>
  <text x="245" y="314" font-family="var(--font-mono)" font-size="9" fill="var(--text-secondary)">事件</text>
  <text x="236" y="62" font-family="var(--font-mono)" font-size="9" fill="var(--text-tertiary)">t</text>
  <text x="396" y="264" font-family="var(--font-mono)" font-size="9" fill="var(--text-tertiary)">r</text>
  <text x="40" y="150" font-family="var(--font-mono)" font-size="9" fill="var(--text-tertiary)" transform="rotate(-90,40,150)">r = 0（原点）</text>
</svg>
<div style="font-size: 0.78rem; color: var(--text-tertiary); margin-top: 0.5rem;">平坦闵可夫斯基时空。菱形将整个无限时空压缩为有限图形。光锥始终为45°。五个边界组件——i⁺、i⁻、i⁰、I⁺、I⁻——编码了渐近结构。</div>
</div>

**史瓦西——锯齿奇点。** 非旋转黑洞。图表揭示了坐标掩盖了数十年的事实：r = 0处的奇点不是空间中的一个点，而是时间中的一个时刻。一旦穿过事件视界（45°线），无论朝哪个方向移动，奇点都在你的未来。最大延拓揭示了爱因斯坦-罗森桥——关闭速度快于光。

<div style="text-align:center; margin: 2rem 0; padding: 1.5rem; background: var(--bg-secondary); border: 1px solid var(--border); border-radius: 8px;">
<svg viewBox="0 0 320 400" xmlns="http://www.w3.org/2000/svg" style="max-width: 300px; width: 100%;">
  <polygon points="160,40 300,200 160,200 160,40" fill="var(--blue-soft)" opacity="0.05" stroke="none"/>
  <polygon points="160,200 300,200 160,360 160,200" fill="var(--blue-soft)" opacity="0.05" stroke="none"/>
  <polygon points="20,40 160,40 160,200 20,200" fill="var(--red-soft)" opacity="0.05" stroke="none"/>
  <line x1="20" y1="40" x2="160" y2="40" stroke="var(--red-soft)" stroke-width="3"/>
  <path d="M 25,40 L 35,35 L 45,45 L 55,35 L 65,45 L 75,35 L 85,45 L 95,35 L 105,45 L 115,35 L 125,45 L 135,35 L 145,45 L 155,40" fill="none" stroke="var(--red-soft)" stroke-width="1.5"/>
  <text x="90" y="30" text-anchor="middle" font-family="var(--font-mono)" font-size="10" fill="var(--red-soft)">奇点 (r = 0)</text>
  <line x1="160" y1="40" x2="160" y2="360" stroke="var(--text-secondary)" stroke-width="1.5" stroke-dasharray="6,4"/>
  <text x="172" y="120" font-family="var(--font-mono)" font-size="9" fill="var(--text-secondary)">事件</text>
  <text x="172" y="132" font-family="var(--font-mono)" font-size="9" fill="var(--text-secondary)">视界</text>
  <line x1="160" y1="40" x2="300" y2="200" stroke="var(--blue-soft)" stroke-width="1" opacity="0.4"/>
  <line x1="300" y1="200" x2="160" y2="360" stroke="var(--blue-soft)" stroke-width="1" opacity="0.4"/>
  <line x1="20" y1="200" x2="160" y2="360" stroke="var(--blue-soft)" stroke-width="1" opacity="0.4"/>
  <line x1="20" y1="200" x2="20" y2="40" stroke="var(--red-soft)" stroke-width="1" opacity="0.3"/>
  <circle cx="300" cy="200" r="4" fill="var(--text-secondary)"/>
  <text x="310" y="203" font-family="var(--font-mono)" font-size="10" fill="var(--text-secondary)">i⁰</text>
  <circle cx="160" cy="360" r="4" fill="var(--blue-soft)"/>
  <text x="160" y="378" text-anchor="middle" font-family="var(--font-mono)" font-size="10" fill="var(--blue-soft)">i⁻</text>
  <text x="80" y="130" text-anchor="middle" font-family="var(--font-body)" font-size="14" fill="var(--red-soft)" font-style="italic" opacity="0.6">II</text>
  <text x="80" y="148" text-anchor="middle" font-family="var(--font-mono)" font-size="8" fill="var(--red-soft)" opacity="0.4">黑洞内部</text>
  <text x="230" y="200" text-anchor="middle" font-family="var(--font-body)" font-size="14" fill="var(--blue-soft)" font-style="italic" opacity="0.6">I</text>
  <text x="230" y="218" text-anchor="middle" font-family="var(--font-mono)" font-size="8" fill="var(--blue-soft)" opacity="0.4">外部区域</text>
  <path d="M 250,320 Q 200,240 120,100" fill="none" stroke="var(--text)" stroke-width="1.2" opacity="0.3" stroke-dasharray="2,3"/>
  <text x="252" y="318" font-family="var(--font-mono)" font-size="8" fill="var(--text-tertiary)">下落物体</text>
</svg>
<div style="font-size: 0.78rem; color: var(--text-tertiary); margin-top: 0.5rem;">史瓦西黑洞。事件视界为虚线45°线。越过它之后，所有路径都通向顶部的锯齿奇点。无法逃脱——不是因为速度不够快，而是因为奇点在你的未来。</div>
</div>

**德西特——方形宇宙。** 正宇宙学常数——我们宇宙的大致未来。方形图表，类空边界：宇宙在所有地方同时开始和结束。自1998年以来，我们知道宇宙正朝德西特未来演化（2011年诺贝尔奖）。

<div style="text-align:center; margin: 2rem 0; padding: 1.5rem; background: var(--bg-secondary); border: 1px solid var(--border); border-radius: 8px;">
<svg viewBox="0 0 320 320" xmlns="http://www.w3.org/2000/svg" style="max-width: 300px; width: 100%;">
  <rect x="40" y="40" width="240" height="240" fill="var(--blue-soft)" opacity="0.04" stroke="var(--blue-soft)" stroke-width="1" stroke-opacity="0.2"/>
  <line x1="40" y1="40" x2="280" y2="40" stroke="var(--red-soft)" stroke-width="3" opacity="0.7"/>
  <line x1="40" y1="280" x2="280" y2="280" stroke="var(--blue-soft)" stroke-width="3" opacity="0.7"/>
  <line x1="160" y1="280" x2="160" y2="40" stroke="var(--text)" stroke-width="1.5" stroke-dasharray="4,4" opacity="0.25"/>
  <circle cx="160" cy="160" r="4" fill="var(--text)">
    <animate attributeName="r" values="3;5;3" dur="2s" repeatCount="indefinite"/>
  </circle>
  <line x1="40" y1="160" x2="160" y2="40" stroke="var(--text-secondary)" stroke-width="1" opacity="0.35"/>
  <line x1="160" y1="40" x2="280" y2="160" stroke="var(--text-secondary)" stroke-width="1" opacity="0.35"/>
  <line x1="40" y1="160" x2="160" y2="280" stroke="var(--text-secondary)" stroke-width="1" opacity="0.35"/>
  <line x1="160" y1="280" x2="280" y2="160" stroke="var(--text-secondary)" stroke-width="1" opacity="0.35"/>
  <text x="160" y="30" text-anchor="middle" font-family="var(--font-mono)" font-size="10" fill="var(--red-soft)">I⁺（未来 ∞）</text>
  <text x="160" y="300" text-anchor="middle" font-family="var(--font-mono)" font-size="10" fill="var(--blue-soft)">I⁻（过去 ∞）</text>
  <text x="100" y="100" text-anchor="middle" font-family="var(--font-mono)" font-size="8" fill="var(--text-tertiary)" transform="rotate(-45,100,100)">视界</text>
  <text x="160" y="155" text-anchor="middle" font-family="var(--font-mono)" font-size="9" fill="var(--text-secondary)">观测者</text>
</svg>
<div style="font-size: 0.78rem; color: var(--text-tertiary); margin-top: 0.5rem;">德西特时空。正方形而非菱形。上下边界为类空的——宇宙在所有地方同时开始和结束。每个观测者都被宇宙学视界包围。</div>
</div>

**反德西特——垂直条带。** 负宇宙学常数。类时垂直边界。不是我们的宇宙——但可以说是当今理论物理中最重要的时空。

<div style="text-align:center; margin: 2rem 0; padding: 1.5rem; background: var(--bg-secondary); border: 1px solid var(--border); border-radius: 8px;">
<svg viewBox="0 0 320 380" xmlns="http://www.w3.org/2000/svg" style="max-width: 300px; width: 100%;">
  <rect x="80" y="30" width="160" height="320" fill="var(--blue-soft)" opacity="0.04" stroke="none"/>
  <line x1="80" y1="30" x2="80" y2="350" stroke="var(--purple-soft)" stroke-width="2.5" opacity="0.7"/>
  <line x1="240" y1="30" x2="240" y2="350" stroke="var(--purple-soft)" stroke-width="2.5" opacity="0.7"/>
  <line x1="80" y1="30" x2="240" y2="30" stroke="var(--blue-soft)" stroke-width="1" opacity="0.25"/>
  <line x1="80" y1="350" x2="240" y2="350" stroke="var(--blue-soft)" stroke-width="1" opacity="0.25"/>
  <path d="M 160,300 L 240,220 L 160,140 L 80,60" fill="none" stroke="var(--text-secondary)" stroke-width="1.2" stroke-dasharray="4,3" opacity="0.4"/>
  <circle cx="160" cy="300" r="3" fill="var(--text-secondary)" opacity="0.6"/>
  <text x="60" y="190" text-anchor="middle" font-family="var(--font-body)" font-size="13" fill="var(--purple-soft)" font-style="italic" transform="rotate(-90,60,190)">边界（CFT）</text>
  <text x="260" y="190" text-anchor="middle" font-family="var(--font-body)" font-size="13" fill="var(--purple-soft)" font-style="italic" transform="rotate(90,260,190)">边界（CFT）</text>
  <text x="160" y="200" text-anchor="middle" font-family="var(--font-body)" font-size="14" fill="var(--blue-soft)" font-style="italic" opacity="0.5">AdS 体</text>
  <text x="160" y="20" text-anchor="middle" font-family="var(--font-mono)" font-size="9" fill="var(--text-tertiary)">t → +∞</text>
  <text x="160" y="368" text-anchor="middle" font-family="var(--font-mono)" font-size="9" fill="var(--text-tertiary)">t → −∞</text>
  <text x="248" y="218" font-family="var(--font-mono)" font-size="8" fill="var(--text-tertiary)">光在边界</text>
  <text x="248" y="230" font-family="var(--font-mono)" font-size="8" fill="var(--text-tertiary)">处"反弹"</text>
</svg>
<div style="font-size: 0.78rem; color: var(--text-tertiary); margin-top: 0.5rem;">反德西特时空。垂直条带。侧壁为类时边界，对偶CFT就在其上。光在有限时间内到达边界并"反弹"回来——该空间如同一个盒子。</div>
</div>

1997年，马尔达塞纳证明该空间中的量子引力等价于其边界上的量子场论——[AdS/CFT对应](/research/ads-cft-holographic/)，高能物理史上被引最多的成果（20,000+引用）。彭罗斯图的垂直边缘就是对偶理论所在之处。

## 这些图使什么成为可能

<div class="timeline">
  <div class="tl-item"><div class="tl-dot tl-dot--green"></div><div class="tl-year">1963</div><div class="tl-title">彭罗斯引入共形紧化</div><div class="tl-desc">《物理评论快报》+ 勒乌什暑期学校。</div></div>
  <div class="tl-item"><div class="tl-dot tl-dot--green"></div><div class="tl-year">1965</div><div class="tl-title">奇点定理</div><div class="tl-desc">"自爱因斯坦以来对广义相对论最重要的贡献。"诺贝尔奖在55年后到来。</div></div>
  <div class="tl-item"><div class="tl-dot tl-dot--green"></div><div class="tl-year">1970</div><div class="tl-title">彭罗斯-霍金奇点定理</div><div class="tl-desc">霍金将方法扩展到宇宙学：大爆炸本身包含奇点。</div></div>
  <div class="tl-item"><div class="tl-dot tl-dot--green"></div><div class="tl-year">1973–75</div><div class="tl-title">黑洞熵与霍金辐射</div><div class="tl-desc">贝肯斯坦：熵 ∝ 面积。惠勒："你的想法疯狂到可能是对的。"霍金证实：黑洞辐射。</div></div>
  <div class="tl-item"><div class="tl-dot tl-dot--green"></div><div class="tl-year">1997</div><div class="tl-title">AdS/CFT对应</div><div class="tl-desc">马尔达塞纳：AdS中的量子引力 = 彭罗斯图边界上的场论。</div></div>
  <div class="tl-item"><div class="tl-dot tl-dot--green"></div><div class="tl-year">2013</div><div class="tl-title">ER = EPR</div><div class="tl-desc">爱因斯坦-罗森桥（在彭罗斯图上可见）= 量子纠缠。</div></div>
  <div class="tl-item"><div class="tl-dot tl-dot--green"></div><div class="tl-year">2015</div><div class="tl-title">LIGO探测到引力波</div><div class="tl-desc">波能量在I⁺上定义——彭罗斯图使其严格化的边界。</div></div>
  <div class="tl-item"><div class="tl-dot tl-dot--green"></div><div class="tl-year">2020</div><div class="tl-title">诺贝尔奖</div><div class="tl-desc">彭罗斯，89岁。发现到获奖间隔55年。</div></div>
</div>

<div class="highlight-box">
<strong>跨学科的视觉思维者</strong>
罗杰·彭罗斯（1931年生）：不可能三角→埃舍尔。非周期铺砌→准晶体。奇点定理：用拓扑学取代蛮力计算。共形图：一幅图代替数页方程。1988年与霍金共获沃尔夫奖。2020年89岁获诺贝尔奖。
</div>

---

## 参考文献

- R. Penrose, *Phys. Rev. Lett.* **10**, 66 (1963)
- R. Penrose, *Phys. Rev. Lett.* **14**, 57 (1965) — 2020年诺贝尔物理学奖
- S. W. Hawking, R. Penrose, *Proc. R. Soc. Lond. A* **314**, 529 (1970)
- S. W. Hawking, G. F. R. Ellis, *The Large Scale Structure of Space-Time*, Cambridge (1973)
- J. D. Bekenstein, *Phys. Rev. D* **7**, 2333 (1973)
- S. W. Hawking, *Commun. Math. Phys.* **43**, 199 (1975)
- R. M. Wald, *General Relativity*, University of Chicago Press (1984)
- J. M. Maldacena, *Adv. Theor. Math. Phys.* **2**, 231 (1998) — [arXiv:hep-th/9711200](https://arxiv.org/abs/hep-th/9711200)
- [诺贝尔物理学奖 2020](https://www.nobelprize.org/prizes/physics/2020/press-release/)
