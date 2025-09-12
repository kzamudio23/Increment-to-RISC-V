# Inputs: DIP Switches SW0-SW7 → I(0) to I(7)
set_property PACKAGE_PIN F22 [get_ports {I[0]}]  ; # SW0
set_property PACKAGE_PIN G22 [get_ports {I[1]}]  ; # SW1
set_property PACKAGE_PIN H22 [get_ports {I[2]}]  ; # SW2
set_property PACKAGE_PIN F21 [get_ports {I[3]}]  ; # SW3
set_property PACKAGE_PIN H19 [get_ports {I[4]}]  ; # SW4
set_property PACKAGE_PIN H18 [get_ports {I[5]}]  ; # SW5
set_property PACKAGE_PIN H17 [get_ports {I[6]}]  ; # SW6
set_property PACKAGE_PIN M15 [get_ports {I[7]}]  ; # SW7

# Outputs: LEDs LD0-LD2 → Y(0) to Y(2)
set_property PACKAGE_PIN T22 [get_ports {Y[0]}]  ; # LD0
set_property PACKAGE_PIN T21 [get_ports {Y[1]}]  ; # LD1
set_property PACKAGE_PIN U22 [get_ports {Y[2]}]  ; # LD2

# I/O Standard
set_property IOSTANDARD LVCMOS33 [get_ports {I[0] I[1] I[2] I[3] I[4] I[5] I[6] I[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Y[0] Y[1] Y[2]}]
