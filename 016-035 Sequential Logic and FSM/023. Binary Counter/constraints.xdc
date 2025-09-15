# Clock pin (Y9 - 100MHz PL clock)
set_property PACKAGE_PIN Y9 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.000 -name clk -waveform {0.000 5.000} [get_ports clk]

# Reset pin (BTNC button)
set_property PACKAGE_PIN P16 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

# Enable pin (SW0)
set_property PACKAGE_PIN F22 [get_ports enable]
set_property IOSTANDARD LVCMOS33 [get_ports enable]

# Binary count output on LEDs LD0-LD7
set_property PACKAGE_PIN T22 [get_ports {count_out[0]}]  
set_property PACKAGE_PIN T21 [get_ports {count_out[1]}]  
set_property PACKAGE_PIN U22 [get_ports {count_out[2]}]  
set_property PACKAGE_PIN U21 [get_ports {count_out[3]}]  
set_property PACKAGE_PIN V22 [get_ports {count_out[4]}]  
set_property PACKAGE_PIN W22 [get_ports {count_out[5]}]  
set_property PACKAGE_PIN U19 [get_ports {count_out[6]}]  
set_property PACKAGE_PIN U14 [get_ports {count_out[7]}]  
set_property IOSTANDARD LVCMOS33 [get_ports count_out*]

# Additional constraints
set_property SLEW SLOW [get_ports {count_out*}]
set_property DRIVE 8 [get_ports {count_out*}]
set_property PULLUP false [get_ports enable]
