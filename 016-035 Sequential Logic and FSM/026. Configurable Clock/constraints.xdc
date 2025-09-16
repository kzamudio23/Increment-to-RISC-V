# Clock pin (Y9 - 100MHz PL clock)
set_property PACKAGE_PIN Y9 [get_ports clk_100mhz]
set_property IOSTANDARD LVCMOS33 [get_ports clk_100mhz]
create_clock -period 10.000 -name clk_100mhz -waveform {0.000 5.000} [get_ports clk_100mhz]

# Reset pin (BTNC button)
set_property PACKAGE_PIN P16 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

# Division ratio selection (SW2-SW0)
set_property PACKAGE_PIN H22 [get_ports {div_ratio[2]}]  
set_property PACKAGE_PIN G22 [get_ports {div_ratio[1]}]  
set_property PACKAGE_PIN F22 [get_ports {div_ratio[0]}]  
set_property IOSTANDARD LVCMOS33 [get_ports div_ratio*]

# Output signals
set_property PACKAGE_PIN U19 [get_ports clk_enable]  
set_property PACKAGE_PIN U14 [get_ports clk_slow]    
set_property IOSTANDARD LVCMOS33 [get_ports clk_enable]
set_property IOSTANDARD LVCMOS33 [get_ports clk_slow]

# Divider value display (lower 8 bits)
set_property PACKAGE_PIN T22 [get_ports {div_value[0]}]  
set_property PACKAGE_PIN T21 [get_ports {div_value[1]}]  
set_property PACKAGE_PIN U22 [get_ports {div_value[2]}]  
set_property PACKAGE_PIN U21 [get_ports {div_value[3]}]  
set_property PACKAGE_PIN V22 [get_ports {div_value[4]}]  
set_property PACKAGE_PIN W22 [get_ports {div_value[5]}]  
#set_property PACKAGE_PIN U19 [get_ports {div_value[6]}]  
#set_property PACKAGE_PIN U14 [get_ports {div_value[7]}] 
set_property IOSTANDARD LVCMOS33 [get_ports div_value*]
# Literally no change from the last one lol
