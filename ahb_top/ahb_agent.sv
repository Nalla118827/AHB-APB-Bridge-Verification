class ahb_agent extends uvm_agent;

	`uvm_component_utils(ahb_agent)

	ahb_driver drv_h;
	ahb_monitor mon_h;
	ahb_sequencer seqr_h;
	ahb_agent_config ahb_cfg_h;


	function new(string name="ahb_agent", uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		config_agents();
	endfunction

	function void config_agents();
		if(!uvm_config_db #(ahb_agent_config)::get(this,"","ahb_agent_config",ahb_cfg_h))
			`uvm_fatal(get_type_name,"getting failed")

		mon_h=ahb_monitor::type_id::create("mon_h",this);

		if(ahb_cfg_h.is_active==UVM_ACTIVE)
			begin
			seqr_h=ahb_sequencer::type_id::create("seqr_h",this);
		        drv_h=ahb_driver::type_id::create("drv_h",this);
			end

		
			
	endfunction

	//connect phase
	function void connect_phase(uvm_phase phase);
			drv_h.seq_item_port.connect(seqr_h.seq_item_export);
	endfunction

endclass
