/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

// ============================================================
// Firmware Signature Verification Accelerator
// Tiny Tapeout Example Project
// ============================================================

module tt_um_firmware_signature_verify (
    input  wire [7:0] ui_in,     // Dedicated inputs
    output wire [7:0] uo_out,    // Dedicated outputs
    input  wire [7:0] uio_in,    // IO inputs
    output wire [7:0] uio_out,   // IO outputs
    output wire [7:0] uio_oe,    // IO output enable
    input  wire       ena,       // always enabled
    input  wire       clk,       // clock
    input  wire       rst_n      // active low reset
);

    // ========================================================
    // Inputs
    // ========================================================
    wire [7:0] firmware_data;
    wire [7:0] signature_data;

    assign firmware_data = ui_in;
    assign signature_data = uio_in;

    // ========================================================
    // Internal Registers
    // ========================================================
    reg [15:0] hash_value;
    reg [15:0] signature_calc;
    reg        verify_ok;

    // ========================================================
    // Simple Hash Engine
    // ========================================================
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            hash_value     <= 16'd0;
            signature_calc <= 16'd0;
            verify_ok      <= 1'b0;
        end else begin

            // Simple firmware hash generation
            hash_value <= hash_value + firmware_data + 16'h00A5;

            // Simple signature verification logic
            signature_calc <= signature_calc ^ {8'h00, signature_data};

            // Compare hash and signature
            if (hash_value[7:0] == signature_calc[7:0])
                verify_ok <= 1'b1;
            else
                verify_ok <= 1'b0;
        end
    end

    // ========================================================
    // Outputs
    // ========================================================

    // uo_out[0] = verification result
    // uo_out[7:1] = partial hash output

    assign uo_out[0]   = verify_ok;
    assign uo_out[7:1] = hash_value[6:0];

    // No bidirectional outputs used
    assign uio_out = 8'b00000000;
    assign uio_oe  = 8'b00000000;

    // ========================================================
    // Prevent unused warnings
    // ========================================================
    wire _unused = &{ena, 1'b0};

endmodule
