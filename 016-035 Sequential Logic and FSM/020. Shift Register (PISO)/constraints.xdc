# Clock pin (Y9 on ZedBoard - 100MHz PL clock) - Bank 13
set_property PACKAGE_PIN Y9 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.000 -name clk -waveform {0.000 5.000} [get_ports clk]

# Reset pin (BTNC button) - Bank 13
set_property PACKAGE_PIN P16 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

# Control pins - Bank 13
set_property PACKAGE_PIN F22 [get_ports load]       
set_property PACKAGE_PIN G22 [get_ports shift_en]   
set_property IOSTANDARD LVCMOS33 [get_ports load]
set_property IOSTANDARD LVCMOS33 [get_ports shift_en]

# Parallel input (SW7-SW0) - Bank 13
set_property PACKAGE_PIN M15 [get_ports {parallel_in[7]}]  
set_property PACKAGE_PIN H17 [get_ports {parallel_in[6]}]  
set_property PACKAGE_PIN H18 [get_ports {parallel_in[5]}]  
set_property PACKAGE_PIN H19 [get_ports {parallel_in[4]}]  
set_property PACKAGE_PIN F21 [get_ports {parallel_in[3]}]  
set_property PACKAGE_PIN H22 [get_ports {parallel_in[2]}]  
set_property PACKAGE_PIN R18 [get_ports {parallel_in[1]}]  
set_property PACKAGE_PIN T18 [get_ports {parallel_in[0]}]  
set_property IOSTANDARD LVCMOS33 [get_ports parallel_in*]

# Serial output - Bank 13
set_property PACKAGE_PIN U14 [get_ports serial_out] 
set_property IOSTANDARD LVCMOS33 [get_ports serial_out]

# Internal state display on LEDs - Bank 13
set_property PACKAGE_PIN T22 [get_ports {reg_state[0]}]  
set_property PACKAGE_PIN T21 [get_ports {reg_state[1]}]  
set_property PACKAGE_PIN U22 [get_ports {reg_state[2]}]  
set_property PACKAGE_PIN U21 [get_ports {reg_state[3]}]  
set_property PACKAGE_PIN V22 [get_ports {reg_state[4]}]  
set_property PACKAGE_PIN W22 [get_ports {reg_state[5]}]  
set_property PACKAGE_PIN U19 [get_ports {reg_state[6]}]  
set_property PACKAGE_PIN R16 [get_ports {reg_state[7]}] 
set_property IOSTANDARD LVCMOS33 [get_ports reg_state*]

# Additional constraints
set_property SLEW SLOW [get_ports serial_out]
set_property DRIVE 8 [get_ports serial_out]
set_property PULLUP false [get_ports {load shift_en parallel_in*}]
