📌 Project Overview

This project presents the design and functional verification of a **Clock Domain Crossing (CDC)**
circuit that safely transfers a single-cycle pulse from one clock domain to another.
CDC is a fundamental challenge in digital design — improper handling leads to
**metastability, pulse loss, and data corruption**.

---

🎯 Objective

- Understand and implement CDC concepts in digital design
- Design an RTL-level circuit for safe single-cycle pulse transfer
- Ensure output pulse is **exactly one cycle wide** with no loss or duplication
- Verify design using a comprehensive testbench with random pulse generation
- Synthesize the design and analyze area, power, timing, and gate reports

---

🏗️ Architecture

The design is built around three key functional blocks:

| Block | Domain | Function |
|-------|--------|----------|
| **Pulse Detector** | Source | Toggles on every incoming pulse to stretch it |
| **Two-FF Synchronizer** | CDC Bridge | Safely passes signal across clock boundary |
| **Pulse Generator** | Destination | XORs sync FFs to produce clean one-cycle pulse |

---

📁 File Structure
Xenith_Core/
│
├── xenith_design.v          # RTL Design File
├── xenith_testbench.v       # Testbench
├── design_area.rep          # Area Report
├── design_gates.rep         # Gate Level Report
├── design_netlist.v         # Synthesized Netlist
├── design_power.rep         # Power Report
├── design_timing.rep        # Timing Report
└── waves.shm/               # Waveform Data

---

⚙️ Design Details

### Clock Configuration
| Parameter | Value |
|-----------|-------|
| Source Clock Period | 10 ns |
| Destination Clock Period | 17 ns |
| Simulation Duration | 1000 ns |
| Random Pulses Generated | 20 |

### RTL Design Summary
- `toggle_src` — flips on every source pulse (pulse stretching)
- `sync_ff1`, `sync_ff2` — two-flop synchronizer in destination domain
- `dst_pulse` — generated via `sync_ff1 XOR sync_ff2`

---

🧪 Testbench Features

- Two independent asynchronous clocks (10ns & 17ns)
- Random pulse generation using `$urandom_range`
- Reset logic for both domains
- `$monitor` for real-time signal tracking
- Clean start/end simulation messages

---

📊 Synthesis Results (Cadence Genus)

### Area Report
| Instance | Cell Count | Total Area |
|----------|------------|------------|
| xenith_design | 7 | 80.988 µm² |

### Gate Level Breakdown
| Gate | Instances | Area |
|------|-----------|------|
| SDFFRHQX1 | 1 | 24.978 |
| DFFRHQX1 | 2 | 40.873 |
| CLKXOR2X1 | 1 | 8.326 |
| INVXL | 3 | 6.812 |

### Power Report
| Category | Total Power |
|----------|-------------|
| Register | 1.53975e-06 W (88.44%) |
| Logic | 2.01185e-07 W (11.56%) |
| **Total** | **~1.74 µW** |

### Timing Report
- Some paths are unconstrained — expected for asynchronous CDC design
- Traditional STA cannot analyze cross-domain paths
- Functional simulation used to ensure correctness

---

📈 Waveform Analysis

Simulation performed on **Cadence SimVision** over 1000ns:

- ✅ Both clocks running independently at different frequencies
- ✅ Random pulses generated at irregular intervals
- ✅ Clean `dst_pulse` for every `src_pulse` — no loss, no duplication
- ✅ Reset released correctly at the start of simulation

---

🔮 Future Scope

### 1. Pulse Pattern Prediction using ML
- Train LSTM model on pulse timing data
- Predict burst patterns for adaptive buffering
- Enable dynamic clock scaling for power optimization

### 2. CDC Failure Detection using ML
- Feed waveform data into a classification model
- Detect metastability, missing pulses, and glitches
- Applicable in silicon debug and EDA research

---

🛠️ Tools Used

| Tool | Purpose |
|------|---------|
| Cadence Xcelium | RTL Simulation |
| Cadence SimVision | Waveform Analysis |
| Cadence Genus | Logic Synthesis |

---

⭐ *If you found this project helpful, feel free to star the repository!*
