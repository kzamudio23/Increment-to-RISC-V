# Clock pin (Y9 on ZedBoard - 100MHz PL clock)
set_property PACKAGE_PIN Y9 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.000 -name clk -waveform {0.000 5.000} [get_ports clk]

# Reset pin (D19 on ZedBoard - BTNC button - active high)
set_property PACKAGE_PIN P16 [get_ports reset] 
set_property IOSTANDARD LVCMOS33 [get_ports reset]

# Enable pin (SW0 switch)
set_property PACKAGE_PIN T18 [get_ports enable]  
set_property IOSTANDARD LVCMOS33 [get_ports enable]

# Data input pins (using switches SW7-SW0) # I know that M15 is attatched to BTNL but I used a debug pin led to convey the clk for debug purposes
set_property PACKAGE_PIN M15 [get_ports {data_in[7]}]
set_property PACKAGE_PIN H17 [get_ports {data_in[6]}]
set_property PACKAGE_PIN H18 [get_ports {data_in[5]}]
set_property PACKAGE_PIN H19 [get_ports {data_in[4]}]
set_property PACKAGE_PIN F21 [get_ports {data_in[3]}]
set_property PACKAGE_PIN H22 [get_ports {data_in[2]}]
set_property PACKAGE_PIN G22 [get_ports {data_in[1]}]
set_property PACKAGE_PIN F22 [get_ports {data_in[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports data_in*]

# Data output pins (using LEDs LD7-LD0)
set_property PACKAGE_PIN N15 [get_ports {data_out[7]}] 
set_property PACKAGE_PIN U19 [get_ports {data_out[6]}] 
set_property PACKAGE_PIN W22 [get_ports {data_out[5]}] 
set_property PACKAGE_PIN V22 [get_ports {data_out[4]}] 
set_property PACKAGE_PIN U21 [get_ports {data_out[3]}] 
set_property PACKAGE_PIN U22 [get_ports {data_out[2]}] 
set_property PACKAGE_PIN T21 [get_ports {data_out[1]}] 
set_property PACKAGE_PIN T22 [get_ports {data_out[0]}] 
set_property IOSTANDARD LVCMOS33 [get_ports data_out*]

# Debug LED (use LD8 if available, or any unused LED)
set_property PACKAGE_PIN U14 [get_ports debug_led] 
set_property IOSTANDARD LVCMOS33 [get_ports debug_led]

# Additional constraints
set_property SLEW SLOW [get_ports {data_out*}]
set_property DRIVE 8 [get_ports {data_out*}]
set_property PULLUP false [get_ports {data_in*}]
