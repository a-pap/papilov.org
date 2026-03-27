---
title: "Prebid.js: как устроен стандарт программатик-монетизации"
date: 2026-03-27
lastmod: 2026-03-27
version: "2.0"
status: "finished"
confidence: "certain"
description: "Глубокий разбор технологии, которая обрабатывает триллионы рекламных аукционов в год — от механики до бизнес-эффектов. Для тех, кто принимает решения."
tags: ["adtech", "programmatic", "header-bidding", "prebid", "monetization"]
series: "Information ≠ Understanding"
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

Типичный эффект перехода с waterfall на header bidding — **+20–50% программатик-дохода**. The Telegraph зафиксировал +70%. Future plc при переходе на first-price аукцион получила +25–50% CPM.

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

## Как работает: 5 шагов за ~1000 мс

Весь цикл аукциона укладывается в промежуток загрузки страницы:

1. **Страница загружается → аукцион стартует** (~0 мс). Prebid.js определяет рекламные слоты и одновременно отправляет bid requests всем подключённым покупателям.

2. **Покупатели отвечают ставками** (200–800 мс). Каждый DSP/SSP получает данные о слоте — размер, позиция, данные о пользователе — и возвращает ставку или отказ. Всё параллельно.

3. **Таймаут отсекает медленных** (timeout: 1000–1500 мс). Кто не успел — не участвует. Защита UX: страница не должна зависать ради рекламы.

4. **Лучшие ставки → в ad server** (~50 мс). Выигравшие ставки передаются в Google Ad Manager, где конкурируют с прямыми продажами и AdX.

5. **Ad server выбирает победителя → показ** (~1100 мс total). GAM сравнивает ставку Prebid с собственными источниками и отдаёт показ тому, кто платит больше.

Ключевой момент: Prebid **не заменяет** ad server. Он создаёт конкуренцию *до* принятия решения, увеличивая эффективную цену каждого показа.

## Контекст рынка

Глобальный рекламный рынок достиг $1.14T в 2025 году (+8.8% YoY) и впервые превысит $1 трлн по прогнозу dentsu. Программатик занимает доминирующую долю digital display.

### Куда уходит рекламный доллар

По данным ANA Programmatic Supply Chain Transparency Study (2023), из каждого доллара рекламодателя до паблишера доходило лишь **36 центов**. Транзакционные издержки (DSP+SSP сборы) съедали 29¢, потери качества (non-viewable, IVT, MFA-сайты) — ещё 35¢.

К Q3 2025 ситуация улучшилась: доля паблишера выросла до **47.1%** (+11 п.п. за два года). Но $26.8 млрд в год по-прежнему теряется на неэффективности цепочки. Медианная доля MFA-инвентаря снизилась с 2.3% до рекордных 0.8%. Доля PMP-закупок выросла с 64.5% до 87.8%.

Prebid — один из инструментов, который помогает паблишеру максимизировать свою долю через конкурентный аукцион.

## Google Antitrust: почему Prebid становится важнее

В апреле 2025 федеральный суд США признал Google виновной в незаконной монополизации рынков publisher ad server и ad exchange. Суд установил, что Google связывала свой ad server (DFP) с биржей (AdX) через контрактные политики и техническую интеграцию, ограничивая конкуренцию и нанося ущерб паблишерам.

Параллельно: ЕС назначил штраф €2.95B за злоупотребление доминирующей позицией в adtech. Техас урегулировал собственный иск на $1.375B. DOJ требует продажу AdX.

Для Prebid это **структурный попутный ветер**. Если Google будет вынуждена разделить ad server и биржу, neutral аукционные решения станут критически важными. Паблишеры уже начали подавать частные иски, используя прецедент апрельского решения.

## Три архитектуры

### Client-side (браузер)

Классический вариант — аукцион выполняется в браузере. Плюс: простота, полный cookie-доступ (максимальный таргетинг и CPM). Минус: чем больше покупателей, тем тяжелее страница. Практический потолок — **15–20 покупателей**.

### Server-side (Prebid Server)

Аукцион на сервере: браузер отправляет один запрос, сервер рассылает его покупателям. До **40% снижения latency**. Неограниченное число покупателей без влияния на страницу. Минус: покупатели на сервере не имеют доступа к cookies → **−20–40% CPM** по сравнению с client-side для тех же покупателей.

### Гибрид (индустриальный стандарт)

5–8 ключевых покупателей client-side (максимальные ставки) + остальные server-side (дополнительный спрос без нагрузки). Это оптимальный баланс — и то, что используют большинство крупных паблишеров.

## Бизнес-рычаги

### Таймаут

Каждые +100 мс задержки в загрузке — потеря аудитории. Индустриальный стандарт — 1000–1500 мс. При 800 мс отвечают ~55% покупателей, при 1500 мс — ~95%. Оптимум зависит от аудитории и инфраструктуры покупателей.

### Price Granularity

Prebid передаёт ставки через ценовые корзины. Грубая гранулярность ($0.50 шагом) округляет ставку $3.27 до $3.00 — потеря $0.27 на каждом показе. При тонкой ($0.01) — потеря менее цента, но нужны ~2000 line items в GAM.

### Подбор покупателей

Больше ≠ лучше. **80% дополнительного дохода** приносят первые 5–7 покупателей. Каждый следующий — убывающая отдача при растущей latency. Sweet spot — около 8 покупателей client-side.

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

Разброс 8× между верхом и низом определяет экономику монетизации.

В 2025 году CPM пережили волатильность: Q1 упал на 33–42% YoY (после политического 2024-го), к декабрю восстановился (display +6.3%, video +33.2% YoY). Динамические floor prices и диверсификация demand sources — ключевые инструменты управления этой волатильностью, и Prebid Floors Module даёт обе эти возможности.

## Privacy: post-cookie адаптация

Prebid — одна из немногих инфраструктур, которая активно эволюционирует под post-cookie реальность. User ID Module поддерживает UID2.0, SharedID, EUID, LiveRamp и десятки других. Поддержка first-party data, Topics API, Protected Audiences, GDPR/CCPA/GPP Consent Modules.

40% US-маркетологов в 2025 используют first-party data как основной метод таргетинга. Подключение Prebid User ID позволяет сохранить 60–80% addressable CPM по сравнению с полной потерей идентификации.

## Форматы: больше чем display

Prebid поддерживает display, video (instream/outstream), native, mobile in-app (SDK), CTV/OTT (server-side only), DOOH. CTV вырос до 44% программатик-закупок к Q2 2025 (было 28% в Q4 2024). Programmatic video в US превысит $110B в 2026. Retail media — $30B+ к 2026 (+29% YoY).

## Экосистема и конкуренты

Prebid.js — проект Prebid.org (IAB Tech Lab), запущенный в 2015 году. Open source, vendor-neutral, 300+ demand-партнёров. На практике Prebid не конкурирует с Amazon TAM и Google Open Bidding — крупные паблишеры используют все три параллельно. По данным Roxot, client-side и server-side HB генерируют по ~22% программатик-дохода каждый, а AdX — 56%.

Google Open Bidding находится под особым давлением после антимонопольного решения: суд установил, что привязка ad server к exchange была антиконкурентной. Prebid как neutral альтернатива усиливает позиции.

## Чего Prebid не делает

Prebid — инфраструктура аукциона, не полное решение монетизации. Он не оптимизирует размещение слотов на странице, не заменяет ad server (GAM нужен для прямых продаж и frequency capping), не решает проблему качества трафика (боты, низкая viewability), и не является plug-and-play решением — требует инженерной экспертизы и постоянной оптимизации.

## Итог

Для паблишера среднего и крупного масштаба работать без header bidding в 2026 году — значит оставлять **20–40% программатик-дохода** на столе. Prebid стал стандартом потому, что он открытый, нейтральный и поддерживается индустрией.

Стратегический вопрос не «нужен ли Prebid», а **какая конфигурация оптимальна**: сколько покупателей, client vs server, какие ID-решения, какие таймауты, какая гранулярность. С учётом Google antitrust и post-cookie перехода, vendor-neutral решения становятся критичнее чем когда-либо.

<div class="metrics">
<div class="metric"><div class="val">+20–50%</div><div class="desc">waterfall → header bidding</div></div>
<div class="metric"><div class="val">+5–15%</div><div class="desc">+ server-side</div></div>
<div class="metric"><div class="val">+3–10%</div><div class="desc">оптимизация config</div></div>
</div>

---

### Источники

1. [Prebid.org](https://prebid.org/) — документация, blog
2. [Prebid.js GitHub](https://github.com/prebid/Prebid.js) — 300+ bid-адаптеров
3. [ANA Q2 2025 Benchmark](https://www.ana.net/content/show/id/pr-2025-08-programmatictrans) — $26.8B потерь, CTV 44%
4. [ANA Q3 2025 Benchmark](https://www.ana.net/content/show/id/pr-2025-11-transparency) — доля паблишера 47.1%
5. [ANA Supply Chain Study 2023](https://drupal.unglobalcompact.org/cmo-blueprint-for-sustainable-growth/resources/ana-programmatic-media-supply-chain-transparency) — 36¢ на доллар
6. [dentsu Global Ad Spend Forecasts](https://www.dentsu.com/news-releases/global-ad-spend-set-to-surpass-one-trillion-for-the-first-time-in-2026-as-the-algorithmic-era-redefines-growth) — $1T+ в 2026
7. [Basis Technologies](https://basis.com/blog/7-programmatic-advertising-trends-shaping-2026) — US programmatic $203B
8. [eMarketer](https://www.emarketer.com/content/worldwide-programmatic-ad-spending-2025) — 90% display = programmatic
9. [AsterioBid](https://asteriobid.com/cpm_trends_banners_2024) — CPM by country 2024
10. [DataBeat](https://databeat.io/blog/us-programmatic-trends-december-2025/) — US CPM monthly trends
11. [Digiday](https://digiday.com/media/header-bidding-publishers-boosting-cpms-much-50-percent/) — HB CPM uplift 20–50%
12. [Digiday Research](https://digiday.com/media/digiday-research-header-bidding-and-first-price-auctions-boost-publisher-revenues/) — Future plc +25–50%
13. [AdPushup](https://www.adpushup.com/blog/header-bidding-analytics-using-data-to-optimize-your-stack/) — Telegraph +70%
14. [Mile.tech](https://www.mile.tech/blog/prebid-server) — Prebid Server: −40% latency
15. [Criteo](https://www.criteo.com/blog/header-bidding-demystified-client-side-vs-server-side/) — Client vs Server deep dive
16. [US v. Google (adtech)](https://en.wikipedia.org/wiki/United_States_v._Google_LLC_(2023)) — April 2025 ruling
17. [Axios](https://www.axios.com/2025/04/17/google-ad-tech-monopoly-antitrust-ruling) — Google loses monopoly case
18. [Raptive](https://raptive.com/blog/what-the-dojs-ruling-on-google-means-for-creators-and-publishers/) — Impact on publishers
19. [Kluwer](https://legalblogs.wolterskluwer.com/competition-blog/impact-of-the-ec-decision-on-googles-adtech-stakeholder-analysis-and-remedies/) — EU €2.95B fine
20. [Roxot](https://roxot.com/report/sell-side-programmatic-us-2019) — HB vs AdX revenue shares
