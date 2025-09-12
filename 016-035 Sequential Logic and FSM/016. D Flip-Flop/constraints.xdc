# Clock input (100MHz)
set_property PACKAGE_PIN Y9 [get_ports clk_100mhz]
set_property IOSTANDARD LVCMOS33 [get_ports clk_100mhz]

# Buttons
set_property PACKAGE_PIN P16 [get_ports btn_reset]
set_property PACKAGE_PIN R18 [get_ports btn_data]
set_property IOSTANDARD LVCMOS33 [get_ports btn_reset]
set_property IOSTANDARD LVCMOS33 [get_ports btn_data]
set_property PULLUP true [get_ports btn_reset]
set_property PULLUP true [get_ports btn_data]

# LEDs
set_property PACKAGE_PIN T22 [get_ports led_q]   
set_property PACKAGE_PIN T21 [get_ports led_clk]
set_property IOSTANDARD LVCMOS33 [get_ports led_q]
set_property IOSTANDARD LVCMOS33 [get_ports led_clk]
