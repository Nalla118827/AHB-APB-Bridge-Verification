class env extends uvm_env;

	`uvm_component_utils(env)
	
	env_config env_cfg_h;
	scoreboard sb_h[];
	virtual_sequencer v_seqr_h;
	
	apb_top_agent apb_agt_top_h[];
	ahb_top_agent ahb_agt_top_h[];

	function new(string name="env", uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		v_seqr_h=virtual_sequencer::type_id::create("v_seqrh",this);
		config_agents();
	endfunction

	function void config_agents();

		if(!uvm_config_db #(env_config)::get(this,"","env_config",env_cfg_h))
			`uvm_fatal(get_type_name,"getting Failed")

		ahb_agt_top_h=new[env_cfg_h.no_of_ahb_tops];	

		apb_agt_top_h=new[env_cfg_h.no_of_ahb_tops];


		sb_h=new[env_cfg_h.no_of_scoreboard];



			foreach(sb_h[i])
				begin
				sb_h[i]=scoreboard::type_id::create($sformatf("sb_h[%0d]",i),this);
				end
			foreach(ahb_agt_top_h[i])
				begin
				ahb_agt_top_h[i]=ahb_top_agent::type_id::create($sformatf("ahb_agt_top_h[%0d]",i),this);
				end
			
			foreach(apb_agt_top_h[i])
				begin
				apb_agt_top_h[i]=apb_top_agent::type_id::create($sformatf("apb_agt_top_h[%0d]",i),this);
				end
				
	endfunction


	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		begin
		begin
			for(int i=0;i<env_cfg_h.no_of_ahb_agents;i++)
				begin
				v_seqr_h.ahb_seqr_h[i]=ahb_agt_top_h[i].ahb_agt_h[i].seqr_h;
				end

			for(int i=0;i<env_cfg_h.no_of_ahb_agents;i++)
				begin
				v_seqr_h.apb_seqr_h[i]=apb_agt_top_h[i].apb_agt_h[i].seqr_h;
				end
			
		end

		apb_agt_top_h[0].apb_agt_h[0].mon_h.monitor_port.connect(sb_h[0].fifo_apb[0].analysis_export);
		ahb_agt_top_h[0].ahb_agt_h[0].mon_h.monitor_port.connect(sb_h[0].fifo_ahb[0].analysis_export);
		end
	endfunction
		

endclass
