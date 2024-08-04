class apb_driver extends uvm_driver();

	`uvm_component_utils(apb_driver)

	virtual  ahb_to_apb_if.APB_DRV_MP vif;	
	apb_agent_config apb_cfg_h;
	apb_xtns xtns;
	

	function new(string name="apb_driver", uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		get_config();
		//set env-config
	endfunction

	function void get_config();
		
		if(!uvm_config_db #(apb_agent_config)::get(this,"","apb_agent_config",apb_cfg_h))
			`uvm_fatal(get_type_name,"getting failed")

	endfunction

	function void connect_phase(uvm_phase phase);
		vif=apb_cfg_h.vif;
	endfunction

	task run_phase(uvm_phase phase);
		forever
			begin
			send_to_dut();
			end

	endtask

	task send_to_dut();
		xtns=apb_xtns::type_id::create("xtns"); //
		while(vif.apb_side_driver_cb.Pselx==0) //case eq
			@(vif.apb_side_driver_cb);

        
		                                    //penable ===1
 		if(vif.apb_side_driver_cb.Pwrite==0)  //case eq 0
			vif.apb_side_driver_cb.Prdata <= $urandom;//xtns.Prdata;

		 repeat(2) 
		  @(vif.apb_side_driver_cb);

		`uvm_info(get_type_name(),$sformatf(xtns.sprint()),UVM_LOW);
		 
	endtask

	
	
			
endclass

