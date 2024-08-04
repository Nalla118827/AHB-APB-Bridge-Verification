class virtual_sequence extends uvm_sequence #(uvm_sequence_item);

	`uvm_object_utils(virtual_sequence)

	virtual_sequencer v_seqr_h;
	ahb_sequencer ahb_seqr_h[];
	apb_sequencer apb_seqr_h[];
	env_config env_cfg_h;

	increment_4 inc_4_seq_h;
	increment_8 inc_8_seq_h;
	increment_16 inc_16_seq_h;

	wrap4  wrap_4_seq_h;
	wrap8 wrap_8_seq_h;
	wrap16 wrap_16_seq_h;

	single_transfer single_h;
	unspecified  unspecified_seq_h;

	function new (string name="virtual_sequence");
		super.new(name);
	endfunction

	task body();
		if(!uvm_config_db #(env_config)::get(null,get_full_name(),"env_config",env_cfg_h))
			`uvm_fatal(get_type_name,"getting Failed")

	ahb_seqr_h=new[env_cfg_h.no_of_ahb_agents];
	apb_seqr_h=new[env_cfg_h.no_of_apb_agents];

	assert($cast(v_seqr_h,m_sequencer))
	else 
		begin
		`uvm_error(get_type_name,"casting failed in Virtual sequnce");
		end

	foreach(ahb_seqr_h[i])
		ahb_seqr_h[i]=v_seqr_h.ahb_seqr_h[i];
	foreach(apb_seqr_h[i])
		apb_seqr_h[i]=v_seqr_h.apb_seqr_h[i];

	endtask

endclass


//UNSPECIFIED

class V_unspecified extends virtual_sequence;

	`uvm_object_utils(V_unspecified)

	function new(string name="V_unspecified");
		super.new(name);
	endfunction

	task body();
		super.body();
	  unspecified_seq_h=unspecified::type_id::create("unspecified_seq_h");
	  foreach(ahb_seqr_h[i])
	  	begin
		unspecified_seq_h.start(ahb_seqr_h[i]);
		end
	endtask

endclass

//SINGLE CLASS

class V_single extends virtual_sequence;

	`uvm_object_utils(V_single)

	function new(string name="V_single");
		super.new(name);
	endfunction

	task body();
		super.body();
	  single_h=single_transfer::type_id::create("single_h");
	  foreach(ahb_seqr_h[i])
	  	begin
		single_h.start(ahb_seqr_h[i]);
		end
	endtask

endclass

class V_increment_4 extends virtual_sequence;

	`uvm_object_utils(V_increment_4)

	function new(string name="V_increment_4");
		super.new(name);
	endfunction

	task body();
		super.body();
	begin
	inc_4_seq_h=increment_4::type_id::create("inc_4_seq_h");
	foreach(ahb_seqr_h[i])
	  	begin
        inc_4_seq_h.start(ahb_seqr_h[i]);		
		end
	end
	endtask
endclass

//INCREAMENT_8

class V_increment_8 extends virtual_sequence;

	`uvm_object_utils(V_increment_8)

	function new(string name="V_increment_8");
		super.new(name);
	endfunction

	task body();
		super.body();
	begin
	inc_8_seq_h=increment_8::type_id::create("inc_8_seq_h");
	foreach(ahb_seqr_h[i])
	  	begin
        inc_8_seq_h.start(ahb_seqr_h[i]);		
		end
	end
	endtask
endclass


//INCREAMENT_16

class V_increment_16 extends virtual_sequence;

	`uvm_object_utils(V_increment_16)

	function new(string name="V_increment_16");
		super.new(name);
	endfunction

	task body();
		super.body();
	begin
	inc_16_seq_h=increment_16::type_id::create("inc_16_seq_h");
	foreach(ahb_seqr_h[i])
	  	begin
        inc_16_seq_h.start(ahb_seqr_h[i]);		
		end
	end
	endtask
endclass


//WRAPPER4

class V_wrapper_4 extends virtual_sequence;

	`uvm_object_utils(V_wrapper_4)

	function new(string name="V_wrapper_4");
		super.new(name);
	endfunction

	task body();
		super.body();
	begin
	wrap_4_seq_h=wrap4::type_id::create("warp_4_seq_h");
	foreach(ahb_seqr_h[i])
	  	begin
        wrap_4_seq_h.start(ahb_seqr_h[i]);		
		end
	end
	endtask
endclass


//WRAPPER8

class V_wrapper_8 extends virtual_sequence;

	`uvm_object_utils(V_wrapper_8)

	function new(string name="V_wrapper_8");
		super.new(name);
	endfunction

	task body();
		super.body();
	begin
	wrap_8_seq_h=wrap8::type_id::create("warp_8_seq_h");
	foreach(ahb_seqr_h[i])
	  	begin
        wrap_8_seq_h.start(ahb_seqr_h[i]);		
		end
	end
	endtask
endclass


//WRAPPER16

class V_wrapper_16 extends virtual_sequence;

	`uvm_object_utils(V_wrapper_16)

	function new(string name="V_wrapper_16");
		super.new(name);
	endfunction

	task body();
		super.body();
	begin
	wrap_16_seq_h=wrap16::type_id::create("warp_16_seq_h");
	foreach(ahb_seqr_h[i])
	  	begin
        wrap_16_seq_h.start(ahb_seqr_h[i]);		
		end
	end
	endtask
endclass

