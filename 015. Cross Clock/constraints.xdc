# ZedBoard XDC Constraints File

# Clock input (100MHz)
set_property PACKAGE_PIN Y9 [get_ports clk_100mhz]
set_property IOSTANDARD LVCMOS33 [get_ports clk_100mhz]

# Button input (using BTNC - center button)
set_property PACKAGE_PIN P16 [get_ports btn_clk]
set_property IOSTANDARD LVCMOS33 [get_ports btn_clk]

# LED outputs
set_property PACKAGE_PIN T22 [get_ports led_out]
set_property IOSTANDARD LVCMOS33 [get_ports led_out]

set_property PACKAGE_PIN T21 [get_ports status_led]
set_property IOSTANDARD LVCMOS33 [get_ports status_led]

# Additional constraints for button (pull-up)
set_property PULLUP true [get_ports btn_clk]
