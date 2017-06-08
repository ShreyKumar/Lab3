# Set the working dir, where all compiled Verilog goes.

vlib work

# Compile all Verilog modules in mux.v to working dir;
# could also have multiple Verilog files.
# The timescale argument defines default time unit
# (used when no unit is specified), while the second number
# defines precision (all times are rounded to this value)


vlog -timescale 1ns/1ns mux7.v

# Load simulation using mux as the top level simulation module.
vsim mux7

# Log all signals and add some signals to waveform window.
log {/*}

# add wave {/*}would add all items in top level simulation module.
add wave {/*}

# First test case
# Set input values using the force command, signal names need to be in {} brackets.
force {SW[9:7]} 2#000
force {SW[6:0]} 2#0000000
run 10ns

# Second test case
# Set input values using the force command, signal names need to be in {} brackets.
force {SW[9:7]} 2#000
force {SW[6:0]} 2#0000001
run 10ns

# Third test case
# Set input values using the force command, signal names need to be in {} brackets.
force {SW[9:7]} 2#011
force {SW[6:0]} 2#0001000
run 10ns

# Fourth test case
# Set input values using the force command, signal names need to be in {} brackets.
force {SW[9:7]} 2#010
force {SW[6:0]} 2#0010000
run 10ns

# Fifth test case
# Set input values using the force command, signal names need to be in {} brackets.
force {SW[9:7]} 2#100
force {SW[6:0]} 2#0010000
run 10ns

# Sixth test case
# Set input values using the force command, signal names need to be in {} brackets.
force {SW[9:7]} 2#110
force {SW[6:0]} 2#0000001
run 10ns

# Seventh test case
# Set input values using the force command, signal names need to be in {} brackets.
force {SW[9:7]} 2#110
force {SW[6:0]} 2#0000001
run 10ns

# Eighth test case
# Set input values using the force command, signal names need to be in {} brackets.
force {SW[9:7]} 2#110
force {SW[6:0]} 2#1000001
run 10ns

# Nineth test case
# Set input values using the force command, signal names need to be in {} brackets.
force {SW[9:7]} 2#100
force {SW[6:0]} 2#0010011
run 10ns

# Tenth test case
# Set input values using the force command, signal names need to be in {} brackets.
force {SW[9:7]} 2#011
force {SW[6:0]} 2#0000000
run 10ns
