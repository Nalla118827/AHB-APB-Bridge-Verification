class ahb_sequencer extends uvm_sequencer #(ahb_xtns);
	
	`uvm_component_utils(ahb_sequencer)

	function new(string name="ahb_sequencer", uvm_component parent);
		super.new(name,parent);
	endfunction
endclass







