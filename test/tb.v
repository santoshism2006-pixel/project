`default_nettype none
`timescale 1ns / 1ps

// ============================================================
// Testbench for Firmware Signature Verification Accelerator
// ============================================================

module tb ();

  // ----------------------------------------------------------
  // Dump waveform
  // ----------------------------------------------------------
  initial begin
    $dumpfile("tb.fst");
    $dumpvars(0, tb);
    #1;
  end

  // ----------------------------------------------------------
  // Inputs
  // ----------------------------------------------------------
  reg clk;
  reg rst_n;
  reg ena;

  reg [7:0] ui_in;
  reg [7:0] uio_in;

  // ----------------------------------------------------------
  // Outputs
  // ----------------------------------------------------------
  wire [7:0] uo_out;
  wire [7:0] uio_out;
  wire [7:0] uio_oe;

`ifdef GL_TEST
  wire VPWR = 1'b1;
  wire VGND = 1'b0;
`endif

  // ----------------------------------------------------------
  // DUT Instantiation
  // ----------------------------------------------------------

  // IMPORTANT:
  // Replace module name exactly with your project module name

  tt_um_firmware_signature_verify user_project (

`ifdef GL_TEST
      .VPWR(VPWR),
      .VGND(VGND),
`endif

      .ui_in   (ui_in),
      .uo_out  (uo_out),

      .uio_in  (uio_in),
      .uio_out (uio_out),
      .uio_oe  (uio_oe),

      .ena     (ena),
      .clk     (clk),
      .rst_n   (rst_n)
  );

  // ----------------------------------------------------------
  // Clock Generation
  // ----------------------------------------------------------
  initial begin
    clk = 0;
    forever #5 clk = ~clk;   // 10ns clock period
  end

  // ----------------------------------------------------------
  // Test Sequence
  // ----------------------------------------------------------
  initial begin

    // Initialize signals
    ena    = 1'b1;
    rst_n  = 1'b0;

    ui_in  = 8'h00;
    uio_in = 8'h00;

    // Hold reset
    #20;
    rst_n = 1'b1;

    // ------------------------------------------------------
    // Test Case 1
    // ------------------------------------------------------
    #10;
    ui_in  = 8'h12;
    uio_in = 8'h12;

    // ------------------------------------------------------
    // Test Case 2
    // ------------------------------------------------------
    #10;
    ui_in  = 8'h34;
    uio_in = 8'h56;

    // ------------------------------------------------------
    // Test Case 3
    // ------------------------------------------------------
    #10;
    ui_in  = 8'hAA;
    uio_in = 8'hAA;

    // ------------------------------------------------------
    // Test Case 4
    // ------------------------------------------------------
    #10;
    ui_in  = 8'hFF;
    uio_in = 8'h0F;

    // Wait and finish
    #50;

    $finish;
  end

endmodule
