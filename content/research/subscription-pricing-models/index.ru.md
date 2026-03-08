---
title: "Цена лояльности"
date: 2026-03-03
lastmod: 2026-03-08
version: "5.0"
status: "in-progress"
confidence: "likely"
description: "Почему Netflix повышает цены каждый год, а World of Warcraft не менял цену 21 год. Как устроена подписочная экономика на $500B+ — от тёмных паттернов Amazon до Planet Wild, от гача-игр Японии до M-Pesa в Кении."
tags: ["экономика", "подписки", "ценообразование", "поведенческая-экономика", "экономика-внимания", "dark-patterns"]
series: "Информация ≠ Понимание"
ai_disclosure: "Исследование проведено с помощью Claude (Anthropic). Редакционное направление и доменная экспертиза — автора."
license: "CC BY-NC 4.0"
---

Подписочная экономика достигла [$492 млрд в 2024 году](https://www.grandviewresearch.com/horizon/outlook/subscription-economy-market/europe) и движется к $1.2 трлн к 2030. С 2020 года цены на подписки обогнали инфляцию в 3–5 раз. CPI в США вырос на ~22%. Стриминговые сервисы подорожали на 50–172%.

Но это только видимая часть. Невидимая — в том, что подписка устроена принципиально по-разному на разных континентах. В том, что $0.87 за JioHotstar в Индии и $18.99 за Disney+ — это разные ответы на разный вопрос. В том, что Amazon заплатил [$2.5 млрд штрафа](https://fortune.com/2025/09/25/amazon-ftc-settlement-prime-automatic-renewal-lina-khan-dark-patterns/) за то, как именно подписывал людей. И в том, что все эти модели одновременно врезаются в потолок: 24 часа в сутках, 47 секунд фокуса, и мозг, который физически не может потребить всё, за что платит.


---

## Кто повышал цены — и насколько

<div class="bars">
  <div class="bar-row"><div class="label">Disney+</div><div class="track"><div class="fill" style="width:86%">$6.99 → $18.99</div></div><div class="pct">+172%</div></div>
  <div class="bar-row"><div class="label">Apple TV+</div><div class="track"><div class="fill" style="width:80%">$4.99 → $12.99</div></div><div class="pct">+160%</div></div>
  <div class="bar-row"><div class="label">Netflix</div><div class="track"><div class="fill" style="width:63%">$7.99 → $17.99</div></div><div class="pct">+125%</div></div>
  <div class="bar-row"><div class="label">Peacock</div><div class="track"><div class="fill" style="width:60%">$4.99 → $10.99</div></div><div class="pct">+120%</div></div>
  <div class="bar-row"><div class="label">Xbox Game Pass</div><div class="track"><div class="fill" style="width:50%">$14.99 → $29.99</div></div><div class="pct">+100%</div></div>
  <div class="bar-row"><div class="label">Amazon Prime</div><div class="track"><div class="fill" style="width:38%">$79/год → $139/год</div></div><div class="pct">+76%</div></div>
  <div class="bar-row"><div class="label">Microsoft 365</div><div class="track"><div class="fill" style="width:22%">$69.99 → $99.99/год</div></div><div class="pct">+43%</div></div>
  <div class="bar-row"><div class="label">Spotify</div><div class="track"><div class="fill" style="width:17%">$9.99 → $12.99</div></div><div class="pct">+30%</div></div>
  <div class="bar-row muted"><div class="label">Инфляция CPI</div><div class="track"><div class="fill" style="width:11%"></div></div><div class="pct">~22%</div></div>
</div>

Spotify — особый случай. Двенадцать лет цена не двигалась: $9.99. Потом три повышения за три года: $10.99, $11.99, $12.99. Каждое — ровно доллар. Каждое — ниже порога, при котором человек открывает настройки и нажимает «отменить». Классическая стратегия [инкрементального повышения](https://en.wikipedia.org/wiki/Weber%E2%80%93Fechner_law) ниже Just Noticeable Difference.

<div class="highlight-box">
<strong>Что такое Just Noticeable Difference?</strong> Закон Вебера-Фехнера (XIX век) описывает, как мозг воспринимает изменения. Суть: чтобы вы заметили разницу, изменение должно быть пропорционально текущей величине. Если вы платите $10/мес — повышение на $1 заметно (10%). Если платите $18 — повышение на $1 почти незаметно (5.5%). Netflix годами эксплуатирует именно этот эффект: чем выше база, тем смелее можно повышать в абсолютных числах, оставаясь ниже порога восприятия.
</div>

---

## Повышатели vs. Держатели

<div class="compare">
  <div class="compare-col col-a">
    <h4>Повышают цены ↑</h4>
    <div class="compare-item"><strong>Netflix</strong><span>7 повышений за 15 лет. Standard: $7.99 → $17.99. 325M подписчиков.</span></div>
    <div class="compare-item"><strong>Disney+</strong><span>+172% за 6 лет. Стартовая $6.99 была демпингом для захвата рынка.</span></div>
    <div class="compare-item"><strong>Spotify</strong><span>12 лет по $9.99, потом 3 удара по $1. 276M платных, 696M MAU.</span></div>
    <div class="compare-item"><strong>Adobe CC</strong><span>Perpetual → подписка → повышения. Но AI подрывает lock-in: акции −40%.</span></div>
    <div class="compare-item"><strong>Xbox Game Pass</strong><span>$14.99 → $29.99 за ночь. Сайт отмены рухнул.</span></div>
  </div>
  <div class="compare-col col-b">
    <h4>Держат цены ↓</h4>
    <div class="compare-item"><strong>World of Warcraft</strong><span>$14.99/мес с ноября 2004. 21 год, $0 изменений. Реально — скидка 41%.</span></div>
    <div class="compare-item"><strong>Planet Fitness</strong><span>$10/мес 26 лет. Затем +50% до $15 — но только для новых клиентов.</span></div>
    <div class="compare-item"><strong>EA Play</strong><span>$4.99/мес с 2014. 11 лет без изменений.</span></div>
    <div class="compare-item"><strong>Nintendo Switch Online</strong><span>$19.99/год с 2018. 7+ лет.</span></div>
    <div class="compare-item"><strong>Costco</strong><span>+$5 раз в 5–7 лет. $60 → $65 в 2024.</span></div>
  </div>
</div>

<div class="highlight-box">
<strong>Ключевой вопрос:</strong> подписка — это продукт или ворота к другим тратам? Netflix — продукт (единственный путь роста: цены или реклама). Costco и WoW — ворота (членство стимулирует $1,170/год на маркетплейсе или микротранзакции в игре). В экономике это называется <strong>two-part tariff</strong> — двухчастный тариф. Первая часть (подписка) низкая или фиксированная, вторая (покупки внутри) — переменная и прибыльная. Amusement park: входной билет + аттракционы. Costco: членство $65/год + товары со скидкой. Amazon Prime: $139/год + $1,170 покупок. WoW: $14.99/мес + токены и косметика.
</div>

---

## Тёмная сторона: как подписки удерживают вопреки желанию

### Roach Motel: вход за 2 клика, выход за 15

Термин **«roach motel»** (мотель для тараканов) придумал UX-дизайнер Гарри Бриньюл: это интерфейс, в который легко войти и почти невозможно выйти. Попасть внутрь — 2 клика и данные карты. Выйти — лабиринт из «вы уверены?», «вот скидка 50%», «вы потеряете все данные». Это не баг, а стратегия: каждый дополнительный шаг на пути к отмене снижает вероятность отмены на ~10–15%.

[Исследование FTC/ICPEN](https://www.ftc.gov/news-events/news/press-releases/2024/07/ftc-icpen-gpen-announce-results-review-use-dark-patterns-affecting-subscription-services-privacy) (июль 2024) проверило 642 подписочных сайта в 26 странах: **76% использовали хотя бы один тёмный паттерн**, 67% — несколько. Средняя отмена подписки требует [6.7 кликов от главной страницы](https://www.emailtooltester.com/en/blog/dark-patterns-canceling-subscription-report/) и включает 6.2 манипулятивных элемента.

В Великобритании [10 миллионов из 155 миллионов активных подписок — нежелательные](https://home.barclays/insights/2025/10/Next-Phase-Subscription-Economy/), что обходится потребителям в £1.6 млрд ежегодно. FTC получает ~70 жалоб в день на принудительные подписки — рост на 67% с 2021 года.

<div class="metrics">
  <div class="metric"><div class="val val--red">76%</div><div class="desc">Подписочных сайтов с тёмными паттернами (FTC/ICPEN, 2024)</div></div>
  <div class="metric"><div class="val val--blue">6.7</div><div class="desc">Средних кликов для отмены подписки</div></div>
  <div class="metric"><div class="val val--yellow">$2.5B</div><div class="desc">Штраф Amazon за тёмные паттерны</div></div>
  <div class="metric"><div class="val val--red">70/день</div><div class="desc">Жалоб в FTC на принудительные подписки</div></div>
</div>

### Amazon «Iliad»: $2.5 млрд за лабиринт отмены

[FTC подала иск против Amazon](https://www.dglaw.com/a-prime-example-of-dark-patterns-ftc-sues-amazon-for-use-of-dark-patterns-in-prime-enrollment/) в июне 2023. Внутренняя система отмены Prime называлась **«Iliad»** — в честь гомеровской поэмы о десятилетней Троянской войне. Подписка за 2 клика. Отмена — [4 страницы, 6 кликов, 15 вариантов](https://www.npr.org/2025/09/23/nx-s1-5543497/the-dark-patterns-at-the-center-of-ftcs-lawsuit-against-amazon). На мобильном — 8 страниц и 8 кликов минимум. Сотрудники Amazon называли нежелательные подписки «незаметным раком».

По внутренним оценкам Amazon, **35 миллионов человек были подписаны на Prime без осознанного согласия** за 7 лет. Когда Amazon в тестах упростил отмену — подписки упали, и изменения [немедленно откатили](https://inequality.org/article/the-good-and-bad-of-amazons-dark-patterns-settlement/).

[Урегулирование за $2.5 млрд](https://quickreads.ext.katten.com/post/102l7e6/ftcs-landmark-2-5-billion-amazon-settlement-highlights-ongoing-focus-on-dark-p) (сентябрь 2025): $1 млрд штрафа + $1.5 млрд возвратов потребителям (до $51 каждому). Крупнейшее в истории FTC.

### Другие: Adobe, Uber, фитнес-клубы

**Adobe**: [FTC/DOJ подали иск](https://www.techtarget.com/searchcio/news/366593576/FTC-DOJ-take-aim-at-dark-patterns-with-Adobe-lawsuit) в июне 2024 за скрытые штрафы досрочного расторжения (50% стоимости оставшегося контракта), зарытые в мелкий шрифт при подписке. **Uber One**: [23 экрана и 32 действия](https://www.coulsonpc.com/coulson-pc-blog/dark-patterns-ftc-click-to-cancel-rule) для отмены подписки, на которую подписаны 28M человек. **LA Fitness**: только лично или заказным письмом.

### Регуляторный ответ

<div class="compare">
  <div class="compare-col col-a">
    <h4>США: «Click to Cancel» в суде</h4>
    <div class="compare-item"><strong>FTC Click-to-Cancel Rule</strong><span>Принято в октябре 2024. Аннулировано 8-м округом в июле 2025. FTC начинает процедуру заново — новое правило через 2–3 года.</span></div>
    <div class="compare-item"><strong>California CARL</strong><span>Де-факто национальный стандарт. Кнопка «отменить» обязательна. $2,500/нарушение. 25+ штатов с аналогичными законами.</span></div>
  </div>
  <div class="compare-col col-b">
    <h4>Европа: кнопка «Отменить контракт»</h4>
    <div class="compare-item"><strong>Директива EU 2023/2673</strong><span>Обязательная кнопка «Cancel my contract» на всех сайтах. Дедлайн — июнь 2026.</span></div>
    <div class="compare-item"><strong>Digital Fairness Act</strong><span>Предложение ожидается Q4 2026. Цель — системный запрет тёмных паттернов.</span></div>
  </div>
</div>

---

## Amazon: машина с маховиком

Amazon Prime — самая успешная gateway-подписка в истории. Не потому что контент великолепен (Amazon тратит [$22.4 млрд/год на контент](https://www.fanbolt.com/168164/amazon-spent-22-4-billion-on-content-last-year-and-that-number-changes-the-netflix-conversation/) — больше, чем Netflix). А потому что подписка делает покупателя «своим»: Prime-участники тратят [$1,170/год на Amazon](https://capitaloneshopping.com/research/amazon-prime-statistics/) vs $570 у неподписанных. Соотношение 2:1 стабильно годами.

<div class="metrics">
  <div class="metric"><div class="val val--green">200M+</div><div class="desc">Участников Prime глобально (оценка 2025)</div></div>
  <div class="metric"><div class="val val--blue">$1,170</div><div class="desc">Средний годовой расход Prime-участника</div></div>
  <div class="metric"><div class="val val--yellow">$69B</div><div class="desc">Рекламная выручка Amazon, 2025</div></div>
  <div class="metric"><div class="val val--red">2%</div><div class="desc">Отток Prime в США за 2024</div></div>
</div>

Но главная история Amazon — не Prime Video. Это **реклама**. Amazon — [третья рекламная платформа в мире](https://www.marketplacepulse.com/articles/amazon-sells-more-retail-ads-than-google) после Google и Meta: $69 млрд в 2025 году, +22% к предыдущему году. В январе 2024 Amazon [вставил рекламу во все Prime Video](https://www.emarketer.com/content/amazon-prime-videos-2024-ad-launch-turned-streaming-on-its-head) по умолчанию, предложив отключить за $2.99/мес. ~85% зрителей приняли рекламу. Так Amazon мгновенно создал крупнейшую рекламную стриминговую аудиторию: ~104M зрителей в США.

<div class="highlight-box">
<strong>Цена Prime по миру:</strong> США — $14.99/мес · UK — £8.99 · Германия — €8.99 · Япония — ¥600 ($4.10) · Индия — ₹299 ($3.61) · Египет — 29 EGP ($0.94). Разброс в 16 раз — от $0.94 до $14.99 за один и тот же бренд.
</div>

---

## Подписка + Реклама: конвергенция

Главный структурный сдвиг последних лет: стена между подпиской и рекламой рухнула.

### Netflix: от «никогда не будет рекламы» до 190M зрителей с рекламой

Netflix запустил рекламный тариф в ноябре 2022. За три года он стал двигателем роста:

<div class="bars">
  <div class="bar-row"><div class="label">Янв 2024</div><div class="track"><div class="fill" style="width:12%">23M</div></div><div class="pct">23M</div></div>
  <div class="bar-row"><div class="label">Май 2024</div><div class="track"><div class="fill" style="width:21%">40M</div></div><div class="pct">40M</div></div>
  <div class="bar-row"><div class="label">Ноя 2024</div><div class="track"><div class="fill" style="width:37%">70M</div></div><div class="pct">70M</div></div>
  <div class="bar-row"><div class="label">Май 2025</div><div class="track"><div class="fill" style="width:49%">94M</div></div><div class="pct">94M</div></div>
  <div class="bar-row"><div class="label">Ноя 2025</div><div class="track"><div class="fill" style="width:100%">190M зрителей</div></div><div class="pct">190M</div></div>
</div>

[45% домохозяйств Netflix в США](https://www.statista.com/statistics/1485182/netflix-monthly-ad-supported-users-global/) используют рекламный тариф. ~55% новых подписок — с рекламой. Рекламная выручка [превысила $1.5 млрд в 2025](https://www.deloitte.com/us/en/insights/industry/technology/video-streaming-services-churn-rate.html) — и аналитики Wedbush прогнозируют, что реклама станет «основным драйвером выручки в 2026».

### Три уровня видеоконтента

Рынок реорганизовался в три слоя:

- **SVOD** (подписка): $98–128 млрд глобально, 1.59 млрд подписок
- **AVOD** (реклама по запросу): $34–55 млрд, рост 6–8% в год
- **FAST** (бесплатное с рекламой): [$9.7 млрд → $27 млрд к 2030](https://store.frost.com/the-evolution-of-the-global-video-on-demand-market.html) (+17.2% CAGR)

Критический факт: [71% новых стриминговых подписчиков](https://www.deloitte.com/us/en/insights/industry/technology/video-streaming-services-churn-rate.html) за последние 9 кварталов выбрали тариф с рекламой. У Netflix и Disney+ **100%+ чистого прироста в США** пришлось на рекламные тарифы — безрекламные подписчики сокращаются.

<div class="highlight-box">
<strong>Spotify: экономика перекоса.</strong> 276M платных подписчиков генерируют ~88% выручки. 420M бесплатных пользователей — лишь ~12%. Первая годовая прибыль в истории: €1.14 млрд в 2024 на выручке €15.7 млрд. Реклама приносит ~$2 млрд/год.
</div>

### Усталость от рекламы: где потолок?

Стриминговые сервисы держат [4–5 минут рекламы в час](https://www.deloitte.com/us/en/insights/industry/technology/video-streaming-services-churn-rate.html) — при 14–20 минутах на линейном ТВ. Порог терпимости — ~7 мин/час (Deloitte). Но Amazon уже удвоил рекламную нагрузку с ~3 до 4–6 мин за первый год. Знакомая траектория.

**Три сценария развития:**

1. **Реклама побеждает (60% вероятность).** К 2030 все крупные стриминги — с рекламой по умолчанию. Безрекламный премиум — дорогая опция ($25–30/мес). Рекламная нагрузка постепенно растёт до 8–10 мин/час.

2. **Гибрид стабилизируется (30%).** Сервисы находят баланс: лёгкая реклама + подписка = устойчивая модель. AI-персонализация делает рекламу менее раздражающей. Рекламная нагрузка не превышает 5 мин/час.

3. **Потребительский бунт (10%).** Усталость от рекламы + от подписок одновременно → взрывной рост пиратства и ad-blocking, коллапс ARPU, вынужденное возвращение к ценности контента.

---

## Благотворительность как подписка

Подписочная модель проникла туда, где деньги не связаны с продуктом — в пожертвования. И, как ни странно, именно здесь она работает лучше всего.

### Planet Wild: Netflix для планеты

[Planet Wild](https://planetwild.com) (Берлин, 2023) — один из самых наглядных примеров нового типа: подписка на спасение природы. Модель элементарна: вы платите [€6–500/мес](https://planetwild.com/membership), команда каждый месяц проводит одну природоохранную миссию с профессиональной съёмкой, подписчики голосуют за направление (леса, океан, животные, осведомлённость). Каждая миссия задокументирована на [YouTube](https://www.youtube.com/@PlanetWild) (~250K подписчиков), и это одновременно отчёт и воронка привлечения.

<div class="metrics">
  <div class="metric"><div class="val val--green">10,000+</div><div class="desc">Участников к концу 2024</div></div>
  <div class="metric"><div class="val val--blue">35+</div><div class="desc">Миссий в 25+ странах</div></div>
  <div class="metric"><div class="val val--yellow">€754K</div><div class="desc">Выручка 2024 (+444% к 2023)</div></div>
  <div class="metric"><div class="val val--red">85%</div><div class="desc">Средств идёт на миссии</div></div>
</div>

Источники: [Planet Wild Transparency](https://planetwild.com/transparency), [Rewilding Magazine](https://www.rewildingmag.com/the-group-using-youtube-to-rewild-the-planet/), [B Corp](https://www.bcorporation.net/en-us/find-a-b-corp/company/climate-labs-gmb-h/) (оценка 90.0 при медиане 50.9)

<div class="highlight-box">
<strong>Почему это работает как подписка, а не как благотворительность?</strong> Классическая благотворительность — это разовый акт веры: вы отдаёте деньги и надеетесь, что они пошли на дело. Planet Wild — это подписка в чистом виде: ежемесячный платёж → видимый результат → эмоциональное подкрепление через видео → продление. Та же петля, что у Netflix (контент каждый месяц), только вместо сериала — восстановление кораллового рифа.
</div>

Похожая модель — **[Mossy Earth](https://www.mossyearth.com)** (UK, 2017): £5/мес, 14,600+ участников, £1.7M выручки, 643K подписчиков на YouTube. Акцент на rewilding в Европе: посадка деревьев, восстановление болот, реинтродукция видов.

### charity: water — подписка с «моделью 100%»

[charity: water](https://www.charitywater.org) довела идею до совершенства. Их программа «[The Spring](https://www.charitywater.org/join-us)» (с 2016): 62,000 ежемесячных подписчиков, $19.8M рекуррентной выручки, рост 40%/год. Общая выручка FY2024 — [$104.9M](https://assets.ctfassets.net/2w85ks0ylymt/4cROclPCnsZlyXB57vNiNv/31383a0ffcb98ad16239d062099564da/183791_-_FY_2024_Annual_Report_Final.pdf), обслужено 20M+ людей в 29 странах, собрано более $1 млрд за всё время.

Ключевая инновация — **«модель 100%»**: все публичные пожертвования идут на проекты. Операционные расходы покрывает отдельный круг частных доноров («The Well»). Каждый проект отслеживается через GPS и фото. Это убирает главный барьер доверия: «а точно ли мои деньги дойдут?»

### Экосистема подписочной филантропии

<div class="compare">
  <div class="compare-col col-a">
    <h4>Подписка на природу</h4>
    <div class="compare-item"><strong>Planet Wild</strong><span>€6/мес, 10K+ участников, видео-миссии</span></div>
    <div class="compare-item"><strong>Mossy Earth</strong><span>£5/мес, 14.6K участников, rewilding</span></div>
    <div class="compare-item"><strong>One Tree Planted</strong><span>$1 = 1 дерево. 135M деревьев, $57.6M выручки (2023)</span></div>
    <div class="compare-item"><strong>4ocean</strong><span>$20 браслет = 5 фунтов мусора. 40M+ фунтов убрано</span></div>
    <div class="compare-item"><strong>charity: water</strong><span>«The Spring»: 62K подписчиков, 100% модель</span></div>
  </div>
  <div class="compare-col col-b">
    <h4>Подписка «без подписки»</h4>
    <div class="compare-item"><strong>Ecosia</strong><span>Поисковик, сажающий деревья. 230M+ деревьев, 3.4M MAU. Ваше привычное поведение = донат</span></div>
    <div class="compare-item"><strong>Too Good To Go</strong><span>120M пользователей, 500M+ спасённых порций еды. Покупка со скидкой = impact</span></div>
    <div class="compare-item"><strong>1% for the Planet</strong><span>5,100 компаний отдают 1% выручки. $728M+ за всё время. Patagonia — основатель</span></div>
    <div class="compare-item"><strong>TeamTrees / TeamSeas</strong><span>MrBeast: $24.9M → 24M деревьев. $34.1M → 34M фунтов мусора. Вирусные кампании</span></div>
    <div class="compare-item"><strong>Wikipedia</strong><span>$208.6M/год. Средний донат $10.58. «Стратегия микрозапроса»</span></div>
  </div>
</div>

### Почему retention благотворительных подписок выше Netflix

<div class="metrics">
  <div class="metric"><div class="val val--red">42.9%</div><div class="desc">Общий retention доноров (все типы)</div></div>
  <div class="metric"><div class="val val--green">77–90%</div><div class="desc">Retention рекуррентных доноров</div></div>
  <div class="metric"><div class="val val--blue">8+ лет</div><div class="desc">Средний срок жизни подписчика-донора</div></div>
  <div class="metric"><div class="val val--yellow">9×</div><div class="desc">Lifetime value подписчика vs разового донора</div></div>
</div>

Источники: [Neon One Recurring Giving Report 2024](https://neonone.com/resources/blog/donor-retention/), [M+R Benchmarks 2025](https://mrbenchmarks.com/key-findings), [CharityEngine](https://blog.charityengine.net/recurring-giving-statistics)

<div class="highlight-box">
<strong>Простым языком:</strong> Netflix удерживает ~78% подписчиков в год. Spotify — ~88%. Рекуррентные доноры — 77–90%. Парадокс: подписка без продукта (чистая филантропия) удерживает так же или лучше, чем подписка с продуктом. Причина — <em>identity signaling</em>: «я — человек, который ежемесячно спасает планету» становится частью самоощущения, а отмена = потеря этой идентичности. Тот же механизм, что у WoW, только вместо «я — рейдер» — «я — часть Planet Wild community».
</div>

### Десятина: подписочная модель на 3000 лет

[Религиозные пожертвования](https://www.vancopayments.com/egiving/asset-church-giving-statistics-tithing) — $146.5 млрд в 2024 (23% всей благотворительности в США). Это самая старая подписочная модель в мире: рекуррентный платёж за принадлежность к сообществу. 98% мест поклонения теперь принимают цифровые платежи. 42% цифровых пожертвований — рекуррентные. Онлайн-десятина увеличивает общую сумму на 32%.

Но база сжимается: [членство в церквях упало с 70% до 47%](https://news.gallup.com/poll/341963/church-membership-falls-below-majority-first-time.aspx) между 1999 и 2020. ~15K церквей закроются в 2025. Planet Wild и charity: water, по сути, наследуют ту же модель: рекуррентный платёж + чувство принадлежности + видимый результат. Только вместо спасения души — спасение рифа.

### Креаторская экономика: подписка на человека

Отдельная ветка — подписка не на организацию, а на конкретного автора. **[Patreon](https://backlinko.com/patreon-users)**: $10 млрд выплачено создателям за всё время, 296K авторов, 15.9M подписок. Но рост стагнирует, валюация рухнула с $4 до $1.5 млрд. **[Substack](https://sacra.com/c/substack/)**: 5M платных подписок, $450M/год авторам, но **churn ~50% в год** — каждый второй платный уходит.

<div class="highlight-box">
<strong>Почему Substack теряет, а Planet Wild держит?</strong> Ключевое отличие — <em>единица ценности</em>. На Substack вы платите за поток текстов одного автора — и когда темп публикаций падает или контент надоедает, ценность обнуляется. В Planet Wild каждый месяц — новая миссия, новая страна, видимый физический результат. Substack продаёт внимание. Planet Wild продаёт чувство причастности к действию. Второе оказывается прочнее.
</div>

---

## За пределами Запада: подписка в пяти мирах

### Африка: подписка без банковского счёта

57% взрослого населения Африки южнее Сахары не имеют банковского счёта. Подписочная экономика здесь строится на мобильных деньгах.

M-Pesa: 40M активных пользователей только в Кении, 21M транзакций в день, $309 млрд/год. [Safaricom вкладывает $309M/год](https://techcabal.com/2025/05/06/safaricom-309mn-m-pesa/) в модернизацию. В сентябре 2024 запущен **M-Pesa Ratiba** — автоматический рекуррентный платёж для подписок, [1 млн подключений за первый месяц](https://techcabal.com/2025/05/06/safaricom-309mn-m-pesa/).

**DStv** (MultiChoice) — крупнейший подписочный бизнес на континенте. Но катастрофа: с [17.3M подписчиков (март 2023) до 13.1M (июнь 2025)](https://www.tickerreport.com/banking-finance/13329019/canaan-canal-targets-e400m-cost-synergies-by-2030-after-multichoice-deal-eyes-africa-growth.html). В Кении — обвал на 80% за год. Canal+ купил MultiChoice за $3.17 млрд и пытается спасти.

**Showmax** перезапустился в феврале 2024 на технологиях Peacock: от $2.09/мес. К марту 2026 — [закрыт](https://www.tickerreport.com/banking-finance/13329019/canaan-canal-targets-e400m-cost-synergies-by-2030-after-multichoice-deal-eyes-africa-growth.html). Убытки: R4.9 млрд. CEO Canal+: «Финансово и коммерчески — это не работает.» Фундаментальная проблема: в Африке **62–81% расходов на медиа** уходит на подключение к интернету, а не на контент.

### Европа: GDPR, пэйволлы и кризис подписочных коробок

Европейская подписочная экономика — [€129 млрд в 2024](https://www.grandviewresearch.com/horizon/outlook/subscription-economy-market/europe) (26% мирового рынка). GDPR снизил конверсию подписок [с 4.1% до 2.8%](https://www.enchantagency.com/blog/navigating-gdpr-effects-on-email-marketing-strategies), но оставшиеся подписчики — более вовлечённые. Кумулятивные штрафы GDPR — [€5.88 млрд к январю 2025](https://dataprivacymanager.net/5-biggest-gdpr-fines-so-far-2020/).

Подписочные коробки: после пандемического бума — [коррекция](https://www.whistl.co.uk/news/82-uk-households-now-receive-subscription-boxes). Спрос на косметические коробки упал на 57%, на рецепты — на 39%. Graze (пионер снек-подписок) [закрылся в 2024](https://en.wikipedia.org/wiki/Graze_(company)). Но 81% домохозяйств UK всё ещё получают коробки.

Газетные пэйволлы — европейская история успеха. [FT](https://pressgazette.substack.com/p/ft-hits-540m-global-revenue-in-2024): 1.4M платных подписчиков, рекордные £540M выручки, AI-пэйволл увеличил конверсию на [290%](https://digiday.com/media/the-financial-times-ai-paywall-drove-conversions-up-290-now-its-learning-who-stays/). [Economist](https://pressgazette.co.uk/media_business/economist-subscriptions-profit-revenue-2025/): 1.25M подписчиков (68% digital-only). [Le Monde](https://pressgazette.co.uk/paywalls/le-monde-subscriptions-digital-ceo-louis-dreyfus/): 660K подписчиков, 77% выручки от читателей, прибыль 9 лет подряд.

[Canal+](https://www.hollywoodreporter.com/business/business-news/canal-plus-2024-earnings-subscribers-acquisition-strategy-1236154245/): 26.9M подписчиков в 52 странах, €6.45 млрд выручки. Вышел на Лондонскую биржу в декабре 2024. [DAZN](https://en.wikipedia.org/wiki/DAZN): ~20M платных, $3.4 млрд выручки, но $1.46 млрд убытков. Владелец Лен Блаватник вложил $6 млрд. Sky Group: 23M клиентов, но убытки [удвоились до £224M](https://thedesk.net/2024/10/sky-group-fy-2024-earnings-comcast/).

### Япония: дефляционная осторожность

Японский рынок подписок (サブスク) — [¥896 млрд ($6 млрд)](https://www.statista.com/statistics/1096302/japan-subscription-service-market-size/) в 2022, движется к ¥1 трлн. Но: [73% японцев не подписаны ни на что](https://www.statista.com/statistics/1227394/japan-most-common-subscription-models/) (данные 2021). Стриминг — [$7.2 млрд в 2025](https://variety.com/2026/tv/news/japan-streaming-market-7-billion-1236663822/), 67.9M подписок.

25 лет дефляции создали глубокую ценовую чувствительность. Gen Z в Японии тратит [¥1,803/мес (~$12)](https://www.ukiyo-journal.com/en/article/subscription-spending-genz-japan-vs-world) на подписки — значительно меньше западных сверстников. Netflix Japan — ¥1,490/мес (~$10), Amazon Prime — ¥600 (~$4.10) — самый дешёвый Prime в мире. [U-NEXT](https://en.wikipedia.org/wiki/U-Next) — японский ответ на суперапп: ¥2,189/мес за видео + манга + журналы + спорт, 5M подписчиков.

[NHK](https://japantoday.com/category/features/opinions/japan-nhk-fees-in-2025-harassment-disguised-as-public-service) — самая спорная «подписка» в Японии. Обязательный сбор ¥1,100–1,950/мес. Генерирует ¥632 млрд/год. Но [21.4% домохозяйств не платят](https://blog.gaijinpot.com/do-you-have-to-pay-the-nhk-fee/). NHK подал 613 исков за неуплату. С 2024 NHK [может собирать деньги с интернет-пользователей](https://unseen-japan.com/nhk-fee-no-tv/) — но ожидает всего ¥100M/год дополнительно.

Гача-игры: [$11 млрд/год](https://automaton-media.com/en/news/japanese-gamers-average-gacha-spending-per-user-high-enough-to-offset-mobile-market-shrinkage-study-shows/) IAP-выручки. Средний платящий игрок — $807 (5× средней по Азии). Но [18.8% молодых японцев](https://www.techspot.com/news/107586-surge-microtransaction-spending-leaves-young-japanese-gamers-struggling.html) тратят на гачу так, что не хватает на жизнь.

### Азия: суперапп-экосистемы

**Китай**: Tencent Video — [117M подписчиков](https://www.statista.com/statistics/1277850/china-online-video-platform-tencent-video-subscription-number/) (Q1 2025, снижение). iQIYI — [~100M](https://variety.com/2026/tv/asia/iqiyi-full-year-revenues-2025-1236673417/), выручка −7%. [Bilibili](https://pandayoo.com/post/bilibili-is-chinas-youtube-finally-ready-for-primetime/) — 22.7M, первая прибыль в истории (Q4 2024). Проблема: Douyin и Kuaishou забирают внимание у длинного видео.

**Корея**: [Kakao](https://matrixbcg.com/blogs/competitors/kakaocorp) — KRW 7.87 трлн ($5.4 млрд) выручки, KakaoTalk на 97% смартфонов страны. [Naver](https://matrixbcg.com/blogs/how-it-works/navercorp) — первая корейская интернет-компания с выручкой >KRW 10 трлн ($7.6 млрд). Naver Plus Membership (KRW 4,900/мес ≈ $3.50) добавил Netflix — [подписки выросли в 1.5×](https://matrixbcg.com/blogs/how-it-works/navercorp). Naver Webtoon — [180M+ пользователей](https://www.kedglobal.com/webtoons/newsView/ked202208300016) глобально.

**ЮВА**: [GrabUnlimited](https://www.grab.com/sg/inside-grab/stories/grab-grabunlimited-subscription-plan-benefits/) — треть delivery GMV. Подписчики тратят в 4.2× больше на доставку еды. [GoTo](https://www.gotocompany.com/en/news/press/goto-group-beats-guidance-with-record-results-as-it-reports-2024-fourth-quarter-and-full-year-earnings) — первый положительный EBITDA (IDR 386 млрд). [Sea Group](https://fintechnews.sg/110502/fintech/sea-limited-profitability-2024-rebound/) (Shopee) — $16.8 млрд выручки, $448M прибыли.

**Индия**: OTT-рынок — [~$4.5 млрд](https://sscbs.du.ac.in/wp-content/uploads/2025/09/OTT-Industry-Report.pdf). [JioHotstar](https://www.smartprix.com/bytes/jiohotstar-officially-launches-in-india-check-plans-and-pricing/) — 500M пользователей, от ₹149/3 мес ($0.57/мес). Netflix India — [₹149–649/мес](https://streamfab.dvdfab.cn/blog/netflix-plans-india.htm), ~10–12M подписчиков. IPL-крикет — главный драйвер конверсии. Ключевая стратегия: [бандлинг с мобильными тарифами](https://www.thestreaminglab.com/p/how-netflix-is-riding-the-bundle).

---

## Пять моделей подписок

<div class="fw-grid">
  <div class="fw-card fw-card--red">
    <h4>Извлекающая</h4>
    <div class="fw-sub">Подписка = продукт. Повышай, пока отток позволяет.</div>
    <div class="fw-tags"><span>Netflix</span><span>Disney+</span><span>Spotify</span></div>
    <ul class="fw-list">
      <li>325M подписчиков Netflix, маржа 34%</li>
      <li>Ad tier — 190M зрителей, $1.5B выручки</li>
      <li>Boiling frog: +$1–2 каждые 12–24 мес</li>
    </ul>
  </div>
  <div class="fw-card fw-card--green">
    <h4>Входная</h4>
    <div class="fw-sub">Подписка = привлечение. Монетизируй рядом.</div>
    <div class="fw-tags"><span>Amazon Prime</span><span>Costco</span><span>WoW</span></div>
    <ul class="fw-list">
      <li>Prime: $1,170/год на маркетплейсе</li>
      <li>WoW: MTX 35% выручки при $14.99/мес</li>
      <li>Costco: +$5 раз в 5–7 лет</li>
    </ul>
  </div>
  <div class="fw-card fw-card--purple">
    <h4>Монопольная</h4>
    <div class="fw-sub">Альтернатив нет. Повышай, ссылаясь на AI.</div>
    <div class="fw-tags"><span>Adobe CC</span><span>Microsoft 365</span></div>
    <ul class="fw-list">
      <li>Lock-in через проприетарные форматы</li>
      <li>Но AI (Midjourney, Figma) подрывает ров</li>
      <li>Adobe: акции −40%</li>
    </ul>
  </div>
  <div class="fw-card fw-card--blue">
    <h4>Инфраструктурная</h4>
    <div class="fw-sub">Подписка = доступ к экономике.</div>
    <div class="fw-tags"><span>M-Pesa</span><span>OPay</span><span>MTN MoMo</span></div>
    <ul class="fw-list">
      <li>280M аккаунтов mobile money в Африке</li>
      <li>M-Pesa Ratiba для рекуррентных платежей</li>
      <li>Ценность — финансовое включение, не контент</li>
    </ul>
  </div>
  <div class="fw-card fw-card--teal">
    <h4>Экосистемная</h4>
    <div class="fw-sub">Подписок много, но все — внутри одной среды.</div>
    <div class="fw-tags"><span>WeChat</span><span>JioHotstar</span><span>Grab</span></div>
    <ul class="fw-list">
      <li>WeChat: 1.4B MAU, 45% мобильного времени в Китае</li>
      <li>JioHotstar: 500M пользователей, от $0.57/мес</li>
      <li>Подписка — строчка в потоке микротранзакций</li>
    </ul>
  </div>
</div>

---

## Парадокс WoW

<div class="case-box">
  <h4>World of Warcraft</h4>
  <div class="case-meta">$14.99/мес с ноября 2004 — 21 год без единого изменения</div>

  <div class="metrics">
    <div class="metric"><div class="val val--green">$25.22</div><div class="desc">$14.99 (2004) с учётом инфляции</div></div>
    <div class="metric"><div class="val val--red">−41%</div><div class="desc">Реальное снижение цены</div></div>
    <div class="metric"><div class="val val--blue">~9M</div><div class="desc">Подписчиков (оценка 2025)</div></div>
    <div class="metric"><div class="val val--yellow">$20</div><div class="desc">WoW Token — на $5 дороже самой подписки</div></div>
  </div>

Bobby Kotick (ex-CEO): *«Это колючая аудитория. Не стоит их слишком раздражать. Даже повышение на доллар стало бы проблемой.»* ([Icy Veins](https://www.icy-veins.com/wow/news/activision-blizzard-ex-ceo-bobby-kotick-on-why-he-refused-to-raise-the-price-of-wows-subscription/))

**2004–2010:** Подписка 85%, дополнения 15%, MTX 0%.
**2020–2026:** Подписка ~50%, MTX/токены ~35%, дополнения ~15%.

Контрпример: **EVE Online** повысил на 33% ($14.95→$19.99) в мае 2022 после 18 лет заморозки. Жёсткий backlash — укрепил решение Blizzard не трогать $14.99.
</div>

---

## Почему мы продолжаем платить

<div class="psych-grid">
  <div class="psych-card">
    <h4>Неприятие потерь</h4>
    <p>Потеря Netflix ощущается в 2× болезненнее экономии от отмены. 42% откладывают отмену даже будучи недовольными. <a href="https://en.wikipedia.org/wiki/Prospect_theory">Kahneman & Tversky, 1979</a></p>
    <p><strong>Простым языком:</strong> мозг обрабатывает потери и приобретения асимметрично. Радость от найденных $100 слабее, чем боль от потерянных $100. Применительно к подпискам: отмена = потеря доступа к библиотеке, и эта «потеря» ощущается сильнее, чем радость от экономии $18/мес. Поэтому мы платим за то, чем не пользуемся.</p>
    <div class="big">2×</div>
  </div>
  <div class="psych-card">
    <h4>Подписочная слепота</h4>
    <p>72% потребителей недооценивают расходы на подписки на ~40%. 55% держат неиспользуемую подписку. 12 подписок на среднее US-домохозяйство.</p>
    <p><strong>Простым языком:</strong> это называется <em>mental accounting</em> — ментальная бухгалтерия. Человек не суммирует 12 отдельных списаний по $10–18 в общую сумму $150–200/мес. Каждая подписка живёт в отдельном «ящике» в голове, и ни одна сама по себе не кажется дорогой. Компании это знают: чем больше подписок у человека, тем менее заметна каждая следующая.</p>
    <div class="big">72%</div>
  </div>
  <div class="psych-card">
    <h4>Варёная лягушка</h4>
    <p>Netflix: +$1–2 каждые 12–24 мес. Ниже <a href="https://en.wikipedia.org/wiki/Weber%E2%80%93Fechner_law">Just Noticeable Difference</a> — порога, при котором человек замечает изменение цены и действует.</p>
    <p><strong>Простым языком:</strong> когда Netflix повышает цену с $15.49 до $17.99 — это ощущается. Но когда повышение дробится на два шага ($15.49→$16.99→$17.99 с интервалом в год) — каждый шаг «незаметен». В поведенческой экономике это называют <em>инкрементализм</em>: серия маленьких изменений, каждое из которых ниже порога реакции. Метафора лягушки в медленно нагреваемой воде — физиологически неточна, но экономически — работает безупречно.</p>
    <div class="big">JND</div>
  </div>
  <div class="psych-card">
    <h4>Моральная справедливость</h4>
    <p>Netflix 2011: +60% — предательство, −800K подписчиков. То же повышение за 5 лет — норма. <a href="https://web.mit.edu/curhan/www/docs/Articles/15341_Readings/Justice/Kahneman.pdf">Kahneman, Knetsch & Thaler, 1986</a></p>
    <p><strong>Простым языком:</strong> люди оценивают цены не калькулятором, а моральным компасом. Исследование 1986 года показало: если магазин повышает цену на лопату после снегопада — люди считают это нечестным, даже если спрос объективно вырос. Та же логика работает с подписками. «Мы повышаем, чтобы инвестировать в контент» — приемлемо (есть причина). «Мы повышаем, потому что можем» — предательство (нет оправдания). Итог одинаковый, восприятие — противоположное.</p>
    <div class="big">60%≠5×12%</div>
  </div>
</div>

Subscription fatigue: [41% потребителей](https://www.worldfinance.com/strategy/the-subscription-economy-slowdown) жалуются на перегруз. 37% Gen Z [уже отменили подписки](https://civicscience.com). Практика serial churning (подписался на месяц → посмотрел сериал → отписался) становится нормой. Видеочурн достиг [рекордных 44% в Q4 2024](https://www.deloitte.com/us/en/insights/industry/technology/video-streaming-services-churn-rate.html).

<div class="highlight-box">
<strong>Как компании рассчитывают повышения:</strong> Каждое повышение проходит через модель <em>churn price elasticity</em> — насколько вырастет отток при росте цены на 1%. У Netflix эластичность ~2–3%: при повышении на 10%, уходит 2–3% базы, но оставшиеся платят больше — чистый плюс. Компании используют ML-модели на индивидуальном уровне: кому показать скидку перед повышением, кому — нет. Цель — поднять цену ровно до точки, где дополнительный доход с оставшихся превышает потерю ушедших.
</div>

---

## Провалы и удачи

<div class="timeline">
  <div class="tl-item"><div class="tl-dot tl-dot--red"></div><div class="tl-year">2011</div><div class="tl-title">Netflix Qwikster — +60%</div><div class="tl-desc">−800K подписчиков, акции −77%. Травма, определившая стратегию на 14 лет.</div></div>
  <div class="tl-item"><div class="tl-dot tl-dot--red"></div><div class="tl-year">2017–19</div><div class="tl-title">MoviePass — $9.95 за кино каждый день</div><div class="tl-desc">−$20M/мес. Churn >90%. Trip wires для блокировки активных. DOJ: fraud.</div></div>
  <div class="tl-item"><div class="tl-dot"></div><div class="tl-year">2022 Q1</div><div class="tl-title">Netflix: первая потеря подписчиков</div><div class="tl-desc">Wall Street перешёл от growth к ARPU. Все стримеры начали повышать цены.</div></div>
  <div class="tl-item"><div class="tl-dot tl-dot--red"></div><div class="tl-year">2023 июн</div><div class="tl-title">FTC vs Amazon: «Project Iliad»</div><div class="tl-desc">35M нежелательных подписок. $2.5B урегулирование. Крупнейшее в истории FTC.</div></div>
  <div class="tl-item"><div class="tl-dot tl-dot--green"></div><div class="tl-year">2024 янв</div><div class="tl-title">Amazon вставил рекламу в Prime Video</div><div class="tl-desc">По умолчанию. 85% приняли. Мгновенно — крупнейшая рекламная аудитория в стриминге.</div></div>
  <div class="tl-item"><div class="tl-dot tl-dot--green"></div><div class="tl-year">2024 ноя</div><div class="tl-title">JioHotstar: 500M пользователей от $0.57/мес</div><div class="tl-desc">Индийское слияние Viacom18 + Star India. Gateway-модель на масштабе полумиллиарда.</div></div>
  <div class="tl-item"><div class="tl-dot tl-dot--red"></div><div class="tl-year">2025 июл</div><div class="tl-title">FTC Click-to-Cancel аннулировано судом</div><div class="tl-desc">8-й округ отменил правило. Процедурный провал. Новая попытка — 2–3 года.</div></div>
  <div class="tl-item"><div class="tl-dot tl-dot--green"></div><div class="tl-year">2025</div><div class="tl-title">Netflix: 325M, маржа 34%</div><div class="tl-desc">Ad tier 190M зрителей, $1.5B рекламной выручки. Варёная лягушка, отточенная за 14 лет.</div></div>
  <div class="tl-item"><div class="tl-dot tl-dot--red"></div><div class="tl-year">2025 окт</div><div class="tl-title">Xbox Game Pass: +50% за ночь</div><div class="tl-desc">$19.99 → $29.99. Сайт отмены рухнул. GameStop публично высмеял Microsoft.</div></div>
  <div class="tl-item"><div class="tl-dot tl-dot--red"></div><div class="tl-year">2026 мар</div><div class="tl-title">Showmax закрыт после R4.9 млрд убытков</div><div class="tl-desc">Африканский стриминг не работает при 62–81% расходов на подключение.</div></div>
</div>

---

## Прогноз: 2026–2030 и дальше

### Что произойдёт

**Бандлинг — определяющий тренд.** Подписочные коробки отдельных сервисов перепакуются в мега-бандлы. [Apple уже превысил 1 млрд подписок](https://www.thestreaminglab.com/p/how-netflix-is-riding-the-bundle). Disney+/Hulu/ESPN объединяются. T-Mobile даёт Netflix. Verizon даёт Disney+. 66% домохозяйств со стримингом [уже используют хотя бы один AVOD-сервис](https://www.deloitte.com/us/en/insights/industry/technology/video-streaming-services-churn-rate.html). К 2028 мы получим 3–4 мега-бандла, похожих на кабельные пакеты 2000-х. Цикл завершён.

**AI-персонализация уменьшит churn.** [35% снижение оттока](https://www.worldfinance.com/strategy/the-subscription-economy-slowdown) при использовании AI-предиктивных моделей. FT показал: AI-пэйволл увеличил конверсию на 290%. К 2028 каждый стример будет использовать AI для динамического ценообразования — разным пользователям разные цены.

**Реклама станет нормой, а не исключением.** По текущей траектории: к 2028 >80% стриминговых подписчиков — на тарифах с рекламой. Безрекламный стриминг — $25–30/мес. Рекламная нагрузка — 6–8 мин/час (вдвое больше текущей). Attention budget — физически фиксирован, поэтому рекламодатели переплачивают за «гарантированное внимание» в стриминге vs дешёвый инвентарь соцсетей.

**Регулирование ужесточится.** EU Digital Fairness Act (ожидается Q4 2026) создаст самый строгий режим. «Cancel my contract» кнопка обязательна с июня 2026. Калифорния продолжит устанавливать стандарты для США. К 2030 «roach motel» как бизнес-модель будет юридически невозможен в ЕС и 30+ штатах.

### Три мира подписок к 2030

**Запад ($25–30/мес):** 3–4 мега-бандла. Реклама по умолчанию. Безрекламный премиум — для 15–20% аудитории. Serial churning как норма. AI-динамическое ценообразование. Рынок: ~$600 млрд.

**Азия ($0.50–5/мес):** Суперапп-экосистемы. Подписка растворена в потоке транзакций. Micro-pricing. Бандлинг с телекомами. Реклама — основной доход, подписка — сигнал вовлечённости. Рынок: ~$350 млрд.

**Африка/развивающийся мир:** M-Pesa Ratiba и аналоги как инфраструктура. Контент — бесплатный или ультрадешёвый, монетизированный через mobile money комиссии и рекламу. Стриминг как loss leader для телекомов. Рынок: ~$50 млрд, но с самым высоким темпом роста.

<div class="highlight-box">
<strong>Фундаментальное противоречие:</strong> Подписочная экономика на $1.2 трлн требует ежегодного роста. Но ресурс, за который идёт борьба — человеческое внимание — биологически фиксирован. Глобальный screen time — 6.5–7 часов/день. Attention span на экране — 47 секунд (вдвое меньше, чем 12 лет назад). Каждый новый сервис отбирает минуты у существующего. Экономика бесконечного роста, построенная на конечном ресурсе. Что-то должно уступить.
</div>

---

*Данные: финансовые отчёты компаний, FTC, GSMA, BLS, Statista, Deloitte, Antenna Analytics, Grand View Research, CIRP, Variety, TechCabal, Sacra. Исследование проведено с Claude (Anthropic). Март 2026. Версия 4.0.*
