# Clock pin (Y9 - 100MHz PL clock)
set_property PACKAGE_PIN Y9 [get_ports clk_100mhz]
set_property IOSTANDARD LVCMOS33 [get_ports clk_100mhz]
create_clock -period 10.000 -name clk_100mhz -waveform {0.000 5.000} [get_ports clk_100mhz]

# Reset pin (BTNC button)
set_property PACKAGE_PIN P16 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

# Input button (Use BTNU for testing)
set_property PACKAGE_PIN T18 [get_ports button_in] 
set_property IOSTANDARD LVCMOS33 [get_ports button_in]

# Output signals
# R16 is a button but doesnt matter for this to work
set_property PACKAGE_PIN U19 [get_ports button_out]      
set_property PACKAGE_PIN U14 [get_ports button_posedge] 
set_property PACKAGE_PIN R16 [get_ports button_negedge]  
set_property IOSTANDARD LVCMOS33 [get_ports button_out]
set_property IOSTANDARD LVCMOS33 [get_ports button_posedge]
set_property IOSTANDARD LVCMOS33 [get_ports button_negedge]

# FSM state debug outputs
set_property PACKAGE_PIN T22 [get_ports {db_state[0]}] 
set_property PACKAGE_PIN T21 [get_ports {db_state[1]}] 
set_property PACKAGE_PIN U22 [get_ports {db_state[2]}]
set_property PACKAGE_PIN U21 [get_ports {db_state[3]}] 
set_property PACKAGE_PIN V22 [get_ports {db_state[4]}] 
set_property PACKAGE_PIN W22 [get_ports {db_state[5]}] 
set_property IOSTANDARD LVCMOS33 [get_ports db_state*]
