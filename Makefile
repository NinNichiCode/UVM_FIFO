# Biên dịch các file thiết kế và testbench
compile:
	vlib work                         # Tạo thư viện work
	vmap work work                    # Ánh xạ thư viện work
	vlog -cover bcetf sync_fifo.v                  # Biên dịch file RTL
	vlog sfifo_agent_pkg.sv           # Biên dịch package agent UVM
	vlog sfifo_environment_pkg.sv     # Biên dịch package environment UVM
	vlog sfifo_sequence_pkg.sv        # Biên dịch package sequence UVM
	vlog sfifo_test_pkg.sv            # Biên dịch package test UVM
	vlog sfifo_interface.sv           # Biên dịch interface của FIFO
	vlog tb_top.sv                    # Biên dịch testbench top-level

simulate:
	vsim -c -coverage tb_top +UVM_TESTNAME=sfifo_test -do "run -all; coverage save -onexit -assert -directive -cvg -codeAll sfifo_test.ucdb; quit"
	vcover report -html sfifo_test.ucdb -htmldir covhtmlreport
	vcover report -details -file cov_report.txt sfifo_test.ucdb
	

	# vcover report -html sfifo_test.ucdb -htmldir covhtmlreport -exclude uvm_pkg -exclude questa_uvm_pkg


