class sfifo_sequence extends uvm_sequence#(sfifo_seq_item);
	`uvm_object_utils(sfifo_sequence)
	
	function new(string name = "sfifo_sequence");
		super.new(name);
	endfunction
	
	// Further code here
	virtual task body();
		`uvm_info(get_type_name(), $sformatf("-------- Generata 16 Write REQs --------"), UVM_LOW)
		repeat(16) begin
			req = sfifo_seq_item::type_id::create("req");
			start_item(req);
			assert(req.randomize() with {reset == 1;});
			finish_item(req);
		end
		
		`uvm_info(get_type_name(), $sformatf("-------- Generate 16 Read REQs --------"), UVM_LOW)
		repeat(16) begin
			req = sfifo_seq_item::type_id::create("req");
			start_item(req);
			assert(req.randomize() with {rd_en == 1;});
			finish_item(req);
		end
		
		`uvm_info(get_type_name(), $sformatf("-------- Generata 32 Random REQs --------"), UVM_LOW)
		repeat(32) begin
			req = sfifo_seq_item::type_id::create("req");
			start_item(req);
			assert(req.randomize());
			finish_item(req);
		end
	
		// Trong sequence
		repeat(40) begin
			req.wr_en = 1;
			req.input_data = $urandom_range(0, 255);
			start_item(req);
			finish_item(req);
		end
		
		// đọc đủ 40 lần để ép rd_ptr tăng lên
		repeat(40) begin
			req.rd_en = 1;
			start_item(req);
			finish_item(req);
		end
		
		
	endtask
	
endclass
