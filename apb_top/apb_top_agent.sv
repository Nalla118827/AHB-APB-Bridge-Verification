class apb_top_agent extends uvm_env;
    
      `uvm_component_utils(apb_top_agent);

	apb_agent apb_agt_h[];
	apb_agent_config apb_agt_cfg_h;
	env_config env_cfg_h;
	apb_agent_config apb_cfg_h;
      
        function new (string name="apb_top_agent", uvm_component parent);
        	  super.new(name,parent);
        endfunction

	function void build_phase(uvm_phase phase);
		  super.build_phase(phase);
		  config_agents();
		
	endfunction

	function config_agents();


		if(!uvm_config_db #(env_config)::get(this,"","env_config",env_cfg_h))
			`uvm_fatal(get_type_name,"getting Failed")


		apb_agt_h=new[env_cfg_h.no_of_apb_agents];
        
    

			
	foreach(apb_agt_h[i])
				begin
				apb_agt_h[i]=apb_agent::type_id::create($sformatf("apb_agt_h[%0d]",i),this);

				uvm_config_db #(apb_agent_config)::set(this,$sformatf("apb_agt_h[%0d]*",i),"apb_agent_config",env_cfg_h.apb_cfg_h[i]);
				end
	

	endfunction

      
endclass
