# Clock pin (100MHz PL clock)
set_property PACKAGE_PIN Y9 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.000 -name clk -waveform {0.000 5.000} [get_ports clk]

# Reset pin (BTNC button)
set_property PACKAGE_PIN P16 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

# Traffic Light Outputs by state of the system
set_property PACKAGE_PIN T22 [get_ports red]
set_property IOSTANDARD LVCMOS33 [get_ports red]

set_property PACKAGE_PIN T21 [get_ports yellow]
set_property IOSTANDARD LVCMOS33 [get_ports yellow]

set_property PACKAGE_PIN U22 [get_ports green]
set_property IOSTANDARD LVCMOS33 [get_ports green]

# State Debug Output by binary bus
set_property PACKAGE_PIN U21 [get_ports {state_debug[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {state_debug[0]}]

set_property PACKAGE_PIN V22 [get_ports {state_debug[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {state_debug[1]}]

set_property PACKAGE_PIN W22 [get_ports {state_debug[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {state_debug[2]}]
