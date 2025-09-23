## Clock Constraints (100MHz PL clock)
set_property PACKAGE_PIN Y9 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.000 -name sys_clk -waveform {0.000 5.000} [get_ports clk]

## Reset Button (BTNC - Center PL Button)
set_property PACKAGE_PIN P16 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

## Input Switches (All 8 DIP switches)
set_property PACKAGE_PIN F22 [get_ports {sw[0]}]   
set_property PACKAGE_PIN G22 [get_ports {sw[1]}]   
set_property PACKAGE_PIN H22 [get_ports {sw[2]}]   
set_property PACKAGE_PIN F21 [get_ports {sw[3]}]   
set_property PACKAGE_PIN H19 [get_ports {sw[4]}]   
set_property PACKAGE_PIN H18 [get_ports {sw[5]}]   
set_property PACKAGE_PIN H17 [get_ports {sw[6]}]   
set_property PACKAGE_PIN M15 [get_ports {sw[7]}]   
set_property IOSTANDARD LVCMOS33 [get_ports {sw[*]}]

## Output LEDs (All 8 User LEDs)
set_property PACKAGE_PIN T22 [get_ports {leds[0]}]   
set_property PACKAGE_PIN T21 [get_ports {leds[1]}]   
set_property PACKAGE_PIN U22 [get_ports {leds[2]}]   
set_property PACKAGE_PIN U21 [get_ports {leds[3]}]   
set_property PACKAGE_PIN V22 [get_ports {leds[4]}]   
set_property PACKAGE_PIN W22 [get_ports {leds[5]}]   
set_property PACKAGE_PIN U19 [get_ports {leds[6]}]   
set_property PACKAGE_PIN U14 [get_ports {leds[7]}]   
set_property IOSTANDARD LVCMOS33 [get_ports {leds[*]}]

## Timing Constraints
set_input_delay -clock [get_clocks sys_clk] 2 [get_ports {sw[*] reset}]
set_output_delay -clock [get_clocks sys_clk] 2 [get_ports {leds[*]}]

## Additional Constraints
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_IBUF]
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
