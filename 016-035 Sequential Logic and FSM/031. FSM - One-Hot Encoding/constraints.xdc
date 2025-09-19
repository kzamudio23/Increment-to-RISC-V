## Clock Constraint
set_property PACKAGE_PIN Y9 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.000 -name clk -waveform {0.000 5.000} [get_ports clk]

## Reset Button BTNC
set_property PACKAGE_PIN P16 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

## Input Switches
set_property PACKAGE_PIN F22 [get_ports input_a]    
set_property IOSTANDARD LVCMOS33 [get_ports input_a]

set_property PACKAGE_PIN G22 [get_ports input_b]   
set_property IOSTANDARD LVCMOS33 [get_ports input_b]

set_property PACKAGE_PIN H22 [get_ports input_c]  
set_property IOSTANDARD LVCMOS33 [get_ports input_c]

## Output LEDs (LEDs 1 - 3)
set_property PACKAGE_PIN T22 [get_ports output_x] 
set_property IOSTANDARD LVCMOS33 [get_ports output_x]

set_property PACKAGE_PIN T21 [get_ports output_y]  
set_property IOSTANDARD LVCMOS33 [get_ports output_y]

set_property PACKAGE_PIN U22 [get_ports output_z] 
set_property IOSTANDARD LVCMOS33 [get_ports output_z]

## State Debug Output (LEDs 4 - 7)
set_property PACKAGE_PIN U21 [get_ports {state_debug[0]}]  
set_property IOSTANDARD LVCMOS33 [get_ports {state_debug[0]}]

set_property PACKAGE_PIN V22 [get_ports {state_debug[1]}]  
set_property IOSTANDARD LVCMOS33 [get_ports {state_debug[1]}]

set_property PACKAGE_PIN W22 [get_ports {state_debug[2]}]  
set_property IOSTANDARD LVCMOS33 [get_ports {state_debug[2]}]

set_property PACKAGE_PIN U19 [get_ports {state_debug[3]}] 
set_property IOSTANDARD LVCMOS33 [get_ports {state_debug[3]}]

## Timing Constraints
set_input_delay -clock [get_clocks sys_clk] 2 [get_ports {reset}]
set_input_delay -clock [get_clocks sys_clk] 2 [get_ports {input_c}]
set_input_delay -clock [get_clocks sys_clk] 2 [get_ports {input_b}]
set_input_delay -clock [get_clocks sys_clk] 2 [get_ports {input_a}]

set_output_delay -clock [get_clocks sys_clk] 2 [get_ports {output_x}]
set_output_delay -clock [get_clocks sys_clk] 2 [get_ports {output_y}]
set_output_delay -clock [get_clocks sys_clk] 2 [get_ports {output_z}]
set_output_delay -clock [get_clocks sys_clk] 2 [get_ports {state_debug[*]}]



## False Paths for asynchronous inputs
set_false_path -from [get_ports reset]

## Additional Constraints
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_IBUF]
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
