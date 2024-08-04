class scoreboard extends uvm_scoreboard;

  `uvm_component_utils(scoreboard)

  uvm_tlm_analysis_fifo #(ahb_xtns) fifo_ahb[];
  uvm_tlm_analysis_fifo #(apb_xtns) fifo_apb[];

  ahb_xtns H_xtns, H2_xtns;
  apb_xtns P_xtns, P2_xtns;

  static int data_from_ahb_received;
  static int data_from_apb_monitor;
  int data_verified;
  int data_mismatched;

  env_config env_cfg_h;

  function new(string name="scoreboard", uvm_component parent);
    super.new(name, parent);
    coverage_ahb = new();
    coverage_apb = new();
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (!uvm_config_db #(env_config)::get(this, "", "env_config", env_cfg_h))
      `uvm_fatal("getting failed in scoreboard", "failed")

    fifo_ahb = new[env_cfg_h.no_of_ahb_agents];
    fifo_apb = new[env_cfg_h.no_of_apb_agents];

    foreach (fifo_ahb[i])
      fifo_ahb[i] = new($sformatf("fifo_ahb[%0d]", i), this);
    foreach (fifo_apb[i])
      fifo_apb[i] = new($sformatf("fifo_apb[%0d]", i), this);
  endfunction

  covergroup coverage_ahb;

    ADDR_ahb: coverpoint H2_xtns.Haddr {
      bins first_slave = {[32'h8000_0000:32'h8000_03ff]};
      bins second_slave = {[32'h8400_0000:32'h8400_03ff]};
      bins third_slave = {[32'h8800_0000:32'h8800_03ff]};
      bins fourth_slave = {[32'h8C00_0000:32'h8C00_03ff]};
    }

    HSIZE: coverpoint H2_xtns.Hsize {
      bins one = {0};
      bins two = {1};
    }

    HTRANS: coverpoint H2_xtns.Htrans {
      bins Non_seq = {2'b10};
      bins Seq = {2'b11};
    }

    AHB_DATA_OUT: coverpoint H2_xtns.Hrdata {
      bins low = {[32'h0000:32'h0000_ffff]};
      bins High = {[32'h0001:32'hffff_ffff]};
    }

    AHB_DATA_IN: coverpoint H2_xtns.Hwdata {
      bins low = {[32'h0000:32'h0000_ffff]};
      bins High = {[32'h0001:32'hffff_ffff]};
    }

    HWRITE: coverpoint H2_xtns.Hwrite;

  endgroup

  covergroup coverage_apb;

    ADDR_apb: coverpoint P2_xtns.Paddr {
      bins first_slave = {[32'h8000_0000:32'h8000_03ff]};
      bins second_slave = {[32'h8400_0000:32'h8400_03ff]};
      bins third_slave = {[32'h8800_0000:32'h8800_03ff]};
      bins fourth_slave = {[32'h8C00_0000:32'h8C00_03ff]};
    }

    APB_DATA_OUT: coverpoint P2_xtns.Prdata {
      bins low = {[32'h0000:32'h0000_ffff]};
      bins High = {[32'h0001:32'hffff_ffff]};
    }

    APB_DATA_IN: coverpoint P2_xtns.Pwdata {
      bins low = {[32'h0000:32'h0000_ffff]};
      bins High = {[32'h0001:32'hffff_ffff]};
    }

    PWRITE: coverpoint P2_xtns.Pwrite;

  endgroup

  task run_phase(uvm_phase phase);
    forever begin
      // Get AHB transaction
      fifo_ahb[0].get(H_xtns);
      data_from_ahb_received++;
      H2_xtns = H_xtns;

      // Get APB transaction
      fifo_apb[0].get(P_xtns);
      data_from_apb_monitor++;
      P2_xtns = P_xtns;

      // Perform data verification
      check_data(H2_xtns, P_xtns);

      // Sample covergroups
      coverage_ahb.sample();
      coverage_apb.sample();
    end
  endtask

  task check_data(ahb_xtns H_xtns, apb_xtns P_xtns);
    if (H_xtns.Hwrite == 1) begin
      if (H_xtns.Hsize == 2'b00) begin
        if (H_xtns.Haddr[1:0] == 2'b00) begin
          user_compare(H_xtns.Haddr, P_xtns.Paddr, H_xtns.Hwdata[7:0], P_xtns.Pwdata[7:0]);
          $display("in check_data");
        end
        if (H_xtns.Haddr[1:0] == 2'b01)
          user_compare(H_xtns.Haddr, P_xtns.Paddr, H_xtns.Hwdata[15:8], P_xtns.Pwdata[7:0]);
        if (H_xtns.Haddr[1:0] == 2'b10)
          user_compare(H_xtns.Haddr, P_xtns.Paddr, H_xtns.Hwdata[23:16], P_xtns.Pwdata[7:0]);
        if (H_xtns.Haddr[1:0] == 2'b11)
          user_compare(H_xtns.Haddr, P_xtns.Paddr, H_xtns.Hwdata[31:24], P_xtns.Pwdata[7:0]);
      end else if (H_xtns.Hsize == 2'b01) begin
        if (H_xtns.Haddr[1:0] == 2'b00)
          user_compare(H_xtns.Haddr, P_xtns.Paddr, H_xtns.Hwdata[15:0], P_xtns.Pwdata[15:0]);
        if (H_xtns.Haddr[1:0] == 2'b10)
          user_compare(H_xtns.Haddr, P_xtns.Paddr, H_xtns.Hwdata[31:16], P_xtns.Pwdata[15:0]);
      end else if (H_xtns.Hsize == 2'b10) begin
        user_compare(H_xtns.Haddr, P_xtns.Paddr, H_xtns.Hwdata[31:0], P_xtns.Pwdata[31:0]);
      end
    end


  //READ OPERATION CHECKING
    else
    begin
      if (H_xtns.Hsize == 2'b00) 
      begin
        if (H_xtns.Haddr[1:0] == 2'b00)
          user_compare_read(H_xtns.Haddr, P_xtns.Paddr, H_xtns.Hwdata[7:0], P_xtns.Prdata[7:0]);
        if (H_xtns.Haddr[1:0] == 2'b01)
          user_compare_read(H_xtns.Haddr, P_xtns.Paddr, H_xtns.Hrdata[7:0], P_xtns.Prdata[15:8]);
        if (H_xtns.Haddr[1:0] == 2'b10)
          user_compare_read(H_xtns.Haddr, P_xtns.Paddr, H_xtns.Hrdata[7:0], P_xtns.Prdata[23:16]);
        if (H_xtns.Haddr[1:0] == 2'b11)
          user_compare_read(H_xtns.Haddr, P_xtns.Paddr, H_xtns.Hrdata[7:0], P_xtns.Prdata[31:24]);
          end 
      else if (H_xtns.Hsize == 2'b01) 
          begin
        if (H_xtns.Haddr[1:0] == 2'b00)
          user_compare_read(H_xtns.Haddr, P_xtns.Paddr, H_xtns.Hrdata[15:0], P_xtns.Prdata[15:0]);
        if (H_xtns.Haddr[1:0] == 2'b10)
          user_compare_read(H_xtns.Haddr, P_xtns.Paddr, H_xtns.Hrdata[15:0], P_xtns.Prdata[31:16]);
          end 
      else if (H_xtns.Hsize == 2'b10) begin
        user_compare_read(H_xtns.Haddr, P_xtns.Paddr, H_xtns.Hrdata[31:0], P_xtns.Prdata[31:0]);
      end
    end

  endtask

  task user_compare(int Haddr, int Paddr, int Hwdata, int Pwdata);
    if (Haddr == Paddr) begin
      `uvm_info(get_type_name(), "Haddr and Paddr matched", UVM_LOW)
      if (Hwdata == Pwdata) begin
        `uvm_info(get_type_name(), "Hwdata and Pwdata matched", UVM_LOW)
        data_verified++;
      end
    end else begin
      `uvm_error(get_type_name(), "DATA NOT MATCHED")
      data_mismatched++;
    end
  endtask


//READ DATA VERIFICATION

task user_compare_read(int Haddr, int Paddr, int Hrdata, int Prdata);
    if (Haddr == Paddr) begin
      `uvm_info(get_type_name(), "Haddr and Paddr matched", UVM_LOW)
      if (Hrdata == Prdata) begin
        `uvm_info(get_type_name(), "Hrdata and Prdata matched", UVM_LOW)
        data_verified++;
      end
    end else begin
      `uvm_error(get_type_name(), "DATA NOT MATCHED")
      data_mismatched++;
    end
  endtask

  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    $display("data_from_ahb_received=%0d data_from_apb_monitor=%0d data_mismatched=%0d data_verified=%0d",
             data_from_ahb_received, data_from_apb_monitor, data_mismatched, data_verified);
  endfunction

endclass
