	`include "uvm_macros.svh"
interface sfifo_interface(input clk, reset);
	bit wr_en;
	bit rd_en;
	bit [7:0] input_data;
	bit full;
	bit empty;
	bit [7:0] output_data;		// co the thay bit --> logic
	// Further code here
	clocking drv_cb @(posedge clk);
		default input #1 output #1;
		output wr_en;
		output rd_en;
		output input_data;
		input full;
		input empty;
		input output_data;
	endclocking
	clocking mon_cb @(posedge clk);
		default input #1 output #1;
		input wr_en;
		input rd_en;
		input input_data;
		input full;
		input empty;
		input output_data;
	endclocking
	modport drv_mp (input clk, reset, clocking drv_cb);
	modport mon_mp (input clk, reset, clocking mon_cb);
endinterface