class apb_xtns extends uvm_sequence_item;

 `uvm_object_utils(apb_xtns)

 bit [31:0] Paddr  ;
 bit        Pwrite ;
 bit        Penable;
 bit [31:0] Pwdata ;
 bit        Pselx  ;
 
 rand bit [31:0] Prdata;

 

function new(string name= "apb_xtns");
  super.new(name);
endfunction

function void do_print(uvm_printer printer);
   super.do_print(printer);
  
  printer.print_field( "Penable "  , this.Penable   , $bits(Penable)  ,  UVM_DEC);
  printer.print_field( "Pselx   "  , this.Pselx     , $bits(Pselx)  ,  UVM_DEC);
  printer.print_field( "Pwrite  "  , this.Pwrite    , $bits(Pwrite)  ,  UVM_DEC);
  printer.print_field( "Pwdata  "  , this.Pwdata    , $bits(Pwdata) ,  UVM_HEX);
  printer.print_field( "Paddr   "  , this.Paddr     , $bits(Paddr) ,  UVM_HEX);
  printer.print_field( "Prdata  "  , this.Prdata    , $bits(Prdata) ,  UVM_HEX);
endfunction
endclass
