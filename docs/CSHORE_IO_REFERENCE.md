# CSHORE Input/Output Reference

This document catalogs CSHORE input and output.

## 1. Input Parameters (`infile`)

CSHORE is hardcoded to read a file named `infile` in the working directory.

### Logical Control Toggles (Integers)
| Parameter | Description |
| :--- | :--- |
| `ILINE` | Toggle for single vs. multiple line calculations. |
| `IPROFL` | Profile evolution (0 = Fixed, 1 = Mobile/Erosion). |
| `ISEDAV` | Sand availability (0 = Unlimited, 1 = Hard bottom). |
| `IPERM` | Permeability of the bed (0 = Impermeable, 1 = Permeable). |
| `IOVER` | Overtopping toggle (0 = No, 1 = Yes). |
| `IWTRAN` | Wave transmission due to overtopping. |
| `IPOND` | Ponding seaward of SWL. |
| `INFILT` | Infiltration landward of dune crest. |
| `IROLL` | Roller physics (0 = No, 1 = Yes). |
| `IWIND` | Wind effects. |
| `ITIDE` | Tidal effects on currents. |
| `IVEG` | Vegetation effects (0 = No, 1 = Yes). |

### Physical Constants (Floats)
| Parameter | Unit | Description |
| :--- | :--- | :--- |
| `DXC` | m | Constant grid spacing for numerical nodes. |
| `GAMMA` | - | Wave breaking parameter (H/h ratio). |
| `D50` | mm | Median sediment grain size. |
| `WF` | m/s | Sediment fall velocity. |
| `SG` | - | Specific gravity of sediment (typically 2.65). |
| `TEMP` | C | Water temperature. |
| `SALIN` | ppt | Salinity. |

### Boundary Conditions (Time-Series)
| Parameter | Unit | Description |
| :--- | :--- | :--- |
| `Time` | s | Elapsed time since simulation start. |
| `Tp` | s | Peak spectral wave period. |
| `Hrms` | m | Root-mean-square wave height. |
| `SWL` | m | Still water level elevation (Surge + Tide). |
| `Angle` | deg | Peak wave angle (shore-normal = 0). |

### Example `infile` Structure
```text
3
------------------------------------------------------------
Reach : Reach1  Profile : 10.0_010_150  Storm:  STM204
------------------------------------------------------------
1                                         ->ILINE
1.1                                       ->IPROFL
0                                         ->ISEDAV
... (Logic Toggles) ...
     2.0000                                ->DXC
     0.7000                                ->GAMMA
     0.3000     0.0448     2.6500         ->D50 WF SG
... (Wave & Surge Time Series) ...
695                                       ->NBINP
     0.0000    -9.2973     0.0150
     2.0000    -9.2891     0.0150
```

---

## 2. Output Parameters

CSHORE generates several text files prefixed with `O`.
This section focuses only on the key outputs.

### `ODOC` (Summary Data)
*   **Runup**: `R2P` (2% exceedance) and `R_mean` (mean).
*   **Transition Points**: Node numbers for `JDRY` (shoreline), `JSWL` (water
    intersection), and `JR` (breaking point).

**Example `ODOC` snippet:**
```text
 CSHORE USACE version, 2014 last edit 2022-03-22
 ------------------------------------------------------------
 Reach : Reach3  Profile : 09.9_013_120  Storm:  STM623
 ------------------------------------------------------------
COMPUTATION OPTION IPROFL =  1
Profile evolution is computed from Time = 0.0
to Time =      172800.0  for NTIME =   96
...
```

### `OBPROF` (Morphology Data)
*   **`Initial Profile`**: Bed elevation at $t=0$ (post-smoothing).
*   **`Final Profile`**: Bed elevation after the storm.
*   **`Min/Max Profile`**: The "envelope" of maximum scour and accretion.

**Example `OBPROF` snippet (per time step):**
```text
       1     693        0.0  (Step, Nodes, Time)
      0.000000000     -9.297300000  (x, zb)
      2.000000000     -9.289100000
      ...
```

### `OSETUP` (Hydrodynamic Data)
*   **`Setup`**: Wave-induced increase in mean water level.
*   **`Depth`**: Total water depth (Setup + Surge + Bathymetry).
*   **`Max Water Elev`**: Highest elevation reached by Surge + Setup.
*   **`Max Wave Ht`**: Largest wave height experienced at each node.

**Example `OSETUP` snippet (per time step):**
```text
       1     630     1800.0  (Step, Nodes, Time)
      0.000000000     -0.058700000      9.238600000      0.074670476
      2.000000000     -0.057599984      9.231500016      0.074668104
      ... (x, setup, depth, sigma)
```

## 3. Full Output File Catalog

While Beach-fx uses only **ODOC**, **OBPROF**, and **OSETUP**, the
following files are also produced for deeper physical analysis:

| File | Status | Description |
| :--- | :--- | :--- |
| **`ODOC`** | **Main** | Input echoes, run summaries, and final runup data. |
| **`OBPROF`**| **Main** | **Primary Erosion File**: Bed profile over time. |
| **`OSETUP`** | **Main** | Water level setup, depth, and wave heights. |
| `OENERG` | Detail | Wave energy and energy dissipation rates. |
| `OXMOME` | Detail | Cross-shore momentum flux and balance. |
| `OYMOME` | Detail | Alongshore momentum flux and balance. |
| `OXVELO` | Detail | Cross-shore current velocities (mean, max, min). |
| `OYVELO` | Detail | Alongshore current velocities. |
| `OSWASH` | Detail | Swash zone dynamics (runup, overtopping rates). |
| `OSWASE` | Detail | Swash zone sediment transport. |
| `OCROSS` | Detail | Cross-shore sediment transport rates (bed/suspended). |
| `OLONGS` | Detail | Alongshore sediment transport rates. |
| `OCRVOL` | Detail | Cumulative cross-shore sediment volume change. |
| `OLOVOL` | Detail | Cumulative alongshore sediment volume change. |
| `OBSUSL` | Detail | Suspended sediment load parameters. |
| `OPARAM` | Detail | Internal model parameters and coefficients used. |
| `OPORUS` | Detail | Permeability and pore pressure data (if `IPERM=1`). |
| `OROLLE` | Detail | Wave roller energy and flux (if `IROLL=1`). |
| `ODIKER` | Detail | Levee/Dike erosion data (if applicable). |
| `OMESSG` | Detail | Error messages and convergence logs. |
| `OTIMSE` | Detail | Time-series at specific user-defined nodes. |

