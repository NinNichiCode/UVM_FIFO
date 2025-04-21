class sfifo_seq_item extends uvm_sequence_item;
   rand bit wr_en;
   rand bit rd_en;
   rand bit [7:0] input_data;
   rand bit reset; // Thêm rand cho reset
   bit full;
   bit empty;
   bit [7:0] output_data;
   
   `uvm_object_utils_begin(sfifo_seq_item)
   `uvm_field_int(wr_en, UVM_ALL_ON)
   `uvm_field_int(rd_en, UVM_ALL_ON)
   `uvm_field_int(input_data, UVM_ALL_ON)
   `uvm_object_utils_end
   
   constraint wr_rd { wr_en != rd_en; }
   // Thêm constraint cho reset nếu cần
   constraint reset_c { reset inside {0, 1}; }
   
   function new(string name = "sfifo_seq_item");
      super.new(name);
   endfunction
endclass
