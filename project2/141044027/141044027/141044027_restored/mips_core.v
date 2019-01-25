module mips_core(instruction, result);

input [31:0] instruction;
output [31:0] result;


wire [31:0] read_data_1;
wire [31:0] read_data_1temp;
wire [31:0] read_data_2;
wire [31:0] read_data_2temp;
wire [31:0] write_data;


wire [3:0] AluControlSignals;
wire [31:0] AluOut;
wire [31:0] tempAluOut;
wire Zero;

//registere veri alma
mips_registers registers(read_data_1, read_data_2,write_data,instruction[25:21], instruction[20:16], 
								instruction[15:11],1'b0,1'b1);

//ALUcntrol
Alu_Cntrl alucntrl(instruction[5:0],AluControlSignals);

//ALU
ALU hesap(AluControlSignals,read_data_1,read_data_2,AluOut,Zero);

newassign a(read_data_1temp,read_data_2temp,tempAluOut,read_data_1,read_data_2,AluOut,Zero);

//write register
mips_registers registers2(read_data_1temp, read_data_2temp,tempAluOut,instruction[25:21], instruction[20:16], 
								instruction[15:11],1'b1,1'b1);

								
assign result = AluOut ;
								
endmodule