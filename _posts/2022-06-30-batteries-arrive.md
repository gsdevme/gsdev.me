---
title: The batteries finally arrive
date: 2022-06-30 13:00:00 +0100
categories: [Renewables, Batteries]
tags: [solar, battery, dyness, solis, renewables]
description: >-
  The Dyness batteries finally turn up two months after the panels, and a look at
  what the system did on its own before they arrived.
---

This picks up where [the install post](/posts/solar-install/) left off: panels on the roof, batteries on back-order.

## The wait

The system ran panels-only for about two months. Whatever the roof generated went into the house, and what the house didn't use went to the grid for nothing. The evenings still ran on the grid.

There isn't much to say about the wait itself. I didn't chase anyone. Once the Dyness stock arrived, Solar Services Scotland got in touch and came back to fit them.

## The kit

This is the swap from the 2 × Pylontech on the original quote:

- 3 × Dyness B3 modules
- 48 V / 75 Ah each, about 3.6 kWh per module
- 10.8 kWh in total
- Lithium iron phosphate (LFP) chemistry
- Stacked in the garage, next to the inverter
- Talks to the Solis inverter over CAN bus (a two-wire data link between the two)

## Fitting day

The fitting took a morning. The three modules were stacked and wired in, the system was commissioned, and the installers were gone by lunch.

![Three Dyness B3 modules in a rack below the Solis inverter on the garage wall](/assets/dyness-battery-stack.jpeg)

Two things I have learned since the panels went up. First, I wish I had asked for trunking up front. It is an easy thing to specify on the quote and a fiddlier job to add afterwards. Second, the tiles: where the roof hooks (the brackets that hold the mounting rails) pass between the tiles, the tiles should be notched to make room for them. I'm not sure whether that was done here. Two months on there's no visible issue, so it's on the list of things to keep an eye on rather than the list of things to worry about.

## Two months of panels-only

Before the batteries, the Solarman app was already logging generation. The monthly figures to the end of June:

| Month | Generation | Note |
| --- | --- | --- |
| April 2022 | 95 kWh | Part month, panels went up late April |
| May 2022 | 638 kWh | First full month |
| June 2022 | 704 kWh | Best month yet |

Even without storage, daytime grid import fell to almost nothing on sunny days. Evenings and nights still came from the grid.

<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 360" width="100%" role="img" font-family="system-ui, -apple-system, 'Segoe UI', sans-serif" style="max-width: 640px; display: block; margin: 1rem auto;">
  <title>Solar generation, 2022 (kWh)</title>
  <desc>Bar chart of monthly solar generation from a 4 kW array: April 2022, 95 kWh (part month, installed late April); May 2022, 638 kWh; June 2022, 704 kWh.</desc>
  <style>
    .sg-ink { fill: currentColor; }
    .sg-ink2 { fill: currentColor; opacity: 0.7; }
    .sg-grid { stroke: currentColor; opacity: 0.15; }
    .sg-base { stroke: currentColor; opacity: 0.4; }
    .sg-bar { fill: #2a78d6; }
    .sg-tick { font-variant-numeric: tabular-nums; }
  </style>
  <text class="sg-ink" x="16" y="28" font-size="16" font-weight="600">Solar generation, 2022 (kWh)</text>
  <text class="sg-ink2" x="16" y="50" font-size="13">April is a part month (installed late April).</text>
  <g stroke-width="1" fill="none" shape-rendering="crispEdges">
    <line class="sg-grid" x1="56" x2="624" y1="233.5" y2="233.5"/>
    <line class="sg-grid" x1="56" x2="624" y1="156.5" y2="156.5"/>
    <line class="sg-grid" x1="56" x2="624" y1="80.5" y2="80.5"/>
  </g>
  <g class="sg-ink2 sg-tick" font-size="12" text-anchor="end">
    <text x="48" y="314">0</text>
    <text x="48" y="237.5">250</text>
    <text x="48" y="160.5">500</text>
    <text x="48" y="84.5">750</text>
  </g>
  <g class="sg-ink" font-size="12" text-anchor="middle">
    <g>
      <title>April 2022: 95 kWh (part month)</title>
      <path class="sg-bar" d="M126.67 310V284.87A4 4 0 0 1 130.67 280.87H170.67A4 4 0 0 1 174.67 284.87V310Z"/>
      <text x="150.67" y="275">95</text>
    </g>
    <g>
      <title>May 2022: 638 kWh</title>
      <path class="sg-bar" d="M316.00 310V118.35A4 4 0 0 1 320.00 114.35H360.00A4 4 0 0 1 364.00 118.35V310Z"/>
      <text x="340" y="108.5">638</text>
    </g>
    <g>
      <title>June 2022: 704 kWh</title>
      <path class="sg-bar" d="M505.33 310V98.11A4 4 0 0 1 509.33 94.11H549.33A4 4 0 0 1 553.33 98.11V310Z"/>
      <text x="529.33" y="89">704</text>
    </g>
  </g>
  <line class="sg-base" x1="56" x2="624" y1="310.5" y2="310.5" stroke-width="1" shape-rendering="crispEdges"/>
  <g class="sg-ink2" font-size="13" text-anchor="middle">
    <text x="150.67" y="332">Apr</text>
    <text x="340" y="332">May</text>
    <text x="529.33" y="332">Jun</text>
  </g>
</svg>

## First impressions with storage

The difference is in the evenings. The battery soaks up the daytime surplus and the house runs off it after the sun goes down. On a sunny day, grid import now drops to almost nothing.

I have also started checking the Solarman app far more often than is healthy. Watching the battery percentage climb through the afternoon is surprisingly absorbing.

The obvious next thought is winter. The panels will produce far less, and the battery will have little surplus to store. But if the battery can be charged from the grid overnight, a cheaper night-rate tariff might make the maths work in winter too. That is an idea to look into, not a decision.

## What's next

- See how autumn goes as generation drops off
- Look into night-rate tariffs and whether grid charging the battery stacks up
- See whether the Solarman app is enough, or whether I want something more detailed
