class ahb_xtns extends uvm_sequence_item;

	 `uvm_object_utils(ahb_xtns)

//Properties
 rand bit Hwrite;
 rand bit[31:0] Hwdata;
 rand bit[31:0] Haddr;
 rand bit[1:0] Hsize;
 rand bit[1:0] Htrans;
 rand bit[2:0] Hburst;
  
 bit[31:0] Hrdata;
 bit Hresetn;
 bit Hready_in;
 bit Hready_out;
 bit[1:0] Hresp;

 rand bit[9:0] length;

//Constraints
  constraint c1{Hsize inside {[0:2]};}

  constraint c2{Haddr%1024 + (length*(2**Hsize)<1024);
                (Hburst==2)->length==3;
		(Hburst==3)->length==3;
                (Hburst==4)->length==7;
		(Hburst==5)->length==7;
		(Hburst==6)->length==15;
                (Hburst==7)->length==15;}

  constraint c3{(Hsize==1)->(Haddr%2==0);
                (Hsize==2)->(Haddr%4==0);}

  constraint c4{soft Haddr inside {[32'h8000_0000:32'h8000_03ff],
                              [32'h8400_0000:32'h8400_03ff],
                              [32'h8800_0000:32'h8800_03ff],
                              [32'h8c00_0000:32'h8c00_03ff]};}

  function new(string name="ahb_xtns");
   super.new(name);
  endfunction

  function void do_print(uvm_printer printer);
    printer.print_field("Hwrite",this.Hwrite,$bits(Hwrite),UVM_DEC);	
    printer.print_field("Haddr",this.Haddr,$bits(Haddr),UVM_HEX);
    printer.print_field("Hwdata",this.Hwdata,$bits(Hwdata),UVM_HEX);
    printer.print_field("Hsize",this.Hsize,$bits(Hsize),UVM_DEC);
    printer.print_field("Hburst",this.Hburst,$bits(Hburst),UVM_DEC);
    printer.print_field("Hresetn",this.Hresetn,$bits(Hresetn),UVM_DEC);
    printer.print_field("Hready_in",this.Hready_in,$bits(Hready_in),UVM_DEC);
    printer.print_field("Hready_out",this.Hready_out,$bits(Hready_out),UVM_DEC);
    printer.print_field("length",this.length,$bits(length),UVM_DEC);
    printer.print_field("Htrans",this.Htrans,$bits(Htrans),UVM_DEC);
    printer.print_field("Hresp",this.Hresp,$bits(Hresp),UVM_DEC);
    printer.print_field("Hrdata",this.Hrdata,$bits(Hrdata),UVM_HEX);

   
  endfunction 
endclass



