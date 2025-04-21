class sfifo_sequencer extends uvm_sequencer#(sfifo_seq_item);
	`uvm_component_utils(sfifo_sequencer)
	function new(string name = "sfifo_sequencer", uvm_component parent);
		super.new(name, parent);
	endfunction
endclass