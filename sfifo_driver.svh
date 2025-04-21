class sfifo_driver extends uvm_driver#(sfifo_seq_item);
	`uvm_component_utils(sfifo_driver)
	virtual sfifo_interface vif;
	sfifo_seq_item req;
	function new(string name = "sfifo_driver", uvm_component parent);
		super.new(name, parent);
	endfunction
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(virtual sfifo_interface)::get(this, "", "vif", vif))
			`uvm_fatal("Driver: ", "No vif is found!")
	endfunction
	virtual task run_phase(uvm_phase phase);
		vif.drv_cb.wr_en <= 1'b0;
		vif.drv_cb.rd_en <= 1'b0;
		vif.drv_cb.input_data <= 1'b0;
		forever begin
			seq_item_port.get_next_item(req);
			if(req.wr_en == 1)
				main_write(req.input_data);
			else if(req.rd_en == 1)
				main_read();
			seq_item_port.item_done();
		end
	endtask
	virtual task main_write(input [7:0] data_in);
		@(posedge vif.clk)
		vif.wr_en <= 1'b1;
		vif.input_data <= data_in;
		@(posedge vif.clk)
		vif.wr_en <= 1'b0;
	endtask
	virtual task wr.rel();
		@(posedge vif.clk)
		vif.drv_cb.wr_en <= 1'b0;
	endtask
	virtual task main_read();
		@(posedge vif.clk)
		vif.rd_en <= 1'b1;
		@(posedge vif.clk)
		vif.rd_en <= 1'b0;
	endtask
	virtual task rd.rel();
		@(posedge vif.clk)
		vif.drv_cb.rd_en <= 1'b0;
	endtask
endclass