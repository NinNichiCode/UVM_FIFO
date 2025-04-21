class sfifo_test extends uvm_test;
    `uvm_component_utils(sfifo_test)

    sfifo_environment m_env;
    sfifo_sequence m_seq;

    function new(string name = "sfifo_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        m_env = sfifo_environment::type_id::create("m_env", this);
        m_seq = sfifo_sequence::type_id::create("m_seq", this); // Hoặc có thể đổi thành tên khác nếu test khác
    endfunction

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        m_seq.start(m_env.sf_agt.sf_seqr);
        phase.phase_done.set_drain_time(this, 100); // để trước drop
        phase.drop_objection(this);
    endtask
endclass
