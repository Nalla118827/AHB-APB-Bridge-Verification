module top;

	import uvm_pkg::*;
	
	import ahb_2_apb::*;

	bit clock;

	always
		#5 clock=~clock;



		//interface
	ahb_to_apb_if vif(clock); 
		


	//rtl	

		 rtl_top DUV (.Hclk(clock),
                      		.Hresetn(vif.Hresetn),
                   		 .Htrans(vif.Htrans),
		   		.Hsize(vif.Hsize), 
		   		.Hreadyin(vif.Hready_in),
		   		.Hwdata(vif.Hwdata), 
		   		.Haddr(vif.Haddr),
		    		.Hwrite(vif.Hwrite),
                  		.Prdata(vif.Prdata),
		  	.Hrdata(vif.Hrdata),
		    	.Hresp(vif.Hresp),
		     	.Hreadyout(vif.Hready_out),
		     	.Pselx(vif.Pselx),
		      	.Pwrite(vif.Pwrite),
		      	.Penable(vif.Penable), 
		        .Paddr(vif.Paddr),
		        .Pwdata(vif.Pwdata)
		    ) ;	



	

	initial 
		begin
			`ifdef VCS                      //for waveform
         		$fsdbDumpvars(0, top);
        		`endif

			uvm_config_db #(virtual ahb_to_apb_if)::set(null,"*","vif",vif);
			
			run_test();
		end

endmodule
