module ALU(ALUcontrol,A,B,ALUout,zero);

input [3:0] ALUcontrol;
input [31:0] A,B;
output [31:0] ALUout;
output zero;
wire unsigned [31:0]temp;

assign zero = ((ALUcontrol == 4'b1111) && (A < B)) ? 1'b1 : 1'b0;
assign temp = (ALUcontrol == 4'b0110) ? A + B : 1'd0 ; //unsigned add icin 
assign ALUout = 
(ALUcontrol == 4'b1000) ? A + B :
(ALUcontrol == 4'b1100) ? A & B :
(ALUcontrol == 4'b1001) ? A - B :
(ALUcontrol == 4'b0100) ? A | B :
(ALUcontrol == 4'b1011) ? B << 1:
(ALUcontrol == 4'b1010) ? B >> 1: 
(ALUcontrol == 4'b0010) ? B >>> 1: temp;
  
  
endmodule