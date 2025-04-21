# Setting directories: ------------------------------------------------


# Library and mapping: ------------------------------------------------
vlib work
vmap work work

# Compilation: --------------------------------------------------------
vlog sync_fifo.v +acc +cover=bcefst
vlog sfifo_interface.sv -timescale 1ns/10ps
vlog sfifo_agent_pkg.sv
vlog sfifo_environment_pkg.sv
vlog sfifo_sequence_pkg.sv
vlog sfifo_test_pkg.sv
vlog tb_top.sv +acc +cover=bcefst

# Simulation: ---------------------------------------------------------
vsim -coverage tb_top +UVM_TESTNAME=sfifo_test

# Coverage report: ----------------------------------------------------
# Coverage save ucdb file:
coverage save -onexit -assert -directive -cvg -codeAll sfifo_test.ucdb

# Coverage reports with html and text files:
vcover report -html sfifo_test.ucdb -htmldir covhtmlreport
vcover report -file cov_report.txt sfifo_test.ucdb

add wave -r /*
run -all
