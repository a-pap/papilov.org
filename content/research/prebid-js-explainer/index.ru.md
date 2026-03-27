---
title: "Prebid.js: как устроен стандарт программатик-монетизации"
date: 2026-03-27
lastmod: 2026-03-27
version: "2.0"
status: "finished"
confidence: "certain"
description: "Глубокий разбор технологии, которая обрабатывает триллионы рекламных аукционов в год — от механики до бизнес-эффектов. Для тех, кто принимает решения."
tags: ["adtech", "programmatic", "header-bidding", "prebid", "monetization"]
series: "Информация ≠ Понимание"
ai_disclosure: "Research conducted with Claude (Anthropic). Human editorial direction and domain expertise."
license: "CC BY-NC 4.0"
---

Программатик-реклама — рынок на $595 млрд (2024), к 2028 прогнозируемый в $779 млрд. Около 90% digital display покупается автоматически. В центре инфраструктуры этого рынка на стороне паблишеров — открытая библиотека, которую используют более 10 000 компаний: Prebid.js.

Этот разбор — для тех, кто принимает решения о монетизации: что Prebid делает, как работает, почему стал стандартом, и какие рычаги определяют бизнес-результат.

<div class="metrics">
<div class="metric"><div class="val">300+</div><div class="desc">bid-адаптеров</div></div>
<div class="metric"><div class="val">~90%</div><div class="desc">display = программатик</div></div>
<div class="metric"><div class="val">$203B</div><div class="desc">US programmatic 2026</div></div>
<div class="metric"><div class="val">10K+</div><div class="desc">компаний-пользователей</div></div>
</div>

## Проблема: waterfall теряет деньги

Исторически паблишеры продавали инвентарь через **«водопад»** — рекламные сети вызывались последовательно, по приоритету. Первая, которая соглашалась купить показ, получала его. Остальные не участвовали — даже если были готовы заплатить значительно больше.

**Header bidding** устранил эту неэффективность: все покупатели делают ставки одновременно, побеждает максимальная цена. Prebid.js — open-source библиотека, ставшая индустриальным стандартом для реализации header bidding в браузере.

<div class="compare">
  <div class="compare-col col-a">
    <h4>Waterfall</h4>
    <div class="compare-item"><strong>Сеть A (приоритет 1)</strong><span>$2.00 — выиграла по умолчанию</span></div>
    <div class="compare-item"><strong>Сеть B (приоритет 2)</strong><span>Не спросили</span></div>
    <div class="compare-item"><strong>Сеть C (приоритет 3)</strong><span>Была готова заплатить $5.00 — не спросили</span></div>
    <div class="compare-item"><strong>Результат</strong><span>Показ продан за $2.00</span></div>
  </div>
  <div class="compare-col col-b">
    <h4>Header Bidding (Prebid)</h4>
    <div class="compare-item"><strong>Сеть A</strong><span>$2.00</span></div>
    <div class="compare-item"><strong>Сеть B</strong><span>$3.10</span></div>
    <div class="compare-item"><strong>Сеть C</strong><span>$5.00 — побеждает</span></div>
    <div class="compare-item"><strong>Результат</strong><span>Все ставят параллельно → $5.00 (+150%)</span></div>
  </div>
</div>

<div class="metrics">
<div class="metric"><div class="val val--green">+20–50%</div><div class="desc">waterfall → header bidding uplift</div></div>
<div class="metric"><div class="val val--green">+70%</div><div class="desc">The Telegraph (кейс)</div></div>
<div class="metric"><div class="val val--green">+25–50%</div><div class="desc">CPM uplift, Future plc</div></div>
<div class="metric"><div class="val val--green">30–40%</div><div class="desc">средний uplift портфеля (AdPushup)</div></div>
</div>

## Как работает: 5 шагов за ~1000 мс

<div class="flow-steps">
<div class="flow-step"><div><div class="flow-num">1</div><div class="flow-line"></div></div><div class="flow-body"><h4>Страница загружается → аукцион стартует</h4><p>Prebid.js определяет рекламные слоты и одновременно отправляет bid requests всем подключённым покупателям.</p><span class="flow-tag">~0 мс</span></div></div>
<div class="flow-step"><div><div class="flow-num">2</div><div class="flow-line"></div></div><div class="flow-body"><h4>Покупатели отвечают ставками</h4><p>Каждый DSP/SSP получает данные о слоте и возвращает ставку или отказ. Всё параллельно.</p><span class="flow-tag">200–800 мс</span></div></div>
<div class="flow-step"><div><div class="flow-num">3</div><div class="flow-line"></div></div><div class="flow-body"><h4>Таймаут отсекает медленных</h4><p>Кто не успел — не участвует. Защита UX.</p><span class="flow-tag">timeout: 1000–1500 мс</span></div></div>
<div class="flow-step"><div><div class="flow-num">4</div><div class="flow-line"></div></div><div class="flow-body"><h4>Лучшие ставки → в ad server</h4><p>Выигравшие ставки передаются в Google Ad Manager, где конкурируют с прямыми продажами и AdX.</p><span class="flow-tag">~50 мс</span></div></div>
<div class="flow-step"><div><div class="flow-num">5</div><div class="flow-line"></div></div><div class="flow-body"><h4>Ad server выбирает победителя → показ</h4><p>GAM сравнивает все источники и отдаёт показ тому, кто платит больше.</p><span class="flow-tag">~1100 мс total</span></div></div>
</div>

<div class="highlight-box">
<strong>Prebid не заменяет ad server.</strong>
Он создаёт конкуренцию <em>до</em> принятия решения, увеличивая эффективную цену каждого показа.
</div>

## Контекст рынка

<div class="metrics">
<div class="metric"><div class="val val--blue">$1.14T</div><div class="desc">глобальный рекламный рынок 2025</div></div>
<div class="metric"><div class="val val--blue">$595B</div><div class="desc">программатик (глобально) 2024</div></div>
<div class="metric"><div class="val val--blue">$203B</div><div class="desc">US programmatic display 2026</div></div>
</div>

По данным ANA Supply Chain Study (2023), из каждого доллара рекламодателя до паблишера доходило лишь **36 центов**. К Q3 2025 ситуация улучшилась до **47.1¢** (+11 п.п.), но $26.8 млрд в год по-прежнему теряется на неэффективности цепочки.

<div class="dollar-flow">
<div class="dollar-node"><div class="dollar-box">Рекламодатель</div><div class="dollar-amt">$1.00</div></div>
<div class="dollar-arr">→</div>
<div class="dollar-node"><div class="dollar-box">DSP + SSP сборы</div><div class="dollar-amt" style="color: var(--purple-soft)">−29¢</div><div class="dollar-note">транзакции</div></div>
<div class="dollar-arr">→</div>
<div class="dollar-node"><div class="dollar-box">Потери</div><div class="dollar-amt" style="color: var(--red-soft)">−24¢</div><div class="dollar-note">IVT, MFA</div></div>
<div class="dollar-arr">→</div>
<div class="dollar-node"><div class="dollar-box">Паблишер</div><div class="dollar-amt" style="color: var(--green-soft)">47¢</div><div class="dollar-note">было 36¢</div></div>
</div>

<div class="metrics">
<div class="metric"><div class="val val--red">$26.8B</div><div class="desc">годовые потери цепочки</div></div>
<div class="metric"><div class="val val--green">47.1%</div><div class="desc">доля паблишера (было 36%)</div></div>
<div class="metric"><div class="val val--green">0.8%</div><div class="desc">MFA-инвентарь (рекордный минимум)</div></div>
<div class="metric"><div class="val val--blue">87.8%</div><div class="desc">доля PMP (было 64.5%)</div></div>
</div>

## Google Antitrust: почему Prebid становится важнее

В апреле 2025 федеральный суд США признал Google виновной в незаконной монополизации рынков publisher ad server и ad exchange. ЕС назначил штраф €2.95B. Техас урегулировал иск на $1.375B. DOJ требует продажу AdX.

<div class="metrics">
<div class="metric"><div class="val val--red">~90%</div><div class="desc">доля Google в ad server</div></div>
<div class="metric"><div class="val val--red">€2.95B</div><div class="desc">штраф ЕС</div></div>
<div class="metric"><div class="val val--red">$1.375B</div><div class="desc">урегулирование Техаса</div></div>
</div>

> "Google willfully engaged in a series of anticompetitive acts to acquire and maintain monopoly power in the publisher ad server and ad exchange markets."
> — Судья Леони Бринкема, 17 апреля 2025

Для Prebid это **структурный попутный ветер**. Если Google будет вынуждена разделить ad server и биржу, vendor-neutral аукционные решения станут критической инфраструктурой.

## Три архитектуры

| Параметр | Client-side | Server-side | Гибрид |
|-----------|------------|-------------|--------|
| Аукцион | Браузер | Сервер | Оба |
| Покупатели | 15–20 (лимит) | Без ограничений | 5–8 + остальные (оптимум) |
| Latency | Растёт с числом покупателей | −40% | Контролируемая |
| Cookie-доступ | Полный (макс CPM) | Ограниченный (−20–40% CPM) | Полный для ключевых |
| Лучше для | Средних паблишеров | CTV, App, AMP | Крупных паблишеров |

<div class="highlight-box">
<strong>Гибрид — индустриальный стандарт:</strong>
5–8 ключевых покупателей client-side + остальные server-side. Prebid Server даёт до 40% снижения latency.
</div>

## Бизнес-рычаги

### Таймаут: доход vs. UX

<div class="bars">
  <div class="bar-row"><div class="label">800 мс</div><div class="track"><div class="fill" style="width:55%">~55%</div></div><div class="pct">~55%</div></div>
  <div class="bar-row"><div class="label">1000 мс ←</div><div class="track"><div class="fill" style="width:75%">~75%</div></div><div class="pct">~75%</div></div>
  <div class="bar-row"><div class="label">1200 мс</div><div class="track"><div class="fill" style="width:88%">~88%</div></div><div class="pct">~88%</div></div>
  <div class="bar-row"><div class="label">1500 мс</div><div class="track"><div class="fill" style="width:95%">~95%</div></div><div class="pct">~95%</div></div>
</div>

### Price Granularity

| Тип | Шаг | GAM Lines | Потеря дохода |
|------|------|-----------|--------------|
| Low | $0.50 | ~40 | до $0.49 (высокая) |
| Medium | $0.10 | ~200 | до $0.09 (умеренная) |
| High | $0.01 | ~2,000 | $0.009 (минимальная) |
| Custom | Переменный | Оптимизировано | Контролируемая (рекомендуется) |

### Подбор покупателей: убывающая отдача

<div class="bars">
  <div class="bar-row"><div class="label">3 покупателя</div><div class="track"><div class="fill" style="width:60%">~60%</div></div><div class="pct">~60%</div></div>
  <div class="bar-row"><div class="label">5 покупателей</div><div class="track"><div class="fill" style="width:80%">~80%</div></div><div class="pct">~80%</div></div>
  <div class="bar-row"><div class="label">8 покупателей ←</div><div class="track"><div class="fill" style="width:92%">~92%</div></div><div class="pct">~92%</div></div>
  <div class="bar-row"><div class="label">15 покупателей</div><div class="track"><div class="fill" style="width:97%">~97%</div></div><div class="pct">~97%</div></div>
  <div class="bar-row muted"><div class="label">20+ покупателей</div><div class="track"><div class="fill" style="width:99%">~99%</div></div><div class="pct">latency↑</div></div>
</div>

80% дополнительного дохода приносят первые 5–7 покупателей. Sweet spot — около 8 client-side.

## CPM по странам

Средние CPM для баннерной рекламы (SSP-сторона, 2024):

<div class="bars">
  <div class="bar-row"><div class="label">США</div><div class="track"><div class="fill" style="width:100%">$1.43</div></div><div class="pct">$1.43</div></div>
  <div class="bar-row"><div class="label">UK</div><div class="track"><div class="fill" style="width:73%">$1.05</div></div><div class="pct">$1.05</div></div>
  <div class="bar-row"><div class="label">Германия</div><div class="track"><div class="fill" style="width:63%">$0.90</div></div><div class="pct">$0.90</div></div>
  <div class="bar-row"><div class="label">Франция</div><div class="track"><div class="fill" style="width:56%">$0.80</div></div><div class="pct">$0.80</div></div>
  <div class="bar-row"><div class="label">Бразилия</div><div class="track"><div class="fill" style="width:35%">$0.50</div></div><div class="pct">$0.50</div></div>
  <div class="bar-row"><div class="label">Индия</div><div class="track"><div class="fill" style="width:17%">$0.25</div></div><div class="pct">$0.25</div></div>
</div>

Разброс 8× между верхом и низом определяет экономику монетизации. Q1 2025: US display CPMs упали на −33–42% YoY после рекордного политического года. К декабрю 2025: display +6.3% YoY, video +33.2% YoY. Эта волатильность подчёркивает необходимость динамических floor prices — именно это даёт Prebid Floors Module.

## Privacy: post-cookie адаптация

<div class="badge-list">
<div class="badge-item"><span class="badge-dot" style="background: var(--green-soft)"></span>User ID — UID2, SharedID, EUID, LiveRamp</div>
<div class="badge-item"><span class="badge-dot" style="background: var(--blue-soft)"></span>First-party data</div>
<div class="badge-item"><span class="badge-dot" style="background: var(--purple-soft)"></span>Topics API / Protected Audiences</div>
<div class="badge-item"><span class="badge-dot" style="background: var(--yellow-soft)"></span>GDPR / CCPA / GPP consent</div>
</div>

<div class="metrics">
<div class="metric"><div class="val val--blue">40%</div><div class="desc">US-маркетологов используют 1P data как основной таргетинг (2025)</div></div>
<div class="metric"><div class="val val--green">60–80%</div><div class="desc">CPM сохраняется с Prebid User ID vs. без идентификации</div></div>
</div>

## Форматы: больше чем display

| Формат | Архитектура | Рынок |
|--------|-------------|--------|
| Display | Client + Server | Ядро программатика |
| Video (instream) | Client + Server | Максимальный CPM |
| Mobile in-app | SDK → Server | 71% программатик |
| CTV / OTT | Только Server | 44% доля (Q2 2025), >$45B |
| Retail Media | Server | $30B+ к 2026, +29% YoY |
| DOOH | Server | +400% с 2019 |

<div class="metrics">
<div class="metric"><div class="val val--blue">$110B+</div><div class="desc">US programmatic video 2026</div></div>
<div class="metric"><div class="val val--blue">44%</div><div class="desc">доля CTV (Q2 2025, было 28%)</div></div>
<div class="metric"><div class="val val--blue">$30B+</div><div class="desc">retail media к 2026</div></div>
</div>

## Экосистема и конкуренты

<div class="timeline">
  <div class="tl-item"><div class="tl-dot tl-dot--green"></div><div class="tl-year">2015</div><div class="tl-title">Запуск Prebid.js (AppNexus + партнёры)</div><div class="tl-desc">Open-source библиотека header bidding.</div></div>
  <div class="tl-item"><div class="tl-dot tl-dot--green"></div><div class="tl-year">2017</div><div class="tl-title">Prebid Server + Mobile SDK</div><div class="tl-desc">Server-side аукцион и поддержка мобильных.</div></div>
  <div class="tl-item"><div class="tl-dot tl-dot--green"></div><div class="tl-year">2019–20</div><div class="tl-title">95% топ-паблишеров US на header bidding</div><div class="tl-desc">Header bidding стал индустриальной нормой.</div></div>
  <div class="tl-item"><div class="tl-dot"></div><div class="tl-year">2021–22</div><div class="tl-title">User ID, Floors, GDPR модули</div><div class="tl-desc">Модули для privacy-эры расширяют платформу.</div></div>
  <div class="tl-item"><div class="tl-dot tl-dot--green"></div><div class="tl-year">2024–25</div><div class="tl-title">v11, CTV, 300+ адаптеров, PAAPI</div><div class="tl-desc">Мультиформатная экспансия и post-cookie готовность.</div></div>
  <div class="tl-item"><div class="tl-dot"></div><div class="tl-year">2025–26</div><div class="tl-title">Google antitrust → neutral инфраструктура критичнее</div><div class="tl-desc">Решение суда ускоряет переход к vendor-neutral решениям.</div></div>
</div>

| Решение | Тип | Отличие | Lock-in |
|----------|------|-----------------|---------|
| Prebid.js | Open source | Нейтральный, аудируемый | Нет |
| Amazon TAM | Проприетарный | Привязан к Amazon DSP | Средний |
| Google Open Bidding | Server-side в GAM | Конфликт интересов | Высокий |
| Index Exchange | Проприетарный | Качество, но зависимость от вендора | Средний |

Prebid работает параллельно с TAM и Open Bidding. По данным Roxot, client-side и server-side header bidding генерируют по ~22% программатик-дохода каждый, а AdX — ~56%.

## Чего Prebid не делает

<div class="psych-grid">
  <div class="psych-card">
    <h4>Не оптимизирует размещение</h4>
    <p>Позиция и размер рекламных слотов — решение паблишера. Prebid работает со спросом, не с layout.</p>
  </div>
  <div class="psych-card">
    <h4>Не заменяет ad server</h4>
    <p>GAM по-прежнему нужен для прямых продаж, frequency capping и финального решения.</p>
  </div>
  <div class="psych-card">
    <h4>Не решает проблему качества трафика</h4>
    <p>Боты, низкая viewability и invalid traffic — проблемы за пределами Prebid.</p>
  </div>
  <div class="psych-card">
    <h4>Не plug-and-play</h4>
    <p>Инженерный инструмент, требующий постоянной оптимизации конфигурации и мониторинга.</p>
  </div>
</div>

## Итог

Работать без header bidding в 2026 году — значит оставлять **20–40% программатик-дохода** на столе. Стратегический вопрос не «нужен ли Prebid», а **какая конфигурация оптимальна**. С учётом Google antitrust и post-cookie перехода, vendor-neutral решения критичнее чем когда-либо.

<div class="metrics">
<div class="metric"><div class="val val--green">+20–50%</div><div class="desc">waterfall → header bidding</div></div>
<div class="metric"><div class="val val--green">+5–15%</div><div class="desc">+ server-side</div></div>
<div class="metric"><div class="val val--green">+3–10%</div><div class="desc">оптимизация config</div></div>
</div>

---

### Источники

1. [Prebid.org](https://prebid.org/) 2. [Prebid.js GitHub](https://github.com/prebid/Prebid.js) 3. [ANA Q2 2025](https://www.ana.net/content/show/id/pr-2025-08-programmatictrans) 4. [ANA Q3 2025](https://www.ana.net/content/show/id/pr-2025-11-transparency) 5. [ANA 2023 Study](https://drupal.unglobalcompact.org/cmo-blueprint-for-sustainable-growth/resources/ana-programmatic-media-supply-chain-transparency) 6. [dentsu](https://www.dentsu.com/news-releases/global-ad-spend-set-to-surpass-one-trillion-for-the-first-time-in-2026-as-the-algorithmic-era-redefines-growth) 7. [Basis](https://basis.com/blog/7-programmatic-advertising-trends-shaping-2026) 8. [eMarketer](https://www.emarketer.com/content/worldwide-programmatic-ad-spending-2025) 9. [AsterioBid](https://asteriobid.com/cpm_trends_banners_2024) 10. [DataBeat](https://databeat.io/blog/us-programmatic-trends-december-2025/) 11. [Digiday](https://digiday.com/media/header-bidding-publishers-boosting-cpms-much-50-percent/) 12. [Digiday Research](https://digiday.com/media/digiday-research-header-bidding-and-first-price-auctions-boost-publisher-revenues/) 13. [AdPushup](https://www.adpushup.com/blog/header-bidding-analytics-using-data-to-optimize-your-stack/) 14. [Mile.tech](https://www.mile.tech/blog/prebid-server) 15. [Criteo](https://www.criteo.com/blog/header-bidding-demystified-client-side-vs-server-side/) 16. [US v. Google](https://en.wikipedia.org/wiki/United_States_v._Google_LLC_(2023)) 17. [Axios](https://www.axios.com/2025/04/17/google-ad-tech-monopoly-antitrust-ruling) 18. [Raptive](https://raptive.com/blog/what-the-dojs-ruling-on-google-means-for-creators-and-publishers/) 19. [Kluwer](https://legalblogs.wolterskluwer.com/competition-blog/impact-of-the-ec-decision-on-googles-adtech-stakeholder-analysis-and-remedies/) 20. [Roxot](https://roxot.com/report/sell-side-programmatic-us-2019) 21. [Enlyft](https://enlyft.com/tech/products/prebid) 22. [6sense](https://6sense.com/tech/products/prebid-market-share) 23. [Marketing Brew](https://www.marketingbrew.com/stories/2025/12/09/total-global-ad-revenue-grew-nearly-9-in-2025-wpp-media) 24. [Prebid Server Docs](https://docs.prebid.org/dev-docs/pbsBidAdapter-video-overview.html)
