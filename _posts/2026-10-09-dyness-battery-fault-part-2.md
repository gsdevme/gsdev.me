---
title: "The battery that falls off a cliff, part 2: one weak cell per module"
date: 2026-10-09 10:30:00 +0100
categories: [Renewables, Batteries]
tags: [dyness, battery, can-bus, python, claude, solis]
description: >-
  An overnight CAN log of my Dyness B3 stack traced the sudden SOC drops to one weak cell in
  each of two modules, and the evidence is now with Dyness UK.
---

In [part 1](/posts/dyness-battery-fault-part-1/) a home-made USB-CAN cable got me per-cell data from the three Dyness B3 modules, and the first reading on 8 Oct showed the modules disagreeing about their own charge by about 29 points at the same cell voltage. The obvious next step was to watch a whole charge, cell by cell.

## Overnight

The stack is grid-charged to 100 % every night on a cheap tariff window, so that charge was the test. Claude Code wrote a logger for it. It opens the adapter in hardware listen-only mode, so nothing is ever sent on the battery's bus, and writes a raw log of every frame, a decoded CSV with one row per module per second, and an event log.

It ran on a Mac under `caffeinate`, so the Mac doesn't go to sleep. If no frame arrives for 30 seconds it reopens the bus, because the adapter has form for going quiet. An excerpt from `overnight_logger.py`, trimmed and simplified, so it doesn't run on its own:

```python
if not a.poll:
    _start = gs.GsUsb.start
    gs.GsUsb.start = lambda self, flags=0: _start(self, GS_CAN_MODE_LISTEN_ONLY | GS_CAN_MODE_HW_TIMESTAMP)

SILENCE_S = 30
while True:
    try:
        bus = d.open_gs_usb(0, 500000)
        last_rx = time.time()
        while True:
            now = time.time()
            msg = bus.recv(timeout=0.05)
            if msg is not None:
                t = time.time()
                latest[msg.arbitration_id] = (t, bytes(msg.data))
                last_rx = time.time()
            elif now - last_rx > SILENCE_S:
                raise RuntimeError(f"no frames for {SILENCE_S} s")
    except Exception as e:
        log(f"error: {type(e).__name__}: {e}; reconnecting in 5 s")
```

The cell frames kept streaming all night without a single poll.

The charge ran from 23:29 to 01:41 at about 63 A, with the modules starting at 42 %, 13 % and 12 %. Module 1 behaved: its cells rose together, its SOC (state of charge) climbed steadily, and it reached 100 % at 01:41.

Modules 2 and 3 didn't. In each, one cell pulled away from the rest: cell 8 in module 2, cell 9 in module 3. A module's BMS (battery management system) only corrects its SOC at the top when a cell reaches 3.50 V. At 00:59 module 2's cell 8 got there with the module at about 55 % (the chart's own labels say 53 %), and its SOC jumped to 100 % in 80 seconds. Module 3's cell 9 did the same at 01:11–01:13, at about 56–58 %. Between 01:31 and 01:41 both weak cells reached 3.55 V and tripped cell over-voltage protection while their neighbours sat at about 3.40 V.

![Highest, average and lowest cell voltage plus BMS SOC per module during the overnight charge: in modules 2 and 3 one cell climbs far above the rest, crosses the 3.50 V line at about 55 % SOC, the SOC jumps to 100 %, and cell 8 of module 2 and cell 9 of module 3 hit the 3.55 V over-voltage cut](/assets/dyness-charge-cells.png)

The charge counted into each module tells the rest: 42 Ah, 33 Ah and 34 Ah. Module 1 took the most despite reading 30 points fuller, so modules 2 and 3 were never near empty. The stack took about 5.6 kWh from a reported 22 %, so it was really about 48 % full.

## And on the way down

The same cell causes the evening drop. At the bottom, a module re-zeroes its SOC when a cell sags to 2.95 V. Working back from the module readings, on 8 Oct modules 2 and 3 each still had about 34 % counted when their weak cell hit that floor, and both snapped to 0 %. Module 1's cells didn't get there, so it stayed at about 28 %.

As part 1 showed, the inverter only gets the average of the three module SOCs, in frame `0x355`. Two modules going from 34 % to 0 % together turned 32 % into 9 % in one step, at only about 470 W. The size of the drop depends on which modules reset, which is why it looked as though it was getting worse.

<style>
.dy-root{--dy-ok:#2f9a68;--dy-bad:#c8443a;--dy-rule:rgba(127,127,127,.32);--dy-paper:rgba(127,127,127,.06);--dy-muted:rgba(0,0,0,.62);margin:1.25rem 0 1.5rem}
html[data-mode="dark"] .dy-root{--dy-ok:#4cc28a;--dy-bad:#f0776b;--dy-rule:rgba(160,160,160,.3);--dy-paper:rgba(255,255,255,.04);--dy-muted:rgba(255,255,255,.62)}
@media (prefers-color-scheme:dark){html:not([data-mode="light"]) .dy-root{--dy-ok:#4cc28a;--dy-bad:#f0776b;--dy-rule:rgba(160,160,160,.3);--dy-paper:rgba(255,255,255,.04);--dy-muted:rgba(255,255,255,.62)}}
.dy-modules{display:grid;grid-template-columns:repeat(3,minmax(0,1fr));gap:12px}
.dy-mod{background:var(--dy-paper);border:1px solid var(--dy-rule);border-radius:10px;padding:14px 16px;display:grid;gap:8px;align-content:start;min-width:0}
.dy-mod.dy-bad{border-color:var(--dy-bad)}
.dy-tag{font-size:.72rem;font-weight:600;letter-spacing:.06em;text-transform:uppercase;line-height:1}
.dy-ok .dy-tag{color:var(--dy-ok)}
.dy-bad .dy-tag{color:var(--dy-bad)}
.dy-name{font-weight:700;font-size:1.05rem;line-height:1.2}
.dy-mod dl{margin:0;display:grid;grid-template-columns:auto auto;gap:4px 12px;font-size:.88rem}
.dy-mod dt{color:var(--dy-muted);font-weight:400;margin:0}
.dy-mod dd{margin:0;text-align:right;font-variant-numeric:tabular-nums;white-space:nowrap}
.dy-note{color:var(--dy-muted);font-size:.85rem;margin:.6rem 0 0}
.dy-illus{display:grid;gap:12px;background:var(--dy-paper);border:1px solid var(--dy-rule);border-radius:10px;padding:18px}
.dy-step{font-weight:600;margin:0}
.dy-boxes{display:grid;grid-template-columns:repeat(3,minmax(0,1fr));gap:10px}
.dy-mbox{border:1px solid var(--dy-rule);border-radius:8px;padding:10px;display:grid;gap:6px;justify-items:center;min-width:0}
.dy-mbox strong{font-size:.85rem}
.dy-says{font-weight:600;font-size:.85rem;font-variant-numeric:tabular-nums}
.dy-mbox.dy-bad{border-color:var(--dy-bad)}
.dy-mbox.dy-bad .dy-says{color:var(--dy-bad)}
.dy-bars{display:flex;gap:2px;height:56px;align-items:flex-end;width:100%}
.dy-bars span{flex:1;height:100%;border-radius:1px;background:linear-gradient(to top,var(--dy-ok) calc(var(--lv)*100%),var(--dy-rule) 0)}
.dy-bars span.dy-w{background:linear-gradient(to top,var(--dy-bad) calc(var(--lv)*100%),var(--dy-rule) 0)}
@media (max-width:620px){.dy-modules{grid-template-columns:1fr}.dy-illus{padding:12px}.dy-boxes{gap:6px}.dy-mbox{padding:6px}.dy-bars{gap:1px}}
</style>
<div class="dy-root">
<div class="dy-illus" role="img" aria-label="How one cell empties a whole module. In the evening all three modules report about 30 %, but the weak cell in modules 2 and 3 is already much lower than its neighbours. When that weak cell runs out, modules 2 and 3 report 0 % while module 1 still reports 25 %, even though every module still holds energy.">
<p class="dy-step">Evening: every module thinks it has about 30 % left.</p>
<div class="dy-boxes"><div class="dy-mbox"><strong>Module 1</strong><span class="dy-says">30 %</span><div class="dy-bars" aria-hidden="true"><span style="--lv:0.3"></span><span style="--lv:0.3"></span><span style="--lv:0.3"></span><span style="--lv:0.3"></span><span style="--lv:0.3"></span><span style="--lv:0.3"></span><span style="--lv:0.3"></span><span style="--lv:0.3"></span><span style="--lv:0.3"></span><span style="--lv:0.3"></span><span style="--lv:0.3"></span><span style="--lv:0.3"></span><span style="--lv:0.3"></span><span style="--lv:0.3"></span><span style="--lv:0.3"></span></div></div><div class="dy-mbox"><strong>Module 2</strong><span class="dy-says">30 %</span><div class="dy-bars" aria-hidden="true"><span style="--lv:0.3"></span><span style="--lv:0.3"></span><span style="--lv:0.3"></span><span style="--lv:0.3"></span><span style="--lv:0.3"></span><span style="--lv:0.3"></span><span style="--lv:0.3"></span><span class="dy-w" style="--lv:0.12"></span><span style="--lv:0.3"></span><span style="--lv:0.3"></span><span style="--lv:0.3"></span><span style="--lv:0.3"></span><span style="--lv:0.3"></span><span style="--lv:0.3"></span><span style="--lv:0.3"></span></div></div><div class="dy-mbox"><strong>Module 3</strong><span class="dy-says">30 %</span><div class="dy-bars" aria-hidden="true"><span style="--lv:0.3"></span><span style="--lv:0.3"></span><span style="--lv:0.3"></span><span style="--lv:0.3"></span><span style="--lv:0.3"></span><span style="--lv:0.3"></span><span style="--lv:0.3"></span><span style="--lv:0.3"></span><span class="dy-w" style="--lv:0.14"></span><span style="--lv:0.3"></span><span style="--lv:0.3"></span><span style="--lv:0.3"></span><span style="--lv:0.3"></span><span style="--lv:0.3"></span><span style="--lv:0.3"></span></div></div></div>
<p class="dy-step">The weak cell runs out first, so its module reports 0 %.</p>
<div class="dy-boxes"><div class="dy-mbox"><strong>Module 1</strong><span class="dy-says">25 %</span><div class="dy-bars" aria-hidden="true"><span style="--lv:0.25"></span><span style="--lv:0.25"></span><span style="--lv:0.25"></span><span style="--lv:0.25"></span><span style="--lv:0.25"></span><span style="--lv:0.25"></span><span style="--lv:0.25"></span><span style="--lv:0.25"></span><span style="--lv:0.25"></span><span style="--lv:0.25"></span><span style="--lv:0.25"></span><span style="--lv:0.25"></span><span style="--lv:0.25"></span><span style="--lv:0.25"></span><span style="--lv:0.25"></span></div></div><div class="dy-mbox dy-bad"><strong>Module 2</strong><span class="dy-says">0 %</span><div class="dy-bars" aria-hidden="true"><span style="--lv:0.25"></span><span style="--lv:0.25"></span><span style="--lv:0.25"></span><span style="--lv:0.25"></span><span style="--lv:0.25"></span><span style="--lv:0.25"></span><span style="--lv:0.25"></span><span class="dy-w" style="--lv:0"></span><span style="--lv:0.25"></span><span style="--lv:0.25"></span><span style="--lv:0.25"></span><span style="--lv:0.25"></span><span style="--lv:0.25"></span><span style="--lv:0.25"></span><span style="--lv:0.25"></span></div></div><div class="dy-mbox dy-bad"><strong>Module 3</strong><span class="dy-says">0 %</span><div class="dy-bars" aria-hidden="true"><span style="--lv:0.25"></span><span style="--lv:0.25"></span><span style="--lv:0.25"></span><span style="--lv:0.25"></span><span style="--lv:0.25"></span><span style="--lv:0.25"></span><span style="--lv:0.25"></span><span style="--lv:0.25"></span><span class="dy-w" style="--lv:0"></span><span style="--lv:0.25"></span><span style="--lv:0.25"></span><span style="--lv:0.25"></span><span style="--lv:0.25"></span><span style="--lv:0.25"></span><span style="--lv:0.25"></span></div></div></div>
<p class="dy-note">The inverter sees the average of the three, so two modules hitting 0 % together drops the app from about 30 % to about 9 %, while every module still holds energy. The same happens at the top: the weak cell fills first and its module jumps to 100 %.</p>
</div>
</div>

![Colour-coded table of module snapshots from 8 October 21:01 to 9 October 03:30: SOC, current, lowest, average and highest cell and spread per module, with module 2 cell 8 and module 3 cell 9 lowest at rest and highest on charge](/assets/dyness-module-snapshots.png)

I also ran two step tests at about 62 A: a charge from near empty on 8 Oct and a discharge from a synced 100 % on 9 Oct. Each cell's voltage change 20–40 seconds in gives an apparent resistance. It includes polarisation, so it's for comparison only.

| Cell | Charge step (mΩ, vs module median) | Discharge step (mΩ, vs module median) |
| --- | --- | --- |
| Module 2, cell 8 | 4.59 (+66 %) | 4.78 (+102 %) |
| Module 3, cell 9 | 3.79 (+44 %) | 3.48 (+57 %) |
| Module 1, worst cell | no outlier above +28 % | cell 11, +35 % |

The weak cells are high in both directions and at both ends of the charge, and recovered to their usual offset within five minutes of the discharge step. Cell 6 read high in every module, both times, which points at the busbar or sense lead in the measurement path rather than a cell.

The cost is energy. From the BMS reporting 100 % to the drop, the stack gave 6.67 kWh on 5 Oct and 6.95 kWh on 8 Oct, against about 8.6 kWh for 80 % of 10.8 kWh. Modules 2 and 3 work over roughly 55–65 % of their rated 75 Ah each cycle.

## What the BMS can't tell you

Put side by side, the three modules look like this:

<div class="dy-root">
<div class="dy-modules">
<div class="dy-mod dy-ok"><span class="dy-tag">Healthy</span><span class="dy-name">Module 1</span><dl><dt>Worst cell resistance</dt><dd>+35 %</dd><dt>Charge taken overnight</dt><dd>42 Ah</dd><dt>BMS health (SOH)</dt><dd>97 %</dd></dl></div>
<div class="dy-mod dy-bad"><span class="dy-tag">Weak cell 8</span><span class="dy-name">Module 2</span><dl><dt>Cell 8 resistance</dt><dd>+66 % / +102 %</dd><dt>Charge taken overnight</dt><dd>33 Ah</dd><dt>BMS health (SOH)</dt><dd>97 %</dd></dl></div>
<div class="dy-mod dy-bad"><span class="dy-tag">Weak cell 9</span><span class="dy-name">Module 3</span><dl><dt>Cell 9 resistance</dt><dd>+44 % / +57 %</dd><dt>Charge taken overnight</dt><dd>34 Ah</dd><dt>BMS health (SOH)</dt><dd>97 %</dd></dl></div>
</div>
<p class="dy-note">Resistance is against the median cell in the same module, on charge / discharge (module 1's worst is on discharge).</p>
</div>

The BMS reports 97 % SOH (state of health) for all three modules. By its own account nothing is wrong.

Nor will it fix itself. Balancing only starts when cells are above 3.30 V and at least 30 mV apart, and on the flat middle of an LFP (lithium iron phosphate) curve that gap rarely shows up. Worse, during a charge module 2 balances by bleeding its highest cell, which is now the weak cell 8, leaving it lower still at the bottom of the next discharge. The charge-current limit is a lookup on estimated SOC, not on cell voltage: 37.5 A per module (a third of the stack figures in part 1), 30 A from 81 %, 15 A from 91 %, 0 A at 100 %. Once a module has decided it is full, nothing on the inverter side can push more in.

That is why none of the earlier fixes from part 1 could work. User-Define mode with 54 V equalise still stopped when the BMS said 100 %, charge currents from 25 to 64 A ended at the same point, and holding at 100 % for hours just sat at 0 A. The problem isn't where the charge stops; it's one cell in each of two modules.

> If you have a Dyness stack doing this: listen on the spare link port at the end of the chain rather than unplugging anything, and read every cell before believing the percentage. Don't write BMS parameters. The same bus carries the parameter-write frames, and changing them without Dyness involved risks the battery and the warranty.
{: .prompt-tip }

Claude's part in this half was the analysis: Claude Code wrote the scripts, the charts above and the findings write-up from the overnight capture. It also got things wrong that the data corrected. In the claude.ai chat it said balancing needed about 3.4 V; the parameter values say 3.30 V with a 30 mV gap. After the video of the alarm lights it suspected a loose power connection, which the even current split ruled out. And its summary after the 8 Oct reading blamed SOC counters drifting while the cells were broadly healthy. The overnight charge overturned that: the stack resyncs to 100 % every night, so drift between charges can't be the cause.

## Over to Dyness

On 9 Oct I sent Dyness UK the evidence above and asked for a warranty assessment of modules 2 and 3. This isn't a job for a screwdriver and a multimeter on my side.

A few things are still open on my side:

- **Which box is which.** Module numbers are CAN addresses. The red ALM (alarm) LEDs on 8 Oct were on the middle and bottom boxes, which fits, but I still need to match each DIP address and serial number to a physical box.
- **Firmware.** Each module's BMS firmware version isn't in the CAN frames, but Dyness can read them, and [modules in a stack should run the same version](https://solar-tech-support.co.uk/fault-codes/dyness/).
- **Capacity.** A slow discharge from a synced 100 % should show whether the weak cells have also lost capacity, or only gained resistance.

Against the explanations I started with: one weak cell per module and the modules disagreeing about SOC are confirmed, the high resistance is confirmed, whether those cells have also lost capacity is still open, and a bad power connection is unlikely. No reply from Dyness yet.

## What's next

- Wait for Dyness, and finish the slow-discharge test in the meantime
- Publish per-cell data to Home Assistant over MQTT, so a cell running away shows up on a dashboard and not in an overnight CSV
- Keep the overnight logger running
