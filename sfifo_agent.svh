class sfifo_agent extends uvm_agent;
	sfifo_driver sf_drv;
	sfifo_monitor sf_mon;
	sfifo_sequencer sf_seqr;
	`uvm_component_utils(sfifo_agent)
	function new(string name = "sfifo_agent", uvm_component parent);
		super.new(name, parent);
	endfunction
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(get_is_active() == UVM_ACTIVE) begin
			sf_seqr = sfifo_sequencer::type_id::create("sf_seqr", this);
			sf_drv = sfifo_driver::type_id::create("sf_drv", this);
		end
		sf_mon = sfifo_monitor::type_id::create("sf_mon", this);
	endfunction
	function void connect_phase(uvm_phase phase);
		  sf_drv.seq_item_port.connect(sf_seqr.seq_item_export);
	endfunction
endclass