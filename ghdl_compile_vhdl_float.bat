echo off
set source=./

ghdl -a --ieee=synopsys --std=08 %source%/register_operations/register_operations_pkg.vhd

ghdl -a --ieee=synopsys --std=08 %source%/float_to_real_conversions/float_to_real_conversions_pkg.vhd
ghdl -a --ieee=synopsys --std=08 %source%/float_arithmetic_operations/float_arithmetic_operations_pkg.vhd

ghdl -a --ieee=synopsys --std=08 %source%/float_adder/float_adder_pkg.vhd
