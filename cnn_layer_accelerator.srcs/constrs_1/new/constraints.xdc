# Main system clock constraint
# This tells the tool that the input port named 'clk' is a primary clock
# with a period of 10.0 nanoseconds (which equals a frequency of 100MHz).
#create_clock -period 10.000 -name sys_clk [get_ports clk]


#set_property IOSTANDARD LVCMOS33 [get_ports clk]
#set_property IOSTANDARD LVCMOS33 [get_ports done]
#set_property IOSTANDARD LVCMOS33 [get_ports rst]
#set_property IOSTANDARD LVCMOS33 [get_ports start]
#set_property PACKAGE_PIN D18 [get_ports done]
#set_property PACKAGE_PIN T16 [get_ports rst]
#set_property PACKAGE_PIN W13 [get_ports start]

set_property PACKAGE_PIN D18 [get_ports done_out_0]
set_property PACKAGE_PIN T16 [get_ports reset_in_0]
set_property PACKAGE_PIN W13 [get_ports start_in_0]
set_property IOSTANDARD LVCMOS33 [get_ports done_out_0]
set_property IOSTANDARD LVCMOS33 [get_ports reset_in_0]
set_property IOSTANDARD LVCMOS33 [get_ports start_in_0]
#set_property PACKAGE_PIN K17 [get_ports clk]
