class apb_sequence extends uvm_sequence#(apb_xtns);

	 `uvm_object_utils(apb_sequence)

	 function new(string name="apb_sequence");
  		super.new(name);
	 endfunction

   	task body;
		 req=apb_xtns::type_id::create("req");
		 start_item(req);
		// assert(req.randomize() );
		 finish_item(req);
	  endtask
  
endclass
