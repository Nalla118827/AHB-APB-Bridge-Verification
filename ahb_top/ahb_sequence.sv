class ahb_sequence extends uvm_sequence#(ahb_xtns);

	 `uvm_object_utils(ahb_sequence)

	 function new(string name="ahb_sequence");
  		super.new(name);
	 endfunction

endclass

//Single transfer class
class single_transfer extends ahb_sequence;
	
	 `uvm_object_utils(single_transfer)

	function new(string name="single_transfer");
		 super.new(name);
	endfunction

   	task body();
      begin
		 req=ahb_xtns::type_id::create("req");
		 start_item(req);
		 assert(req.randomize() with {req.Htrans==2'b10;req.Hwrite inside{1,0};req.Hburst==0;});
		 finish_item(req);
     end
	  endtask

endclass

//Increment unspecified
class increment_4 extends ahb_sequence;

	 `uvm_object_utils(increment_4)

	 function new(string name="increment_4");
		  super.new(name);
	 endfunction

 bit[31:0] l_haddr;
 bit[1:0] l_hsize;
 bit l_hwrite;
 bit[9:0] l_hlength;
 bit[1:0] l_htrans;
 bit [2:0] l_hburst;


 task body;
  begin
	  req=ahb_xtns::type_id::create("req");
	  start_item(req);
	  assert(req.randomize() with {req.Htrans==2'b10;req.Hburst==3'b011;req.Hwrite inside{0,1};});
       	  finish_item(req);

  l_haddr=req.Haddr;
  l_hsize=req.Hsize;
  l_hwrite=req.Hwrite;
  l_hlength=req.length;
  l_hburst=req.Hburst;
  l_htrans=req.Htrans;


   if(req.Hburst==3'b011)
      for(int i=0;i<3;i++)
       begin
       start_item(req);
       if(req.Hsize==3'b000)
          assert(req.randomize() with {req.Hsize==l_hsize;
                                 req.Hwrite==l_hwrite;
                                 req.Htrans==2'b11;
				  req.Hburst==l_hburst;
                                 req.Haddr==l_haddr+(2**l_hsize);});
       if(req.Hsize==3'b001)
          assert(req.randomize() with {req.Hsize==l_hsize;
                                 req.Hwrite==l_hwrite;
                                 req.Htrans==2'b11;
				  req.Hburst==l_hburst;
                                 req.Haddr==l_haddr+(2**l_hsize);});

        if(req.Hsize==3'b010)
          assert(req.randomize() with {req.Hsize==l_hsize;
                                 req.Hwrite==l_hwrite;
                                 req.Htrans==2'b11;
				  req.Hburst==l_hburst;
                                 req.Haddr==l_haddr+(2**l_hsize);});
      finish_item(req);
    l_haddr=req.Haddr;
   end
   end
   endtask
endclass

//INCREAMENT--8
//Increment unspecified
class increment_8 extends ahb_sequence;

	 `uvm_object_utils(increment_8)

	 function new(string name="increment_8");
		  super.new(name);
	 endfunction

 bit[31:0] l_haddr;
 bit[1:0] l_hsize;
 bit l_hwrite;
 bit[9:0] l_hlength;
 bit[1:0] l_htrans;
 bit [2:0] l_hburst;


 task body;
	  req=ahb_xtns::type_id::create("req");
	  start_item(req);
	  assert(req.randomize() with {req.Htrans==2'b10;req.Hburst==3'b101;Hwrite inside{0,1};});
       	  finish_item(req);

  l_haddr=req.Haddr;
  l_hsize=req.Hsize;
  l_hwrite=req.Hwrite;
  l_hlength=req.length;
  l_hburst=req.Hburst;
  l_htrans=req.Htrans;

if(req.Hburst==3'b101)
  for(int i=0;i<7;i++)
   begin
    start_item(req);
    if(req.Hsize==3'b000)
    assert(req.randomize() with {req.Hsize==l_hsize;
                                 req.Hwrite==l_hwrite;
                                 req.Htrans==2'b11;
				  req.Hburst==l_hburst;
                                 req.Haddr==l_haddr+(2**l_hsize);});
    if(req.Hsize==3'b001)
   assert(req.randomize() with {req.Hsize==l_hsize;
                                 req.Hwrite==l_hwrite;
                                 req.Htrans==2'b11;
				  req.Hburst==l_hburst;
                                 req.Haddr==l_haddr+(2**l_hsize);});

    if(req.Hsize==3'b010)
   assert(req.randomize() with {req.Hsize==l_hsize;
                                 req.Hwrite==l_hwrite;
                                 req.Htrans==2'b11;
				  req.Hburst==l_hburst;
                                 req.Haddr==l_haddr+(2**l_hsize);});
    finish_item(req);
    l_haddr=req.Haddr;
   end
   endtask
endclass


//INCREAMENT--16
class increment_16 extends ahb_sequence;

	 `uvm_object_utils(increment_16)

	 function new(string name="increment_16");
		  super.new(name);
	 endfunction

 bit[31:0] l_haddr;
 bit[1:0] l_hsize;
 bit l_hwrite;
 bit[9:0] l_hlength;
 bit[1:0] l_htrans;
 bit [2:0] l_hburst;


 task body;
	  req=ahb_xtns::type_id::create("req");
	  start_item(req);
	  assert(req.randomize() with {req.Htrans==2'b10;req.Hburst==3'b111;Hwrite inside{0,1};});
       	  finish_item(req);

  l_haddr=req.Haddr;
  l_hsize=req.Hsize;
  l_hwrite=req.Hwrite;
  l_hlength=req.length;
  l_hburst=req.Hburst;
  l_htrans=req.Htrans;

if(req.Hburst==3'b111)
  for(int i=0;i<15;i++)
   begin
    start_item(req);
    if(req.Hsize==3'b000)
    assert(req.randomize() with {req.Hsize==l_hsize;
                                 req.Hwrite==l_hwrite;
                                 req.Htrans==2'b11;
				  req.Hburst==l_hburst;
                                 req.Haddr==l_haddr+(2**l_hsize);});
    if(req.Hsize==3'b001)
   assert(req.randomize() with {req.Hsize==l_hsize;
                                 req.Hwrite==l_hwrite;
                                 req.Htrans==2'b11;
				  req.Hburst==l_hburst;
                                 req.Haddr==l_haddr+(2**l_hsize);});

    if(req.Hsize==3'b010)
   assert(req.randomize() with {req.Hsize==l_hsize;
                                 req.Hwrite==l_hwrite;
                                 req.Htrans==2'b11;
				  req.Hburst==l_hburst;
                                 req.Haddr==l_haddr+(2**l_hsize);});
    finish_item(req);
    l_haddr=req.Haddr;
   end

 endtask

endclass

//wrapping sequence(wrap4)
class wrap4 extends ahb_sequence;

	 `uvm_object_utils(wrap4)

 bit[31:0] l_haddr;
 bit[1:0] l_hsize;
 bit l_hwrite;
 bit [9:0] l_hlength;
 bit[1:0] l_htrans;
 bit [2:0] l_hburst;


	 function new(string name="wrap4");
	   super.new(name);
	 endfunction

 task body;
	  req=ahb_xtns::type_id::create("req");
	  start_item(req);
	  assert(req.randomize() with {req.Htrans==2'b10;req.Hburst==3'b010;Hwrite inside {0,1};});
	  finish_item(req);

  l_haddr=req.Haddr;
  l_hsize=req.Hsize;
  l_hwrite=req.Hwrite;
  l_hlength=req.length;
  l_htrans=req.Htrans;
  l_hburst=req.Hburst;

if(req.Hburst==3'b010)
begin
  for(int i=0;i<3;i++)
   begin
    start_item(req);
    if(req.Hsize==3'b000)
     assert(req.randomize() with {Hsize==l_hsize;
                                 Hwrite==l_hwrite;
                                 Htrans==2'b11;
				  Hburst==l_hburst;
				Haddr=={l_haddr[31:2],l_haddr[1:0]+1'b1};});
    if(req.Hsize==3'b001)
     assert(req.randomize() with {Hsize==l_hsize;
                                 Hwrite==l_hwrite;
                                 Htrans==2'b11;
				  Hburst==l_hburst;
				Haddr=={l_haddr[31:3],l_haddr[2:0]+2'b10};});
    if(req.Hsize==3'b010)
     assert(req.randomize() with {Hsize==l_hsize;
                                 Hwrite==l_hwrite;
                                 Htrans==2'b11;
				  Hburst==l_hburst;
				Haddr=={l_haddr[31:4],l_haddr[3:0]+4'b0100};});
    finish_item(req);

  l_haddr=req.Haddr;

end
   end
endtask
endclass 


//WRAPPER8
class wrap8 extends ahb_sequence;

	 `uvm_object_utils(wrap8)

 bit[31:0] l_haddr;
 bit[1:0] l_hsize;
 bit l_hwrite;
 bit [9:0] l_hlength;
 bit[1:0] l_htrans;
 bit [2:0] l_hburst;


	 function new(string name="wrap8");
	   super.new(name);
	 endfunction

 task body;
	  req=ahb_xtns::type_id::create("req");
	  start_item(req);
	  assert(req.randomize() with {req.Htrans==2'b10;req.Hburst==3'b100;Hwrite inside {0,1};});
	  finish_item(req);

  l_haddr=req.Haddr;
  l_hsize=req.Hsize;
  l_hwrite=req.Hwrite;
  l_hlength=req.length;
  l_htrans=req.Htrans;
  l_hburst=req.Hburst;



if(req.Hburst==3'b100)
begin
  for(int i=0;i<7;i++)
   begin
    start_item(req);
    if(req.Hsize==3'b000)
     assert(req.randomize() with {Hsize==l_hsize;
                                 Hwrite==l_hwrite;
                                 Htrans==2'b11;
				  Hburst==l_hburst;
				Haddr=={l_haddr[31:2],l_haddr[1:0]+1'b01};});
    if(req.Hsize==3'b001)
     assert(req.randomize() with {Hsize==l_hsize;
                                 Hwrite==l_hwrite;
                                 Htrans==2'b11;
				  Hburst==l_hburst;
				Haddr=={l_haddr[31:3],l_haddr[2:1]+1'b1,l_haddr[0]};});
    if(req.Hsize==3'b010)
     assert(req.randomize() with {Hsize==l_hsize;
                                 Hwrite==l_hwrite;
                                 Htrans==2'b11;
				  Hburst==l_hburst;
				Haddr=={l_haddr[31:4],l_haddr[3:2]+1'b1,l_haddr[1:0]};});
    finish_item(req);

  l_haddr=req.Haddr;

end
   end
endtask
endclass


//WRAPPER-16 
class wrap16 extends ahb_sequence;

	 `uvm_object_utils(wrap16)

 bit[31:0] l_haddr;
 bit[1:0] l_hsize;
 bit l_hwrite;
 bit [9:0] l_hlength;
 bit[1:0] l_htrans;
 bit [2:0] l_hburst;


	 function new(string name="wrap16");
	   super.new(name);
	 endfunction

 task body;
	  req=ahb_xtns::type_id::create("req");
	  start_item(req);
	  assert(req.randomize() with {req.Htrans==2'b10;req.Hburst==3'b110;Hwrite inside {0,1};});
	  finish_item(req);

  l_haddr=req.Haddr;
  l_hsize=req.Hsize;
  l_hwrite=req.Hwrite;
  l_hlength=req.length;
  l_htrans=req.Htrans;
  l_hburst=req.Hburst;

if(req.Hburst==3'b110)
begin
  for(int i=0;i<15;i++)
   begin
    start_item(req);
    if(req.Hsize==3'b000)
     assert(req.randomize() with {Hsize==l_hsize;
                                 Hwrite==l_hwrite;
                                 Htrans==2'b11;
				 Hburst==l_hburst;
				 Haddr=={l_haddr[31:4],l_haddr[3:0]+1'b01};});
    if(req.Hsize==3'b001)
     assert(req.randomize() with {Hsize==l_hsize;
                                 Hwrite==l_hwrite;
                                 Htrans==2'b11;
				 Hburst==l_hburst;
				 Haddr=={l_haddr[31:5],l_haddr[4:0]+2'b10};});
    if(req.Hsize==3'b010)
     assert(req.randomize() with {Hsize==l_hsize;
                                 Hwrite==l_hwrite;
                                 Htrans==2'b11;
				 Hburst==l_hburst;
				 Haddr=={l_haddr[31:6],l_haddr[5:0]+4'b0100};});
    finish_item(req);

    l_haddr=req.Haddr;

   end
end

 endtask
endclass


class unspecified extends ahb_sequence;

	 `uvm_object_utils(unspecified)

	 function new(string name="unspecified");
		  super.new(name);
	 endfunction

 bit[31:0] l_haddr;
 bit[1:0] l_hsize;
 bit l_hwrite;
 bit[9:0] l_hlength;
 bit[1:0] l_htrans;
 bit [2:0] l_hburst;


 task body;
  begin
	  req=ahb_xtns::type_id::create("req");
	  start_item(req);
	  assert(req.randomize() with {req.Htrans==2'b10;req.Hburst==3'b000;Hwrite inside{0,1};});
       	  finish_item(req);

  l_haddr=req.Haddr;
  l_hsize=req.Hsize;
  l_hwrite=req.Hwrite;
  l_hlength=req.length;
  l_hburst=req.Hburst;
  l_htrans=req.Htrans;


   if(req.Hburst==3'b000)
      for(int i=0;i<l_hlength;i++)
       begin
       start_item(req);
       if(req.Hsize==3'b000)
          assert(req.randomize() with {req.Hsize==l_hsize;
                                 req.Hwrite==l_hwrite;
                                 req.Htrans==2'b11;
				  req.Hburst==l_hburst;
                                 req.Haddr==l_haddr+(2**l_hsize);});
       if(req.Hsize==3'b001)
          assert(req.randomize() with {req.Hsize==l_hsize;
                                 req.Hwrite==l_hwrite;
                                 req.Htrans==2'b11;
				  req.Hburst==l_hburst;
                                 req.Haddr==l_haddr+(2**l_hsize);});

        if(req.Hsize==3'b010)
          assert(req.randomize() with {req.Hsize==l_hsize;
                                 req.Hwrite==l_hwrite;
                                 req.Htrans==2'b11;
				  req.Hburst==l_hburst;
                                 req.Haddr==l_haddr+(2**l_hsize);});
      finish_item(req);
    l_haddr=req.Haddr;
   end
   end
   endtask
endclass


