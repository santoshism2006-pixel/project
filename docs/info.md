<!--

This file is used to generate your project datasheet.

-->

## How it works

The Firmware Signature Verification Accelerator is a hardware security module designed for verifying firmware authenticity in embedded systems and automotive V2X applications.

The design accepts firmware data through the dedicated input pins (`ui_in`) and signature data through the bidirectional input pins (`uio_in`).

Internally, the module performs:

1. Firmware hash generation
2. Signature calculation
3. Hash and signature comparison
4. Verification status generation

A simple hash engine continuously updates the firmware hash value on every clock cycle. The incoming signature data is processed and compared with the generated hash.

If both values match, the verification status output becomes HIGH, indicating valid firmware authentication.

The output pins (`uo_out`) provide:

- Verification status
- Partial hash output values

The design is fully synchronous and operates using the system clock (`clk`) and active-low reset (`rst_n`).

This project demonstrates the basic principles of secure firmware verification hardware accelerators used in secure boot systems, automotive electronics, and embedded cybersecurity platforms.

---

## How to test

Run RTL simulation using:

```sh
make -B
```

Simulation generates the waveform file:

```text
tb.fst
```

Open waveform using GTKWave:

```sh
gtkwave tb.fst
```

Testbench operations include:

- Reset testing
- Firmware data injection
- Signature input testing
- Verification result monitoring
- Clocked sequential verification

Example test inputs:

| Firmware Input | Signature Input | Expected Result |
|----------------|-----------------|-----------------|
| 0x12           | 0x12            | Verification HIGH |
| 0x34           | 0x56            | Verification LOW |
| 0xAA           | 0xAA            | Verification HIGH |

---

## External hardware

No external hardware is required.

The project is fully implemented in Verilog RTL and designed for Tiny Tapeout integration.
