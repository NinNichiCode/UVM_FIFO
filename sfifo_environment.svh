class sfifo_environment extends uvm_env;
	sfifo_agent sf_agt;
	sfifo_scoreboard sf_scb;
	sfifo_coverage sf_cov;
	`uvm_component_utils(sfifo_environment)
	function new(string name = "sfifo_environment", uvm_component parent);
		super.new(name, parent);
	endfunction
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		sf_agt = sfifo_agent::type_id::create("sf_agt", this);
		sf_scb = sfifo_scoreboard::type_id::create("sf_scb", this);
		sf_cov = sfifo_coverage::type_id::create("sf_cov", this);
	endfunction
	// Futher code here
	virtual function void connect_phase(uvm_phase phase);
		// Monitor behavioras as a broadcaster
		// Connecting analysis_port to imp_ports
		sf_agt.sf_mon.item_got_port.connect(sf_scb.item_got_export);
		sf_agt.sf_mon.item_got_port.connect(sf_cov.analysis_export);
	endfunction
endclass