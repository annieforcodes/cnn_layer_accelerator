# Main system clock constraint
# This tells the tool that the input port named 'clk' is a primary clock
# with a period of 10.0 nanoseconds (which equals a frequency of 100MHz).
create_clock -period 10.000 -name sys_clk [get_ports clk]