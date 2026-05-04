# ==============================================================================
# Synopsys Design Constraints (SDC)
# Design: soc_top
# ==============================================================================

# ------------------------------------------------------------------------------
# Design Selection
# ------------------------------------------------------------------------------
current_design soc_top
          
# ------------------------------------------------------------------------------
# Clock Definitions
# ------------------------------------------------------------------------------
# Define the primary clock network: 5ns period = 200MHz   
create_clock [get_ports clk] -name clk -period 5
          
# ------------------------------------------------------------------------------
# Input / Output Delays
# ------------------------------------------------------------------------------
# Add baseline input/output delays to make the timing realistic
set_input_delay  -clock clk 2 [all_inputs]
set_output_delay -clock clk 2 [all_outputs]
