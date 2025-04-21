`timescale 1ps/1ps
`include "sfifo_interface.sv"
`include "uvm_macros.svh"
`include "sfifo_test_pkg.sv"
import uvm_pkg::*;
import sfifo_test_pkg::*;
module tb_top;
	bit clk;
	bit reset;
	always #5 clk = ~clk;
	initial begin
		clk = 1'b1;
		reset = 1'b0;
		#5
		reset = 1'b1;
		#100 reset = 1'b0;
		#20 reset = 1'b1;
	end
	sfifo_interface tif(clk, reset);
	sync_fifo dut(.clk(tif.clk), .reset(tif.reset),
				  .input_data(tif.input_data),
				  .wr_en(tif.wr_en),
				  .rd_en(tif.rd_en),
				  .full(tif.full),
				  .empty(tif.empty),
				  .output_data(tif.output_data));
	initial begin
		uvm_config_db#(virtual sfifo_interface)::set(null, "*", "vif", tif);
		run_test();
	end
endmodule