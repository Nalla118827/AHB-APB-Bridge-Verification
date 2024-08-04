class apb_monitor extends uvm_monitor;

	`uvm_component_utils(apb_monitor)
	
	apb_agent_config apb_cfg_h;
	virtual ahb_to_apb_if.APB_MON_MP vif;
	uvm_analysis_port #(apb_xtns) monitor_port;

	function new(string name="apb_monitor", uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		monitor_port=new("monitor_port",this);		
		get_config();
		//set env-config
	endfunction

	function void get_config();
		
		if(!uvm_config_db #(apb_agent_config)::get(this,"","apb_agent_config",apb_cfg_h))
			`uvm_fatal(get_type_name(),"getting failed");



	endfunction

	function void connect_phase(uvm_phase phase);
		vif=apb_cfg_h.vif;
	endfunction

	task run_phase(uvm_phase phase);
		  forever 
			begin
			collect_data();
			end
	endtask

	task collect_data();
		apb_xtns xtn;
		xtn=apb_xtns::type_id::create("xtns");

		while(vif.apb_side_monitor_cb.Penable!==1)
			@(vif.apb_side_monitor_cb);

		xtn.Paddr=vif.apb_side_monitor_cb.Paddr;
		xtn.Pselx=vif.apb_side_monitor_cb.Pselx;
		xtn.Penable=vif.apb_side_monitor_cb.Penable;
		xtn.Pwrite=vif.apb_side_monitor_cb.Pwrite;
			
		if(xtn.Pwrite==0)
			xtn.Prdata=vif.apb_side_monitor_cb.Prdata;
		else
			xtn.Pwdata=vif.apb_side_monitor_cb.Pwdata;

		repeat(2)
			@(vif.apb_side_monitor_cb);
		
		`uvm_info(get_type_name(),$sformatf(xtn.sprint()),UVM_LOW);
			monitor_port.write(xtn);
	
	endtask		
			
endclass

