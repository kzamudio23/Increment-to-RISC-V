# Clock Constraint (100 MHz)
create_clock -period 10.000 -name sys_clk [get_ports clk]

# Input A (4-bit) - Using Slide Switches
set_property PACKAGE_PIN F22 [get_ports {a[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {a[0]}]

set_property PACKAGE_PIN G22 [get_ports {a[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {a[1]}]

set_property PACKAGE_PIN H22 [get_ports {a[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {a[2]}]

set_property PACKAGE_PIN F21 [get_ports {a[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {a[3]}]

# Input B (4-bit) - Using Slide Switches
set_property PACKAGE_PIN H19 [get_ports {b[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {b[0]}]

set_property PACKAGE_PIN H18 [get_ports {b[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {b[1]}]

set_property PACKAGE_PIN H17 [get_ports {b[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {b[2]}]

set_property PACKAGE_PIN M15 [get_ports {b[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {b[3]}]

# Output Product (8-bit) - Using LEDs
set_property PACKAGE_PIN T22 [get_ports {product[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {product[0]}]

set_property PACKAGE_PIN T21 [get_ports {product[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {product[1]}]

set_property PACKAGE_PIN U22 [get_ports {product[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {product[2]}]

set_property PACKAGE_PIN U21 [get_ports {product[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {product[3]}]

set_property PACKAGE_PIN V22 [get_ports {product[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {product[4]}]

set_property PACKAGE_PIN W22 [get_ports {product[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {product[5]}]

set_property PACKAGE_PIN U19 [get_ports {product[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {product[6]}]

set_property PACKAGE_PIN U14 [get_ports {product[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {product[7]}]

# Configuration Settings
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]
