`timescale 1ns / 1ns
`include "Excute.v"
module tb;
    parameter BITS = 32;
	reg  [2:0] Op;
	reg  [BITS-1:0] S1;
	reg  [BITS-1:0] S2;
	reg  [BITS-1:0] PC;
	wire [BITS-1:0] AluResult;
	wire [BITS:0]   BjBus;

Excute U (.Op       (Op),
	      .S1       (S1),
	      .S2       (S2),
	      .PC       (PC),
	      .AluResult(AluResult),
	      .BjBus    (BjBus)
	      );
initial begin
	
	PC = 32'h0000;
	Op = 3'b000;
	S1 = 32'h0002;
	S2 = 32'h0003;
	
end // initial

always #2 begin
	    Op = Op + 1;
        S1 = S1 + 1;
        S2 = S2 + 1;
	    PC = PC + 4;
end // always #2

initial #16 $finish;

 initial begin
 	$fsdbDumpfile("tb.fsdb");
 	$fsdbDumpvars();
 end // initial

endmodule

