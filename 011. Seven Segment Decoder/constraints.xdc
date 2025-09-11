# Input: DIP Switches
set_property PACKAGE_PIN F22 [get_ports {inp[0]}]  ; # SW0
set_property PACKAGE_PIN G22 [get_ports {inp[1]}]  ; # SW1
set_property PACKAGE_PIN H22 [get_ports {inp[2]}]  ; # SW2
set_property PACKAGE_PIN F21 [get_ports {inp[3]}]  ; # SW3

# Output: LEDs 
set_property PACKAGE_PIN T22 [get_ports {seg[0]}]  ; # LD0
set_property PACKAGE_PIN T21 [get_ports {seg[1]}]  ; # LD1
set_property PACKAGE_PIN U22 [get_ports {seg[2]}]  ; # LD2
set_property PACKAGE_PIN U21 [get_ports {seg[3]}]  ; # LD3
set_property PACKAGE_PIN V22 [get_ports {seg[4]}]  ; # LD4
set_property PACKAGE_PIN W22 [get_ports {seg[5]}]  ; # LD5
set_property PACKAGE_PIN U19 [get_ports {seg[6]}]  ; # LD6

# I/O Standard
set_property IOSTANDARD LVCMOS33 [get_ports {inp[0] inp[1] inp[2] inp[3]}] #This is quick, I will use this format
set_property IOSTANDARD LVCMOS33 [get_ports {seg[0] seg[1] seg[2] seg[3] seg[4] seg[5] seg[6]}]
