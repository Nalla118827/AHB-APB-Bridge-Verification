class ahb_monitor extends uvm_monitor;

	`uvm_component_utils(ahb_monitor)

	virtual ahb_to_apb_if.AHB_MON_MP vif;
	ahb_xtns xtns;

	ahb_agent_config ahb_agt_cfg_h;

	uvm_analysis_port #(ahb_xtns) monitor_port;

	function new(string name="ahb_monitor", uvm_component parent);
		super.new(name,parent);
	endfunction

	function void  build_phase(uvm_phase phase);
		super.build_phase(phase);
		monitor_port=new("monitor_port",this);
		get_config();
	endfunction

	function void get_config();
		
		if(!uvm_config_db #(ahb_agent_config)::get(this,"","ahb_agent_config",ahb_agt_cfg_h))
			`uvm_fatal(get_type_name(),"getting failed");

	endfunction

	function void connect_phase(uvm_phase phase);
		vif=ahb_agt_cfg_h.vif;
	endfunction

	task run_phase(uvm_phase phase);
		forever
			begin
			collect_data();	
			end
	endtask
			

	task collect_data();
		xtns=ahb_xtns::type_id::create("xtns");
		while(vif.ahb_side_monitor_cb.Hready_out!==1)
			@(vif.ahb_side_monitor_cb);

		while(vif.ahb_side_monitor_cb.Htrans!==2 && vif.ahb_side_monitor_cb.Htrans!==3)
			@(vif.ahb_side_monitor_cb);

						

		xtns.Haddr=vif.ahb_side_monitor_cb.Haddr;
		xtns.Htrans=vif.ahb_side_monitor_cb.Htrans;
		xtns.Hsize=vif.ahb_side_monitor_cb.Hsize;
		xtns.Hwrite=vif.ahb_side_monitor_cb.Hwrite;
		xtns.Hburst=vif.ahb_side_monitor_cb.Hburst;
		xtns.Hrdata=vif.ahb_side_monitor_cb.Hrdata;		
		@(vif.ahb_side_monitor_cb);
	
		
		if(xtns.Hwrite)
			xtns.Hwdata=vif.ahb_side_monitor_cb.Hwdata;

		if(xtns.Hwrite==0)
		begin
		   if(vif.ahb_side_monitor_cb.Hready_out==1)
			xtns.Hrdata=vif.ahb_side_monitor_cb.Hrdata;
		end
		
			

	`uvm_info(get_type_name(),$sformatf(xtns.sprint()),UVM_LOW);
		monitor_port.write(xtns);

	endtask
		
endclass	

