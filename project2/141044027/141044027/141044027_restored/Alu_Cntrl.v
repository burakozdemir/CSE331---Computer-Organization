module Alu_Cntrl(inst,ALU_Cntrl_Sig);

input wire [5:0] inst;
output wire [3:0] ALU_Cntrl_Sig;

assign ALU_Cntrl_Sig = 
(inst == 6'b100000) ? 4'b1000:// add
(inst == 6'b100100) ? 4'b1100:// and
(inst == 6'b100001) ? 4'b0110:// addu 
(inst == 6'b100101) ? 4'b0100: //or
(inst == 6'b101011) ? 4'b1111://sltu 
(inst == 6'b000011) ? 4'b0010: //sra
(inst == 6'b000000) ? 4'b1011: //sll
(inst == 6'b000010) ? 4'b1010: //srl
(inst == 6'b100010) ? 4'b1001: 4'b1000; //sub aksi halde add yapacak
endmodule