---
title: "Auktionsmechanik: Von Christie's bis Google Ads"
date: 2026-03-27
lastmod: 2026-03-27
version: "1.0"
status: "in-progress"
confidence: "likely"
description: "Vier Auktionsformate, zwei Nobelpreise, ein Theorem — und warum die Gebotsregeln den Preis bestimmen, nicht umgekehrt. Von Christie's und 5G-Spektrum bis programmatische Werbung und EU ETS."
tags: ["Wirtschaft", "Auktionstheorie", "Programmatic", "Mechanismus-Design", "Spieltheorie"]
series: "Information ≠ Verständnis"
ai_disclosure: "Recherche durchgeführt mit Claude (Anthropic). Redaktionelle Leitung und Fachwissen vom Autor."
license: "CC BY-NC 4.0"
---

Neuseeland, 1990. Die Regierung beauftragt die Beratungsfirma NERA mit dem Design einer Frequenzauktion. NERA empfiehlt die Vickrey-Auktion — ein Format, dessen theoretische Grundlagen sechs Jahre später den Nobelpreis erhalten werden. Erwartete Einnahmen: NZ$250 Millionen. Tatsächlich: NZ$36 Millionen. Ein Bieter bot NZ$100.000 und zahlte NZ$6. Ein anderer bot NZ$7 Millionen und zahlte NZ$5.000.

Eine falsche Wahl des Auktionsformats kostete die Staatskasse NZ$214 Millionen.

2019 änderte Google das Auktionsformat für den 48-Milliarden-Dollar-Markt der programmatischen Werbung. 2021 erzielte die FCC 81 Milliarden Dollar bei einer C-Band-Spektrumauktion — Weltrekord. Das EU-ETS hat seit 2013 über 245 Milliarden Euro durch die Versteigerung von Emissionsrechten generiert. In jedem Fall bestimmte nicht das Gut den Preis — **die Auktionsregeln bestimmten den Preis**.

<div style="margin: 2rem 0; padding: 1.5rem; border: 1px solid var(--border-color); border-radius: 8px; background: var(--bg-secondary);">

**[Interaktiven Explainer öffnen →](/research/auction-mechanics/infographic.html)**

9 Abschnitte: vier Auktionstypen · Gebotsmathematik · Erlösäquivalenz · das Neuseeland-Desaster · Vergleichstabellen · Evolution der Werbeauktionen · Auktionen im Finanzwesen · Auktionen in der IT · Trends und Zukunft.

</div>

## Vier grundlegende Auktionsformate

**Englische Auktion** (Christie's, Sotheby's) — der Preis steigt, der letzte Bieter gewinnt. **Holländische Auktion** (Aalsmeer-Blumenauktion, Googles IPO 2004, US-Staatsanleihen) — der Preis fällt, der erste Akzeptierende gewinnt. **Erstpreisauktion im verschlossenen Umschlag** — öffentliche Beschaffung, Ausschreibungen, programmatische Werbung seit 2019. **Zweitpreisauktion (Vickrey)** — Nobelpreis 1996, Grundlage des RTB 2007–2017, eBay-Mechanismus.

Vickreys zentrale Erkenntnis: Bei einer Zweitpreisauktion ist die dominante Strategie, exakt die eigene wahre Bewertung zu bieten. Bei Erstpreisauktionen — immer niedriger bieten (Bid Shading). Das Revenue-Equivalence-Theorem besagt, dass **im Erwartungswert** alle vier Formate den gleichen Verkäufererlös erzielen. Dies gilt jedoch nur unter strengen Bedingungen, die in der Praxis stets verletzt werden.

## Werbeauktionen: 100 Millisekunden und 500 Milliarden Dollar

Die Evolution der Werbeauktionen über 12 Jahre rekapitulierte den Weg, den die Auktionstheorie in 50 Jahren zurücklegte — von Vickrey (2007) über Header Bidding (Prebid.js, 2015) zu Erstpreisauktionen (2019).

## Jenseits der Werbung

Dieselben Mechanismen wirken im Cloud Computing (AWS Spot Instances — bis 90% Rabatt), an Börsen (kontinuierliche Doppelauktion — $120 Billionen/Jahr), auf Kohlenstoffmärkten (EU-ETS — 39 Mrd. €/Jahr), bei Ethereum (EIP-1559) und auf Energiemärkten (Merit Order auf EPEX SPOT).

## Eine Lektion

Regeln bestimmen Verhalten. Verhalten bestimmt den Preis. Wer die Regeln gestaltet, kontrolliert den Markt.

---

*Dieser Artikel wird erweitert. Kommende Abschnitte: VCG-Mechanismus, kombinatorische Auktionen, KI-Gebotsagenten.*
