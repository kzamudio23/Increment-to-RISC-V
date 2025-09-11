# Lazy so I copied from https://github.com/Digilent/digilent-xdc/blob/master/Zedboard-Master.xdc a

# "SW0" Data Input 
set_property PACKAGE_PIN F22 [get_ports {D[0]}];  
set_property IOSTANDARD LVCMOS33 [get_ports {D[0]}]

# "SW1"
set_property PACKAGE_PIN G22 [get_ports {D[1]}];  
set_property IOSTANDARD LVCMOS33 [get_ports {D[1]}]

# "SW2"
set_property PACKAGE_PIN H22 [get_ports {D[2]}];  
set_property IOSTANDARD LVCMOS33 [get_ports {D[2]}]

# "SW3"
set_property PACKAGE_PIN F21 [get_ports {D[3]}];  
set_property IOSTANDARD LVCMOS33 [get_ports {D[3]}]

# "SW4"
set_property PACKAGE_PIN H19 [get_ports {D[4]}];  
set_property IOSTANDARD LVCMOS33 [get_ports {D[4]}]

# "SW5"
set_property PACKAGE_PIN H18 [get_ports {D[5]}];  
set_property IOSTANDARD LVCMOS33 [get_ports {D[5]}]

# "SW6"
set_property PACKAGE_PIN H17 [get_ports {D[6]}];  
set_property IOSTANDARD LVCMOS33 [get_ports {D[6]}]

# "SW7"
set_property PACKAGE_PIN M15 [get_ports {D[7]}];  
set_property IOSTANDARD LVCMOS33 [get_ports {D[7]}]

# "BTNL" Select Input
set_property PACKAGE_PIN N15 [get_ports {SEL[2]}];  
set_property IOSTANDARD LVCMOS33 [get_ports {SEL[2]}]

# "BTNC"
set_property PACKAGE_PIN P16 [get_ports {SEL[1]}];  
set_property IOSTANDARD LVCMOS33 [get_ports {SEL[1]}]

# "BTNR"
set_property PACKAGE_PIN R18 [get_ports {SEL[0]}];  
set_property IOSTANDARD LVCMOS33 [get_ports {SEL[0]}]

# "LD0"
set_property PACKAGE_PIN T22 [get_ports {MX_OUT}];  
set_property IOSTANDARD LVCMOS33 [get_ports {MX_OUT}]
