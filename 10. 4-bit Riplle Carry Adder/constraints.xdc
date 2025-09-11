## Inputs: A[3:0] from SW0-SW3
set_property PACKAGE_PIN F22 [get_ports {A[0]}]  ; # SW0
set_property IOSTANDARD LVCMOS33 [get_ports {A[0]}]

set_property PACKAGE_PIN G22 [get_ports {A[1]}]  ; # SW1
set_property IOSTANDARD LVCMOS33 [get_ports {A[1]}]

set_property PACKAGE_PIN H22 [get_ports {A[2]}]  ; # SW2
set_property IOSTANDARD LVCMOS33 [get_ports {A[2]}]

set_property PACKAGE_PIN F21 [get_ports {A[3]}]  ; # SW3
set_property IOSTANDARD LVCMOS33 [get_ports {A[3]}]

## Inputs: B[3:0] from SW4-SW7
set_property PACKAGE_PIN H19 [get_ports {B[0]}]  ; # SW4
set_property IOSTANDARD LVCMOS33 [get_ports {B[0]}]

set_property PACKAGE_PIN H18 [get_ports {B[1]}]  ; # SW5
set_property IOSTANDARD LVCMOS33 [get_ports {B[1]}]

set_property PACKAGE_PIN H17 [get_ports {B[2]}]  ; # SW6
set_property IOSTANDARD LVCMOS33 [get_ports {B[2]}]

set_property PACKAGE_PIN M15 [get_ports {B[3]}]  ; # SW7
set_property IOSTANDARD LVCMOS33 [get_ports {B[3]}]

## Input: Cin from BTNU
set_property PACKAGE_PIN T18 [get_ports {Cin}]   ; # BTNU
set_property IOSTANDARD LVCMOS33 [get_ports {Cin}]

## Outputs: S[3:0] to LD0-LD3
set_property PACKAGE_PIN T22 [get_ports {S[0]}]  ; # LD0
set_property IOSTANDARD LVCMOS33 [get_ports {S[0]}]

set_property PACKAGE_PIN T21 [get_ports {S[1]}]  ; # LD1
set_property IOSTANDARD LVCMOS33 [get_ports {S[1]}]

set_property PACKAGE_PIN U22 [get_ports {S[2]}]  ; # LD2
set_property IOSTANDARD LVCMOS33 [get_ports {S[2]}]

set_property PACKAGE_PIN U21 [get_ports {S[3]}]  ; # LD3
set_property IOSTANDARD LVCMOS33 [get_ports {S[3]}]

## Output: Cout to LD4
set_property PACKAGE_PIN V22 [get_ports {Cout}]  ; # LD4
set_property IOSTANDARD LVCMOS33 [get_ports {Cout}]
