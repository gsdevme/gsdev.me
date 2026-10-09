---
title: "Four and a half years of solar: what it cost, what it saved"
date: 2026-10-07 13:00:00 +0100
categories: [Renewables, Solar]
tags: [solar, battery, octopus, renewables, home-assistant]
description: >-
  A look back at four and a half years of panels and batteries: what the roof generated,
  what the bills did once two EVs arrived, and a rough payback range.
---

It has been four and a half years since [the install post](/posts/solar-install/) and [the batteries post](/posts/batteries-arrive/), so it seems a fair time to add it all up.

## What it cost

The original quote was £8,700 for twelve panels, the Solis inverter and 2 × Pylontech batteries. The Pylontech units were out of stock, the batteries became 3 × Dyness B3, and the final bill was roughly £10,000 in 2022. I haven't spent anything on the system since: no servicing, no repairs, no replacement parts. Every number below is measured against that £10,000.

## What the roof made

The twelve panels have generated roughly 22,000 kWh so far, according to Solis Cloud.

| Year | Generation | Note |
| --- | --- | --- |
| 2022 | 3,650 kWh | April to December; panels up late April, batteries from the end of June |
| 2023 | 4,800 kWh | First full year |
| 2024 | 4,410 kWh | |
| 2025 | 4,980 kWh | Best year so far |
| 2026 | 4,260 kWh | To early October |

<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 360" width="100%" role="img" font-family="system-ui, -apple-system, 'Segoe UI', sans-serif" style="max-width: 640px; display: block; margin: 1rem auto;">
  <title>Solar generation by year (kWh)</title>
  <desc>Bar chart of yearly solar generation from a 4 kW array: 2022 (April to December) 3,650 kWh; 2023 4,800; 2024 4,410; 2025 4,980; 2026 to early October 4,260.</desc>
  <style>
    .sg-ink { fill: currentColor; }
    .sg-ink2 { fill: currentColor; opacity: 0.7; }
    .sg-grid { stroke: currentColor; opacity: 0.15; }
    .sg-base { stroke: currentColor; opacity: 0.4; }
    .sg-bar { fill: #2a78d6; }
    .sg-tick { font-variant-numeric: tabular-nums; }
  </style>
  <text class="sg-ink" x="16" y="28" font-size="16" font-weight="600">Solar generation by year (kWh)</text>
  <text class="sg-ink2" x="16" y="50" font-size="13">* 2022 is April to December; 2026 is to early October.</text>
  <g stroke-width="1" fill="none" shape-rendering="crispEdges">
    <line class="sg-grid" x1="56" x2="624" y1="233.83" y2="233.83"/>
    <line class="sg-grid" x1="56" x2="624" y1="157.17" y2="157.17"/>
    <line class="sg-grid" x1="56" x2="624" y1="80.50" y2="80.50"/>
  </g>
  <g class="sg-ink2 sg-tick" font-size="12" text-anchor="end">
    <text x="48" y="314">0</text>
    <text x="48" y="237.83">2,000</text>
    <text x="48" y="161.17">4,000</text>
    <text x="48" y="84.50">6,000</text>
  </g>
  <g class="sg-ink" font-size="12" text-anchor="middle">
    <g>
      <title>2022: 3,650 kWh (April to December)</title>
      <path class="sg-bar" d="M88.80 310V174.08A4 4 0 0 1 92.80 170.08H132.80A4 4 0 0 1 136.80 174.08V310Z"/>
      <text x="112.80" y="165.08">3,650</text>
    </g>
    <g>
      <title>2023: 4,800 kWh</title>
      <path class="sg-bar" d="M202.40 310V130.00A4 4 0 0 1 206.40 126.00H246.40A4 4 0 0 1 250.40 130.00V310Z"/>
      <text x="226.40" y="121.00">4,800</text>
    </g>
    <g>
      <title>2024: 4,410 kWh</title>
      <path class="sg-bar" d="M316.00 310V144.95A4 4 0 0 1 320.00 140.95H360.00A4 4 0 0 1 364.00 144.95V310Z"/>
      <text x="340.00" y="135.95">4,410</text>
    </g>
    <g>
      <title>2025: 4,980 kWh</title>
      <path class="sg-bar" d="M429.60 310V123.10A4 4 0 0 1 433.60 119.10H473.60A4 4 0 0 1 477.60 123.10V310Z"/>
      <text x="453.60" y="114.10">4,980</text>
    </g>
    <g>
      <title>2026: 4,260 kWh (to early October)</title>
      <path class="sg-bar" d="M543.20 310V150.70A4 4 0 0 1 547.20 146.70H587.20A4 4 0 0 1 591.20 150.70V310Z"/>
      <text x="567.20" y="141.70">4,260</text>
    </g>
  </g>
  <line class="sg-base" x1="56" x2="624" y1="310.5" y2="310.5" stroke-width="1" shape-rendering="crispEdges"/>
  <g class="sg-ink2" font-size="13" text-anchor="middle">
    <text x="112.80" y="332">2022*</text>
    <text x="226.40" y="332">2023</text>
    <text x="340.00" y="332">2024</text>
    <text x="453.60" y="332">2025</text>
    <text x="567.20" y="332">2026*</text>
  </g>
</svg>

The yearly totals move around by a few hundred kWh. I have no way of telling how much of that is weather and how much is anything else.

## What the bills did

I have moved around the Octopus tariffs more than most people would bother to. The short version: a single rate for the first summer, Tracker for the first winter, then a run of time-of-use tariffs with a cheap overnight window for charging the battery. The rates below are as they appear on the statements, before 5% VAT.

| Period | Import tariff | Export tariff |
| --- | --- | --- |
| June to August 2022 | Flexible Octopus, 26.51p | None |
| August 2022 to January 2023 | Octopus Tracker, 17p to 52p, changing daily | None |
| January to April 2023 | Octopus Go, 38.22p day, 7.14p overnight | None |
| April to September 2023 | Octopus Flux, roughly 28–31p standard, 17–19p overnight | Flux Export, from 28 April |
| September 2023 to March 2024 | Octopus Go, 28.54p day, 8.57p overnight | Fixed Lite, 8p |
| March to May 2024 | Octopus Flux, roughly 23–27p standard, 14–16p overnight | Flux Export |
| May 2024 to September 2026 | Intelligent Octopus Go, 21.87p to 27.61p day, 6.67p overnight (briefly 4.95p in spring 2026) | Outgoing, 15p; 12p from 1 March 2026 |
| From 29 September 2026 | Intelligent Octopus Go 12M Loyal Fixed, 35.07p day, 6.60p overnight | Outgoing Octopus, 12p |

Then the cars arrived. A Nissan Leaf in January 2024 and a Tesla Model Y in June 2024. Grid import, which had been under 2,000 kWh in 2023, roughly tripled. Most of that extra is presumably the cars charging overnight, at the off-peak rate. So the headline import figure says more about the driveway than about the house.

Export has been paid since April 2023, when I first switched to Flux. Before that, about 1,250 kWh went out in 2022 and roughly another 250 kWh in early 2023, and earned nothing.

| Year | Grid import | Export | Export paid |
| --- | --- | --- | --- |
| 2022 | n/a | 1,250 kWh | £0, no export tariff |
| 2023 | 1,870 kWh | 1,430 kWh | £360 |
| 2024 | 4,330 kWh | 1,900 kWh | £290 |
| 2025 | 5,950 kWh | 2,710 kWh | £410 |
| 2026 to early October | 4,600 kWh | 2,310 kWh | £280 |

Import here is from the inverter, which turns out to be more reliable than the statements. The statements sometimes bill catch-up usage outside their own dates, which shifts several hundred kWh between neighbouring years. 2023 export is the paid figure from the statements.

Taking the EVs out is guesswork, because they aren't metered separately. As a rough estimate, the house's own share of the 2025 import bill was about £350 of the £670 total, with the rest going on the cars.

## What it saved

The savings come from three places:

- **Self-consumption**: solar used in the house (or stored in the battery) instead of bought, valued at the day rate I was paying at the time.
- **Export**: what Octopus actually paid.
- **Battery arbitrage**: charging the battery overnight at the cheap rate and using it in the day instead of peak-rate electricity. This can't be measured from monthly figures, so it is a range.

| Year | Self-consumption | Export | Battery arbitrage | Total | Cumulative |
| --- | --- | --- | --- | --- | --- |
| 2022 (April to December) | £710 | £0 | £0, single-rate tariffs | £710 | £710 |
| 2023 | £1,060 | £360 | £120–£510 | £1,420–£1,920 | £2,130–£2,630 |
| 2024 | £670 | £290 | £150–£460 | £960–£1,420 | £3,090–£4,050 |
| 2025 | £630 | £410 | £150–£530 | £1,030–£1,570 | £4,120–£5,620 |
| 2026 to early October | £580 | £280 | £70–£410 | £860–£1,270 | £4,980–£6,890 |

The low end of each total leaves the battery arbitrage out entirely, to stay on the cautious side. The high end adds the top of the arbitrage range.

So after four and a half years, the system has paid back somewhere between roughly £5,000 and £6,900 of the £10,000.

For payback I've taken 2025 as a typical year, at 2026 prices. Without any arbitrage that is about £990 a year, and with the top of the arbitrage range about £1,580 a year. That puts payback at roughly 6½ to 10 years from install, somewhere between late 2028 and 2032. The range is wide almost entirely because of the battery. I know how much came out of it, but not how much of what went in was cheap overnight grid rather than solar. Half-hourly data would narrow that down. Monthly totals can't.

If nothing changes, which it will, the picture looks like this. Taking the 2026 run rate forward, the cautious line (self-consumption and export only, about £990 a year) crosses the £10k mark during 2031. The optimistic line, which adds the upper bound for the battery's overnight arbitrage (about £1,580 a year), gets there during 2028. Real life will land somewhere between: rates will move, the panels will age a little, and the battery has been less than reliable lately.

<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 360" width="100%" role="img" font-family="system-ui, -apple-system, 'Segoe UI', sans-serif" style="max-width: 640px; display: block; margin: 1rem auto;">
  <title>Cumulative savings against the £10k outlay</title>
  <desc>Line chart of cumulative savings from 2022 to 2032. Two estimates: without battery arbitrage (low) and with its upper bound (high). Solid lines are actuals to 2026; dashed lines project the 2026 run rate. The high estimate crosses £10,000 during 2028 and the low estimate during 2031.</desc>
  <style>
    .sg-ink { fill: currentColor; }
    .sg-ink2 { fill: currentColor; opacity: 0.7; }
    .sg-grid { stroke: currentColor; opacity: 0.15; }
    .sg-base { stroke: currentColor; opacity: 0.4; }
    .sg-ref { stroke: currentColor; opacity: 0.5; }
    .sg-tick { font-variant-numeric: tabular-nums; }
    .sg-lo { stroke: #2a78d6; } .sg-lo-dot { fill: #2a78d6; }
    .sg-hi { stroke: #b8600f; } .sg-hi-dot { fill: #b8600f; }
    html[data-mode="dark"] .sg-lo, html[data-mode="dark"] .sg-lo-dot { stroke: #3987e5; fill: #3987e5; }
    html[data-mode="dark"] .sg-hi, html[data-mode="dark"] .sg-hi-dot { stroke: #e8964a; fill: #e8964a; }
    html[data-mode="dark"] path.sg-lo, html[data-mode="dark"] path.sg-hi, html[data-mode="dark"] polyline.sg-lo, html[data-mode="dark"] polyline.sg-hi { fill: none; }
    @media (prefers-color-scheme: dark) {
      html:not([data-mode="light"]) .sg-lo, html:not([data-mode="light"]) .sg-lo-dot { stroke: #3987e5; fill: #3987e5; }
      html:not([data-mode="light"]) .sg-hi, html:not([data-mode="light"]) .sg-hi-dot { stroke: #e8964a; fill: #e8964a; }
      html:not([data-mode="light"]) polyline.sg-lo, html:not([data-mode="light"]) polyline.sg-hi { fill: none; }
    }
  </style>
  <text class="sg-ink" x="16" y="28" font-size="16" font-weight="600">Cumulative savings against the £10k outlay</text>
  <text class="sg-ink2" x="16" y="50" font-size="13">Solid: to date. Dashed: projected at the 2026 run rate, nothing else changing.</text>
  <g stroke-width="1" fill="none" shape-rendering="crispEdges">
    <line class="sg-grid" x1="56" x2="624" y1="233.8" y2="233.8"/>
    <line class="sg-grid" x1="56" x2="624" y1="157.2" y2="157.2"/>
    <line class="sg-grid" x1="56" x2="624" y1="80.5" y2="80.5"/>
    <line class="sg-ref" x1="56" x2="624" y1="118.8" y2="118.8" stroke-dasharray="2 3"/>
  </g>
  <text class="sg-ink2" x="624" y="113.3" font-size="12" text-anchor="end">£10,000 outlay</text>
  <g class="sg-ink2 sg-tick" font-size="12" text-anchor="end">
    <text x="48" y="314">£0</text>
    <text x="48" y="237.8">£4k</text>
    <text x="48" y="161.2">£8k</text>
    <text x="48" y="84.5">£12k</text>
  </g>
  <g fill="none" stroke-width="2" stroke-linejoin="round" stroke-linecap="round">
    <polyline class="sg-hi" points="56.0,296.4 112.8,259.6 169.6,232.4 226.4,202.3 283.2,172.0"/>
    <polyline class="sg-hi" stroke-dasharray="5 4" points="283.2,172.0 340.0,141.7 396.8,111.4 453.6,81.2 510.4,50.9 567.2,20.6 624.0,-9.7"/>
    <polyline class="sg-lo" points="56.0,296.4 112.8,269.2 169.6,250.8 226.4,231.0 283.2,212.1"/>
    <polyline class="sg-lo" stroke-dasharray="5 4" points="283.2,212.1 340.0,193.1 396.8,174.1 453.6,155.1 510.4,136.2 567.2,117.2 624.0,98.2"/>
  </g>
  <g>
    <g><title>2022: £710 high estimate</title><circle class="sg-hi-dot" cx="56.0" cy="296.4" r="4"/></g>
    <g><title>2022: £710 low estimate</title><circle class="sg-lo-dot" cx="56.0" cy="296.4" r="4"/></g>
    <g><title>2023: £2,630 high estimate</title><circle class="sg-hi-dot" cx="112.8" cy="259.6" r="4"/></g>
    <g><title>2023: £2,130 low estimate</title><circle class="sg-lo-dot" cx="112.8" cy="269.2" r="4"/></g>
    <g><title>2024: £4,050 high estimate</title><circle class="sg-hi-dot" cx="169.6" cy="232.4" r="4"/></g>
    <g><title>2024: £3,090 low estimate</title><circle class="sg-lo-dot" cx="169.6" cy="250.8" r="4"/></g>
    <g><title>2025: £5,620 high estimate</title><circle class="sg-hi-dot" cx="226.4" cy="202.3" r="4"/></g>
    <g><title>2025: £4,120 low estimate</title><circle class="sg-lo-dot" cx="226.4" cy="231.0" r="4"/></g>
    <g><title>2026: £7,200 high estimate</title><circle class="sg-hi-dot" cx="283.2" cy="172.0" r="4"/></g>
    <g><title>2026: £5,110 low estimate</title><circle class="sg-lo-dot" cx="283.2" cy="212.1" r="4"/></g>
    <g><title>2027: £8,780 high estimate (projected)</title><circle class="sg-hi-dot" cx="340.0" cy="141.7" r="4"/></g>
    <g><title>2027: £6,100 low estimate (projected)</title><circle class="sg-lo-dot" cx="340.0" cy="193.1" r="4"/></g>
    <g><title>2028: £10,360 high estimate (projected)</title><circle class="sg-hi-dot" cx="396.8" cy="111.4" r="4"/></g>
    <g><title>2028: £7,090 low estimate (projected)</title><circle class="sg-lo-dot" cx="396.8" cy="174.1" r="4"/></g>
    <g><title>2029: £11,940 high estimate (projected)</title><circle class="sg-hi-dot" cx="453.6" cy="81.2" r="4"/></g>
    <g><title>2029: £8,080 low estimate (projected)</title><circle class="sg-lo-dot" cx="453.6" cy="155.1" r="4"/></g>
    <g><title>2030: £13,520 high estimate (projected)</title><circle class="sg-hi-dot" cx="510.4" cy="50.9" r="4"/></g>
    <g><title>2030: £9,070 low estimate (projected)</title><circle class="sg-lo-dot" cx="510.4" cy="136.2" r="4"/></g>
    <g><title>2031: £15,100 high estimate (projected)</title><circle class="sg-hi-dot" cx="567.2" cy="20.6" r="4"/></g>
    <g><title>2031: £10,060 low estimate (projected)</title><circle class="sg-lo-dot" cx="567.2" cy="117.2" r="4"/></g>
    <g><title>2032: £16,680 high estimate (projected)</title><circle class="sg-hi-dot" cx="624.0" cy="-9.7" r="4"/></g>
    <g><title>2032: £11,050 low estimate (projected)</title><circle class="sg-lo-dot" cx="624.0" cy="98.2" r="4"/></g>
  </g>
  <text class="sg-ink" x="618.0" y="-17.7" font-size="12" text-anchor="end">High: paid back in 2028</text>
  <text class="sg-ink" x="618.0" y="114.2" font-size="12" text-anchor="end">Low: paid back in 2031</text>
  <line class="sg-base" x1="56" x2="624" y1="310.5" y2="310.5" stroke-width="1" shape-rendering="crispEdges"/>
  <g class="sg-ink2" font-size="12" text-anchor="middle">
    <text x="56.0" y="332">2022</text>
    <text x="169.6" y="332">2024</text>
    <text x="283.2" y="332">2026</text>
    <text x="396.8" y="332">2028</text>
    <text x="510.4" y="332">2030</text>
    <text x="624.0" y="332">2032</text>
  </g>
  <g font-size="12">
    <line class="sg-hi" x1="56" x2="78" y1="352" y2="352" stroke-width="2"/><text class="sg-ink2" x="84" y="356">With battery arbitrage (upper bound)</text>
    <line class="sg-lo" x1="326" x2="348" y1="352" y2="352" stroke-width="2"/><text class="sg-ink2" x="354" y="356">Self-consumption and export only</text>
  </g>
</svg>

> **Assumptions**
>
> - All pounds include 5% VAT. The statements quote rates without it.
> - Self-consumption is valued at the daytime rate of whichever tariff I was on. On Flux that is the standard rate, not the 4pm to 7pm peak.
> - Self-consumption means everything generated and not exported, including what went through the battery and the losses on the way.
> - Battery arbitrage is a bounded guess, not a measurement. The top assumes every kWh out of the battery was bought overnight and replaced peak-rate electricity. The bottom counts only charge that can't have come from solar.
> - The EV share is estimated as import above the 2023 level, priced at the overnight rate. That baseline is already low, because solar and the battery were cutting import in 2023.
> - Statements sometimes bill usage outside their stated dates, so import moves between neighbouring years. Export is unaffected.
> - Everything is worked from monthly inverter totals and the statements, not half-hourly data. Some readings were supplier estimates (autumn 2022, January 2023, export in summer 2025).
> - Generation before the Octopus account started in June 2022 is valued at the 26.51p standard rate. 2022 and early 2023 use the single rate of the day, since there was no overnight rate yet.
> - One-off credits (referrals, free-electricity sessions, community energy) and public EV charging are left out.
> - Figures are rounded to the nearest £10, so rows may not sum exactly.
> - The £400 Energy Bills Support Scheme credit, gas and standing charges are left out. Standing charges are paid regardless.
> - No allowance for panel or battery degradation, maintenance, inflation or the time value of money.
{: .prompt-info }

## A side note on the cars

This isn't a solar saving, so it stays out of the table above, but it is the other half of the bill story. The two cars do roughly 9,000 to 12,000 miles a year between them, and almost all of their charging happens overnight on the cheap rate. Very occasionally they charge during the day for convenience, or during one of Octopus's free-electricity sessions.

Ballpark, with the assumptions stated:

- Petrol at about £1.70 a litre ([September 2026 average](https://www.confused.com/petrol-prices)) in a typical 40 mpg hatchback is roughly 19p a mile.
- The EVs at about 7p per kWh overnight and 3.5 miles per kWh are roughly 2p a mile.
- Over 9,000 to 12,000 miles that is about £1,700 to £2,300 of petrol against £180 to £240 of electricity, so roughly £1,500 to £2,000 a year.

That's a bigger number than anything the panels have done, and it's really a tariff benefit rather than a solar one. But the overnight rate is the same one the battery charges on, and the whole arrangement only made sense once the house was set up to shift its use to the cheap hours.

## What I'd do differently

Nothing here is new; it's all come up earlier in the series.

- Get an export tariff set up from day one. Roughly 1,500 kWh went out for nothing before I sorted it.
- Ask for trunking on the quote, rather than adding it afterwards.
- Ask about tile notching where the roof hooks pass between the tiles, before the panels go up rather than after.
- Get the inverter talking to Home Assistant sooner. It took until January 2023 for the first script, and until this year for something I'd trust to run unattended.

## What's next

- A full year on the Loyal Fixed tariff. At a 35.07p day rate, solar used in the house is worth more, which should pull both ends of the payback range in a little.
- The battery has started dropping charge in sudden steps over the last month, which is the next post.
