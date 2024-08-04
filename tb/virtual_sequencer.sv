class virtual_sequencer extends uvm_sequencer#(uvm_sequence_item);

	`uvm_component_utils(virtual_sequencer)

	ahb_sequencer ahb_seqr_h[];
	apb_sequencer apb_seqr_h[];
	env_config env_cfg_h;

	function new(string name="virtual_sequencer",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db #(env_config)::get(this,"","env_config",env_cfg_h))
				`uvm_fatal(get_full_name(),"Failed to get env_c0onfig in Virtual_sequencer")

		ahb_seqr_h=new[env_cfg_h.no_of_ahb_agents];
		apb_seqr_h=new[env_cfg_h.no_of_apb_agents];
	endfunction

endclass
