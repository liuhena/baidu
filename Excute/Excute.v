module Excute 
	#(parameter BITS = 32
		)(
		  input  [2:0] Op,
		  input  [BITS-1:0] S1,
		  input  [BITS-1:0] S2,
		  input  [BITS-1:0] PC,
		  output [BITS-1:0] AluResult,
		  output [BITS:0]   BjBus
		  );
      		reg [BITS-1:0] AluResult;
	  	wire [BITS:0] BjBus;
        reg [BITS-1:0] BjAddr;
        wire  BjEn;

always @(Op or S1 or S2 or PC) begin
	case (Op)
		3'b001:  begin AluResult = S1 + S2; BjAddr = 0; end 
		3'b010:  begin BjAddr = (S1 < S2) ? PC + S1 : PC; AluResult = BjAddr; end // 3'b010:
		3'b011:  begin BjAddr = S1 +PC; AluResult = PC + 4; end // 3'b011:
		3'b100:  begin AluResult = (S1 << S2); BjAddr = 0; end
        3'b101:  begin AluResult = S1 & S2; BjAddr = 0; end
        default: begin AluResult = 0; BjAddr = 0; end
    endcase
end

assign BjEn  = (Op[2:1] == 01) ? 1 : 0;
assign BjBus = (Op[2:1] == 01) ? {BjEn,BjAddr} : 0; 

endmodule // Excute

