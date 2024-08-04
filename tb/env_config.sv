class env_config extends uvm_object;

	`uvm_object_utils(env_config)

	function new (string name="env_config");
		super.new(name);	
	endfunction

	bit has_no_of_ahb_agent_tops=1;
	bit has_no_of_apb_agent_tops=1;	
	bit has_no_of_ahb_agents=1;
	bit has_no_of_apb_agents=1;
	bit has_no_of_scoreboard=1;
	
	
	
	int no_of_ahb_tops;
	int no_of_apb_tops;
	int no_of_ahb_agents=1;
	int no_of_apb_agents=1;
	int no_of_scoreboard;

	ahb_agent_config ahb_cfg_h[];
	apb_agent_config apb_cfg_h[];


endclass
