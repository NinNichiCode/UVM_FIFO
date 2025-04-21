class sfifo_monitor extends uvm_monitor;
	`uvm_component_utils(sfifo_monitor)
	virtual sfifo_interface vif;
	sfifo_seq_item item_got; //
	uvm_analysis_port#(sfifo_seq_item) item_got_port; //
	
	function new(string name = "sfifo_monitor", uvm_component parent);
		super.new(name, parent);
		// data transaction
		item_got_port = new("item_got_port", this);		
	endfunction
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		// data transaction
		item_got = sfifo_seq_item::type_id::create("item_got");	//
		if(!uvm_config_db#(virtual sfifo_interface)::get(this, "", "vif", vif))
			`uvm_fatal("Monitor: ", "No vif is found!")
	endfunction
	// Further code here
	virtual task run_phase(uvm_phase phase);
		forever begin
			@(posedge vif.clk)
			if(vif.wr_en == 1) begin
				@(posedge vif.clk)
				$display("\nWR is high");
				item_got.input_data = vif.input_data;
				item_got.wr_en = 1'b1;
				item_got.rd_en = 1'b0;
				item_got.full = vif.full;
				item_got_port.write(item_got);
			end
			else if(vif.rd_en == 1) begin
				@(posedge vif.clk)
				$display("\nRD is high");
				item_got.output_data = vif.output_data;
				item_got.rd_en = 1'b1;
				item_got.wr_en = 1'b0;
				item_got.empty = vif.empty;
				item_got_port.write(item_got);
			end
		end
	endtask
endclass