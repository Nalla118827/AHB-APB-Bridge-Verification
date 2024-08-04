class ahb_driver extends uvm_driver#(ahb_xtns);

	`uvm_component_utils(ahb_driver)

	virtual ahb_to_apb_if.AHB_DRV_MP vif;
	ahb_agent_config ahb_cfg_h;

	function new(string name="ahb_driver", uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		get_config();
		endfunction

	function void get_config();
		
			if(!uvm_config_db #(ahb_agent_config)::get(this,"","ahb_agent_config",ahb_cfg_h))
			`uvm_fatal(get_type_name,"getting failed")

	endfunction

	function void connect_phase(uvm_phase phase);
		vif=ahb_cfg_h.vif;
	endfunction

	task run_phase(uvm_phase phase);
			@(vif.ahb_side_driver_cb)
			vif.ahb_side_driver_cb.Hresetn<=1'b0;
			@(vif.ahb_side_driver_cb)
			vif.ahb_side_driver_cb.Hresetn<=1'b1;
			forever
				begin
				seq_item_port.get_next_item(req);
				send_to_dut(req);
				seq_item_port.item_done();	
				end
	endtask

	task send_to_dut(ahb_xtns xtn);
		
			while(vif.ahb_side_driver_cb.Hready_out!==1)
			//$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ in while loop");


		               	@(vif.ahb_side_driver_cb);
				vif.ahb_side_driver_cb.Haddr<=xtn.Haddr;
				vif.ahb_side_driver_cb.Hsize<=xtn.Hsize;
				vif.ahb_side_driver_cb.Htrans<=xtn.Htrans;
				vif.ahb_side_driver_cb.Hwrite<=xtn.Hwrite;
				vif.ahb_side_driver_cb.Hburst<=xtn.Hburst;
				vif.ahb_side_driver_cb.Hready_in<=1'b1;
			@(vif.ahb_side_driver_cb);

                
			if(xtn.Hwrite)
				vif.ahb_side_driver_cb.Hwdata<=xtn.Hwdata;
	
				
		`uvm_info(get_type_name(),$sformatf(xtn.sprint()),UVM_LOW);

	endtask			

endclass
	
