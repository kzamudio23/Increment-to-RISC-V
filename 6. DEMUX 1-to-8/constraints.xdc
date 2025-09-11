# Lazy so I copied from https://github.com/Digilent/digilent-xdc/blob/master/Zedboard-Master.xdc a

# "BTNL" Select Input
set_property PACKAGE_PIN N15 [get_ports {SEL[2]}];  
set_property IOSTANDARD LVCMOS33 [get_ports {SEL[2]}]

# "BTNC"
set_property PACKAGE_PIN P16 [get_ports {SEL[1]}];  
set_property IOSTANDARD LVCMOS33 [get_ports {SEL[1]}]

# "BTNR"
set_property PACKAGE_PIN R18 [get_ports {SEL[0]}];  
set_property IOSTANDARD LVCMOS33 [get_ports {SEL[0]}]

# "BTNU" 
set_property PACKAGE_PIN F22 [get_ports {D}];  
set_property IOSTANDARD LVCMOS33 [get_ports {D}]

# "LD0"
set_property PACKAGE_PIN T22 [get_ports {DEMUX_OUT[0]}];  
set_property IOSTANDARD LVCMOS33 [get_ports {DEMUX_OUT[0]}]

# "LD1"
set_property PACKAGE_PIN T21 [get_ports {DEMUX_OUT[1]}];  
set_property IOSTANDARD LVCMOS33 [get_ports {DEMUX_OUT[1]}]

# "LD2"
set_property PACKAGE_PIN U22 [get_ports {DEMUX_OUT[2]}];  
set_property IOSTANDARD LVCMOS33 [get_ports {DEMUX_OUT[2]}]

# "LD3"
set_property PACKAGE_PIN U21 [get_ports {DEMUX_OUT[3]}];  
set_property IOSTANDARD LVCMOS33 [get_ports {DEMUX_OUT[3]}]

# "LD4"
set_property PACKAGE_PIN V22 [get_ports {DEMUX_OUT[4]}];  
set_property IOSTANDARD LVCMOS33 [get_ports {DEMUX_OUT[4]}]

# "LD5"
set_property PACKAGE_PIN W22 [get_ports {DEMUX_OUT[5]}];  
set_property IOSTANDARD LVCMOS33 [get_ports {DEMUX_OUT[5]}]

# "LD6"
set_property PACKAGE_PIN U19 [get_ports {DEMUX_OUT[6]}];  
set_property IOSTANDARD LVCMOS33 [get_ports {DEMUX_OUT[6]}]

# "LD7"
set_property PACKAGE_PIN U14 [get_ports {DEMUX_OUT[7]}];  
set_property IOSTANDARD LVCMOS33 [get_ports {DEMUX_OUT[7]}]
