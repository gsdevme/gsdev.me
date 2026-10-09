---
title: The battery that falls off a cliff, part 1
date: 2026-10-08 22:00:00 +0100
categories: [Renewables, Batteries]
tags: [dyness, battery, can-bus, python, claude, home-assistant, solis]
description: >-
  My Dyness battery stack keeps dropping 20-odd points of charge in one go. A month of
  theories, an expired vendor tool, a £20 USB-CAN cable, and the first look at every cell.
---

The rebuild in [the inverter manager post](/posts/solis-inverter-manager/) put the battery's own BMS (battery management system) figures into Home Assistant. That is where this story got its evidence.

## The symptom

For a while, since some time before September, the SOC (state of charge) graph in Home Assistant had the odd jump in it. I put it down to flakiness and moved on.

On 7 September it stopped looking like flakiness: the graph slopes down gently, then drops in a vertical line from 28 % to 19 %. A week later the manager started publishing the BMS's own voltage and current limits, and the drops turned from an annoyance into evidence. On 26 September it went 33 % to 18 %. Tonight, 8 October, it went 32 % to 9 %. That's 9, then 15, then 23 points, and getting worse.

The kit, as a reminder: three Dyness B3 modules, each 48 V and 75 Ah, 15 LFP (lithium iron phosphate) cells in series, 10.8 kWh in total, on a Solis hybrid inverter.

## First theories and dead ends

There were three candidate explanations: a weak cell, the SOC counter drifting, or the stack never reaching a true 100 % and so never correcting itself.

The inverter can export its history to Excel, so I started there. Every charge ended with the pack at about 50.6–50.8 V, roughly 3.37 V a cell, with the BMS saying 100 %. It then settled at about 50.0 V. The B3 manual gives 53 V as the absorption voltage. On 8 September a steady 36 A charge from 20 % went up in a straight line to 76 %, then jumped 77 → 85 % and 86 → 99 %. The pack took 133 Ah; the straight part of the line implied about 168 Ah for 20 → 100 %.

Then the dead ends:

- **User-Define mode.** The inverter has a battery type that lets you set your own voltages. I set 54 V equalise and 52.5 V float. It still stopped at the same point, because while the battery is talking to the inverter, the BMS decides.
- **Unplug the comms.** That just raises a "CAN fail" alarm on the inverter.
- **Different charge currents.** Anything from 25 A to 64 A, same cut-off.

The Home Assistant data from 5 October explained why. The BMS charge-current limit steps down on its *estimated* SOC, not on cell voltage: 112.5 A, then 90, 45, 30, 15 and finally 0 A at "100 %". That day, the stack gave 6.67 kWh between reading 100 % and cutting off. 80 % of 10.8 kWh is about 8.6 kWh.

### Where Claude came in

I'd had Claude in the loop on claude.ai since 7 September. It was useful for working through the numbers, and it was also wrong several times:

- It said a B3 was 2.4 kWh, then that it was 16S. It's 3.6 kWh and 15S. I caught the capacity myself.
- It suggested holding the battery at 100 % for hours to let it balance. The data showed the BMS sets the charge current to 0 A at 100 %, so the hold did nothing.
- It suggested the drops came from heavy load, around 3.6 kW. Later drops happened at about half a kilowatt.

## Dyness Monitor, expired

Dyness have a Windows tool, Dyness Monitor, that shows per-module and per-cell data. I found an old build via a forum post. On opening it says:

> Software expired, please contact the manufacturer

That build has an expiry date built into it. I didn't try to modify it or get round it; the right move is to ask Dyness for a current build.

What came bundled with it was still useful. The documentation showed the tool talks to the battery over **CAN, not RS485**. I had already bought an RS485 cable, which Claude had also expected to work. It is now a cable. The parameter file gave the thresholds that matter:

| Threshold | Value | Effect |
| --- | --- | --- |
| SOC resets to 100 % | 3.50 V per cell | The only point the estimate is corrected at the top |
| SOC resets low | 2.95 V per cell | A sagging cell snaps the estimate down |
| Balancing starts | above 3.30 V, cells ≥ 30 mV apart | Rarely true in the flat middle of the LFP curve |

That explains the charge stopping at about 3.37 V a cell: nothing ever pushes a cell to 3.50 V, so nothing ever corrects the estimate. It doesn't yet explain the cliff.

## A cable and a script

The hardware is a DSD TECH SH-C31A, a CANable 2.0 clone with candleLight firmware, for about £20, plus an Ethernet patch lead with one end cut off. CAN on the battery's RJ45 port is on pins 4 and 5.

| Battery RJ45 pin | Wire (T568A and B) | Adapter terminal |
| --- | --- | --- |
| 4 | Solid blue | CAN_H |
| 5 | Blue/white | CAN_L |
| 1–3, 6–8 | — | Not connected, taped off |

The adapter's 120 Ω termination switch stays off; the bus is already terminated. The batteries are daisy-chained master → slave → slave, and the OUT port on the last slave is free. I plugged in there, so the inverter's link to the master is untouched and the inverter's own frames are visible on the same bus.

> If you'd rather tap the master's IN port with an RJ45 "splitter", check it wires all 8 pins in parallel. Most cheap Ethernet splitters only wire 1, 2, 3 and 6, which leaves out CAN entirely.
{: .prompt-warning }

The frames I needed, for module `m` (1–3), all big-endian:

| Frame ID | Direction | Content |
| --- | --- | --- |
| `0x18F21m77` | to module | Poll; `data[0] = 1` turns on the cell stream |
| `0x18F21m11`–`14` | from module | Cell voltages, 4 × u16 mV each (slot 16 reads 0) |
| `0x18F21m15` | from module | Temperatures, `(raw − 400) / 10` °C |
| `0x18F21m21` | from module | Pack V `/100`; current `(raw − 4000) / 10` A (negative = charging); average cell mV; max discharge A `/10` |
| `0x18F21m22` | from module | Max and min cell mV with their cell numbers (0-based); max charge A `/10` |
| `0x18F21m23` | from module | SOH in byte 6, SOC in byte 7 |
| `0x18F21m24` | from module | Protection, alarm, MOSFET and balancing flags |

I gave Claude the protocol notes and asked for a python-can reader. Claude Code then turned that into a repo, a private one. Real hardware found the gaps, in this order:

1. **macOS wanted root.** libusb reports a kernel driver as active on the adapter even though none is bound, so the `gs_usb` package tries to detach it and gets "Access denied". The fix skips that check on macOS.
2. **Cell numbers were off by one.** The min/max cell numbers in `0x22` are 0-based; the cell frames count from 1.
3. **The adapter went deaf.** After any session where it transmitted, it stopped receiving anything until I unplugged it, even in later listen-only sessions. So the logger now defaults to listen-only.
4. **The cell stream doesn't stop.** Cell frames only start after a poll, but once polled they kept coming with no further polls, which is what makes an unattended listen-only log possible.

An excerpt from the decoder in `dyness_cells.py`, trimmed (it needs the rest of the class to run):

```python
def be16(d, i):
    return (d[i] << 8) | d[i + 1]


class Module:
    def decode(self, f, d):
        if 0x11 <= f <= 0x14:
            k = (f - 0x11) * 4
            for j in range(4):
                self.cells[k + j] = be16(d, j * 2)
        elif f == 0x15:
            self.temps = [(be16(d, j * 2) - 400) / 10 for j in range(4)]
        elif f == 0x21:
            self.v = be16(d, 0) / 100
            self.i = (be16(d, 2) - 4000) / 10
            self.avg = be16(d, 4)
            self.max_dis = be16(d, 6) / 10
        elif f == 0x22:
            self.maxc, self.maxno = be16(d, 0), d[2] + 1
            self.minc, self.minno = be16(d, 3), d[5] + 1
        elif f == 0x23:
            self.soh, self.soc = d[6], d[7]
```

## 8 October

At 19:31 the SOC went from 32 % to 9 % in one step, with the house drawing about 0.5 kW. The inverter switched straight to grid charging.

I took a video of the stack. Two of the three modules, the middle and bottom ones, had their ALM (alarm) light flashing red. The top one didn't.

The support number Dyness list turned out not to be on WhatsApp, but I did get through to their support on WhatsApp in the end.

Then, at about 21:00, with the grid charge running at about 13 A, the first live cell data:

| | Module 1 | Module 2 | Module 3 |
| --- | --- | --- | --- |
| Module SOC (%) | 38 | 9 | 9 |
| Average cell (mV) | 3319 | 3310 | 3319 |
| Charge current (A) | 4.9 | 4.2 | 4.0 |
| Max discharge allowed (A) | 37.5 | 0 | 0 |
| Cycles | 1035 | 998 | 972 |

The three module averages were within 10 mV of each other, at about 3.32 V a cell. The current was shared roughly evenly, which rules out a bad power connection on one module. Yet the three modules disagree about how full they are by nearly 30 points, and two of them refuse to discharge at all until they think they're back above 16 %.

The inverter never sees any of that. The SOC it gets is frame `0x355`, which is the average of the three module estimates: 18 % at that moment. So when two modules decide at once that they are empty, the average falls off a cliff, and the whole stack's discharge limit drops to module 1's 37.5 A.

> The modules are in parallel, so they really are at the same voltage. A module reading 38 % next to two reading 9 % isn't fuller; it just has a different opinion.
{: .prompt-info }

## What's next

Why modules 2 and 3 reset and module 1 doesn't is the open question. A listen-only logger is running against the stack tonight through the overnight charge, writing every frame to disk.

What that overnight log showed is in [part 2](/posts/dyness-battery-fault-part-2/).
