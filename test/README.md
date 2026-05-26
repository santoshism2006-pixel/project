# Firmware Signature Verification Accelerator

This project implements a **Firmware Signature Verification Accelerator** for Tiny Tapeout.

The design verifies firmware authenticity using a simple hardware-based signature verification mechanism. It demonstrates how secure boot and firmware authentication concepts can be implemented in RTL hardware.

---

## Project Overview

The accelerator performs:

- Firmware data hashing
- Signature comparison
- Verification status generation
- Secure authentication logic

This project is inspired by automotive V2X security accelerator architectures and focuses on the **Firmware Signature Verification** block.

---

## Features

- Hardware-based firmware verification
- Clocked sequential logic
- Reset support
- Lightweight verification engine
- Tiny Tapeout compatible
- Synthesizable Verilog RTL

---

## Module Interface

| Signal | Width | Direction | Description |
|--------|--------|------------|-------------|
| `ui_in` | 8-bit | Input | Firmware data input |
| `uio_in` | 8-bit | Input | Signature data input |
| `uo_out` | 8-bit | Output | Verification result and hash output |
| `clk` | 1-bit | Input | System clock |
| `rst_n` | 1-bit | Input | Active-low reset |
| `ena` | 1-bit | Input | Enable signal |

---

## Verification Logic

The design contains:

1. Simple hash generation engine
2. Signature calculation logic
3. Hash-signature comparison unit
4. Verification status output

If the generated hash matches the signature pattern, verification output becomes HIGH.

---

## File Structure

```text
project/
│
├── src/
│   └── tt_um_firmware_signature_verify.v
│
├── test/
│   ├── tb.v
│   └── test.py
│
├── info.yaml
└── README.md
```

---

## Running Simulation

Run RTL simulation using:

```sh
make -B
```

Waveform file generated:

```text
tb.fst
```

View waveform using GTKWave:

```sh
gtkwave tb.fst
```

---

## Tiny Tapeout Compatibility

This project follows Tiny Tapeout wrapper requirements:

- 8 dedicated inputs
- 8 dedicated outputs
- 8 bidirectional IOs
- Single clock input
- Active-low reset

---

## Applications

- Secure boot systems
- Automotive V2X communication
- Firmware authentication
- Embedded system security
- IoT device protection

---

## Author

Your Name

---

## License

This project is licensed under the Apache 2.0 License.
