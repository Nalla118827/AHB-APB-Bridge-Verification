class ahb_top_agent extends uvm_env;
    
      `uvm_component_utils(ahb_top_agent);

	ahb_agent ahb_agt_h[];
	ahb_agent_config ahb_agt_cfg_h;
	env_config env_cfg_h;
      
        function new (string name="ahb_top_agent", uvm_component parent);
        	  super.new(name,parent);
        endfunction

	function void build_phase(uvm_phase phase);
		  super.build_phase(phase);
		  config_agents();
		
	endfunction

	function config_agents();


		if(!uvm_config_db #(env_config)::get(this,"","env_config",env_cfg_h))
			`uvm_fatal(get_type_name,"getting Failed")



		ahb_agt_h=new[env_cfg_h.no_of_ahb_agents];	
        
    
    
	foreach(ahb_agt_h[i])
				begin
				ahb_agt_h[i]=ahb_agent::type_id::create($sformatf("ahb_agt_h[%0d]",i),this);

				uvm_config_db #(ahb_agent_config)::set(this,$sformatf("ahb_agt_h[%0d]*",i),"ahb_agent_config",env_cfg_h.ahb_cfg_h[i]);
				end

	

	endfunction

      
endclass
