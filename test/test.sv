 class test extends uvm_test;

	`uvm_component_utils(test)

	env env_h;
	env_config env_cfg_h;
	ahb_agent_config ahb_cfg_h[];
	apb_agent_config apb_cfg_h[];
	virtual_sequence v_seqh_h;
	

	int no_of_ahb_agents=1;
	int no_of_apb_agents=1;
	int no_of_scoreboard=1;
	int no_of_ahb_tops=1;
	int no_of_apb_tops=1;

	function new(string name="test", uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env_h=env::type_id::create("env_h",this);
		env_cfg_h=env_config::type_id::create("env_cfg_h");
		v_seqh_h=virtual_sequence::type_id::create("v_seqh_h");
		config_agents();
		uvm_config_db #(env_config)::set(this,"*","env_config",env_cfg_h);		
	endfunction

	function void config_agents();
		
		ahb_cfg_h=new[no_of_ahb_agents];
		env_cfg_h.ahb_cfg_h=new[no_of_ahb_agents];

		foreach(ahb_cfg_h[i])
			begin
			ahb_cfg_h[i]=ahb_agent_config::type_id::create("ahb_cfg_h[i]");	
			if(!uvm_config_db #(virtual ahb_to_apb_if)::get(this,"","vif",ahb_cfg_h[i].vif))
				`uvm_fatal(get_type_name,"getting Failed")

			ahb_cfg_h[i].is_active=UVM_ACTIVE;
			env_cfg_h.ahb_cfg_h[i]=ahb_cfg_h[i];
			end



		apb_cfg_h=new[no_of_apb_agents];
		env_cfg_h.apb_cfg_h=new[no_of_apb_agents];

		foreach(apb_cfg_h[i])
			begin
			apb_cfg_h[i]=apb_agent_config::type_id::create("apb_cfg_h[i]");	
			if(!uvm_config_db #(virtual ahb_to_apb_if )::get(this,"","vif",apb_cfg_h[i].vif))
				`uvm_fatal(get_type_name,"getting Failed")

			apb_cfg_h[i].is_active=UVM_ACTIVE;
			env_cfg_h.apb_cfg_h[i]=apb_cfg_h[i];
			end

		env_cfg_h.no_of_apb_agents=no_of_apb_agents;
		env_cfg_h.no_of_ahb_agents=no_of_ahb_agents;
		env_cfg_h.no_of_scoreboard=no_of_scoreboard;
		env_cfg_h.no_of_ahb_tops=no_of_ahb_tops;
		env_cfg_h.no_of_ahb_tops=no_of_apb_tops;

	endfunction

	function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
		uvm_top.print_topology;
	endfunction

endclass


//V_unspecified
class unspecififed_test extends test;

	`uvm_component_utils(unspecififed_test)

	 V_unspecified unspeci_seq_h;


	function new (string name="unspecififed_test", uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
			unspeci_seq_h=V_unspecified::type_id::create("unspeci_seq_h");

			phase.raise_objection(this);
		    unspeci_seq_h.start(env_h.v_seqr_h);
			#500;
			phase.drop_objection(this);
	endtask
endclass




//SINGLE_TEST

class single_test extends test;

	`uvm_component_utils(single_test)

	V_single single_tx;

	function new (string name="single_test", uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
			single_tx=V_single::type_id::create("single");

			phase.raise_objection(this);
			single_tx.start(env_h.v_seqr_h);
			#200;
			phase.drop_objection(this);
	endtask
endclass

//INCREAMENT_4

class inc_4_test extends test;

	`uvm_component_utils(inc_4_test)

	 V_increment_4 inc_4_tx;

	function new (string name="inc_4_test", uvm_component parent);
		super.new(name,parent);
		inc_4_tx=V_increment_4::type_id::create("inc_4_tx");
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
			phase.raise_objection(this);
			inc_4_tx.start(env_h.v_seqr_h);
			#500;
			phase.drop_objection(this);
	endtask
endclass

//INCREAMENT_4

class inc_8_test extends test;

	`uvm_component_utils(inc_8_test)

	 V_increment_8 inc_8_tx;

	function new (string name="inc_8_test", uvm_component parent);
		super.new(name,parent);
		inc_8_tx=V_increment_8::type_id::create("inc_8_tx");
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
			phase.raise_objection(this);
			inc_8_tx.start(env_h.v_seqr_h);
			#200;
			phase.drop_objection(this);
	endtask
endclass

//INCREAMENT_16

class inc_16_test extends test;

	`uvm_component_utils(inc_16_test)

	 V_increment_16 inc_16_tx;

	function new (string name="inc_16_test", uvm_component parent);
		super.new(name,parent);
		inc_16_tx=V_increment_16::type_id::create("inc_16_tx");
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
			phase.raise_objection(this);
			inc_16_tx.start(env_h.v_seqr_h);
			#200;
			phase.drop_objection(this);
	endtask
endclass

//WRAPPER4

class wrapper_4_test extends test;

	`uvm_component_utils(wrapper_4_test)

	 V_wrapper_4 wrapper_4_tx;

	function new (string name="wrapper_4_test", uvm_component parent);
		super.new(name,parent);
		wrapper_4_tx=V_wrapper_4::type_id::create("wrapper_4_tx");
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
			phase.raise_objection(this);
			wrapper_4_tx.start(env_h.v_seqr_h);
			#200;
			phase.drop_objection(this);
	endtask

endclass


//WRAPPER8

class wrapper_8_test extends test;

	`uvm_component_utils(wrapper_8_test)

	 V_wrapper_8 wrapper_8_tx;

	function new (string name="wrapper_8_test", uvm_component parent);
		super.new(name,parent);
		wrapper_8_tx=V_wrapper_8::type_id::create("wrapper_8_tx");
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
			phase.raise_objection(this);
			wrapper_8_tx.start(env_h.v_seqr_h);
			#200;
			phase.drop_objection(this);
	endtask

endclass


//WRAPPER16

class wrapper_16_test extends test;

	`uvm_component_utils(wrapper_16_test)

	 V_wrapper_16 wrapper_16_tx;

	function new (string name="wrapper_16_test", uvm_component parent);
		super.new(name,parent);
		wrapper_16_tx=V_wrapper_16::type_id::create("wrapper_16_tx");
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
			phase.raise_objection(this);
			wrapper_16_tx.start(env_h.v_seqr_h);
			#200;
			phase.drop_objection(this);
	endtask

endclass

