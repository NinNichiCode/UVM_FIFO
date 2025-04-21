virtual class uvm_subscriber #(type T=int) extends uvm_component;
	typedef uvm_subscriber #(T) this_type;
	uvm_analysis_imp #(T, this_type) analysis_export;
	
	function new (string name, uvm_component parent);
		super.new(name, parent);
		analysis_export = new("analysis_imp", this);
	endfunction
	pure virtual function void write(T t);
endclass

class sfifo_coverage extends uvm_subscriber #(sfifo_seq_item);
	`uvm_component_utils(sfifo_coverage)
	sfifo_seq_item trans; 
	covergroup cov_inst;
	WR_EN : coverpoint trans.wr_en { bins bwr = {[0:1]}; }
	RD_EN : coverpoint trans.rd_en { bins brd = {[0:1]}; }
	FULL  : coverpoint trans.full  { bins bf  = {[0:1]}; }
	EMPTY : coverpoint trans.empty { bins be  = {[0:1]}; }

	INPUT_DATA : coverpoint trans.input_data {
		bins low  = {[0:50]};
		bins med  = {[51:150]};
		bins high = {[151:255]};
		bins exact_val = {8'hFF};
	}

	OUTPUT_DATA : coverpoint trans.output_data {
		bins low  = {[0:50]};
		bins med  = {[51:150]};
		bins high = {[151:255]};
		bins zero = {8'h00};
	}

	WR_EN_transition : coverpoint trans.wr_en {
		bins rise = (0 => 1);
		bins fall = (1 => 0);
	}

	RD_EN_transition : coverpoint trans.rd_en {
		bins rise = (0 => 1);
		bins fall = (1 => 0);
	}

	WR_FULL_CROSS : cross WR_EN, FULL {
		bins wr_when_not_full = binsof(WR_EN) intersect {1} && binsof(FULL) intersect {0};
		bins wr_when_full     = binsof(WR_EN) intersect {1} && binsof(FULL) intersect {1};
	}

	RD_EMPTY_CROSS : cross RD_EN, EMPTY {
		bins rd_when_not_empty = binsof(RD_EN) intersect {1} && binsof(EMPTY) intersect {0};
		bins rd_when_empty     = binsof(RD_EN) intersect {1} && binsof(EMPTY) intersect {1};
	}

	WR_DATA_CROSS : cross WR_EN, INPUT_DATA;
	RD_DATA_CROSS : cross RD_EN, OUTPUT_DATA;

	endgroup

  
	function new(string name = "", uvm_component parent);
		super.new(name, parent);
		cov_inst = new(); //
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction
	// Further code here
	virtual function void write(sfifo_seq_item t);
		$cast(trans, t);
		cov_inst.sample();
	endfunction
endclass