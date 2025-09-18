# Clock pin (Y9 - 100MHz PL clock)
set_property PACKAGE_PIN Y9 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.000 -name clk -waveform {0.000 5.000} [get_ports clk]

# Reset pin (BTNC button)
#set_property PACKAGE_PIN P16 [get_ports reset]
#set_property IOSTANDARD LVCMOS33 [get_ports reset]

# Input button (Switches shown)
set_property PACKAGE_PIN F22 [get_ports enable] 
set_property IOSTANDARD LVCMOS33 [get_ports enable]

set_property PACKAGE_PIN G22 [get_ports clr] 
set_property IOSTANDARD LVCMOS33 [get_ports clr]

# FSM state debug output (LED)
set_property PACKAGE_PIN T22 [get_ports {Z1}]
set_property IOSTANDARD LVCMOS33 [get_ports Z1]
