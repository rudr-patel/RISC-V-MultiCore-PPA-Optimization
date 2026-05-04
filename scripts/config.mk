# ==============================================================================
# Physical Design Configuration
# Design: soc_top | Platform: sky130hd
# ==============================================================================

# ------------------------------------------------------------------------------
# 1. Design Identity & Sources
# ------------------------------------------------------------------------------
export DESIGN_NAME        = soc_top
export PLATFORM           = sky130hd

# Automatically finds all .v files in the design directory
export VERILOG_FILES      = $(wildcard $(DESIGN_DIR)/*.v)
export SDC_FILE           = $(DESIGN_DIR)/constraints.sdc

# ------------------------------------------------------------------------------
# 2. Synthesis Strategy
# ------------------------------------------------------------------------------
# Ensure Yosys treats the whole design as logic for now
export SYNTH_STRATEGY     = DELAY 0
export SYNTH_CLOCK_GATING = 1

# ------------------------------------------------------------------------------
# 3. Floorplanning Constraints
# ------------------------------------------------------------------------------
# Define 0.25mm^2 die (600um x 600um)
export DIE_AREA           = 0 0 600 600
export CORE_AREA          = 10 10 590 590

# ------------------------------------------------------------------------------
# 4. Pin Placement & IO Layers
# ------------------------------------------------------------------------------
# Spread around four sides
export PLACE_PINS_ARGS    = -hor_layers met3 -ver_layers met2

# Specify exactly which metal layers to use for IO pins
export TIMING_PINS_LAYER  = met3
export IO_PCT_PINS_LAYER  = met2

# ------------------------------------------------------------------------------
# 5. Placement Parameters
# ------------------------------------------------------------------------------
# Enable logic optimization during placement to fix long paths
export PLACE_DENSITY      = 0.30
export DONT_USE_CELLS     = sky130_fd_sc_hd__lpflow*

# ------------------------------------------------------------------------------
# 6. Clock Tree Synthesis (CTS) & PPA Targets
# ------------------------------------------------------------------------------
export CLOCK_PERIOD       = 5.0

# Set skew and latency targets
export CLOCK_SKEW         = 0.05

# Specify the buffers to be used for the clock tree
export CTS_BUF_DISTANCE   = 100
export CTS_CLK_BUFFERS    = sky130_fd_sc_hd__clkbuf_1 sky130_fd_sc_hd__clkbuf_2 sky130_fd_sc_hd__clkbuf_4

# ------------------------------------------------------------------------------
# 7. Detailed Routing Configuration
# ------------------------------------------------------------------------------
# Use the TritonRoute engine for detailed routing
export ROUTING_CORES      = 4
export DRT_MIN_LAYER      = met1
export DRT_MAX_LAYER      = met5
