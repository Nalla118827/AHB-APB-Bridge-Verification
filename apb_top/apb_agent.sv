class apb_agent extends uvm_agent;

	`uvm_component_utils(apb_agent)

	apb_driver drv_h;
	apb_monitor mon_h;
	apb_sequencer seqr_h;
	apb_agent_config apb_cfg_h;


	function new(string name="apb_agent", uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		config_agents();
		//set env-config
	endfunction


	function void config_agents();
		if(!uvm_config_db #(apb_agent_config)::get(this,"","apb_agent_config",apb_cfg_h))
			`uvm_fatal(get_type_name,"getting failed")

		mon_h=apb_monitor::type_id::create("mon_h",this);

		if(apb_cfg_h.is_active==UVM_ACTIVE)
			begin
			seqr_h=apb_sequencer::type_id::create("seqr_h",this);
		        drv_h=apb_driver::type_id::create("drv_h",this);
			end			
	endfunction

	//connect phase
	
            function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		drv_h.seq_item_port.connect(seqr_h.seq_item_export);
	    endfunction	

endclass
