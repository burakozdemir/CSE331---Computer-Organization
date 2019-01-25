module mips_core_testbench ();

reg [31:0] instruction_set;
wire [31:0]result;

mips_core core(instruction_set,result);


initial begin
instruction_set = 32'b00000000001000000101000000100000; #10;//add $t2 $at $zero
instruction_set = 32'b00000000001000000101000000100001; #10;//addu $t2 $at $zero
instruction_set = 32'b00000000001000000101000000100010; #10;//sub $t2 $at $zero
instruction_set = 32'b00000000001000000101000000100100; #10;//and $t2 $at $zero
instruction_set = 32'b00000000001000000101000000100101; #10;//or $t2 $at $zero
instruction_set = 32'b00000000001000000101000000000011; #10;//sra $t2 $zero 0x1 
instruction_set = 32'b00000000001000000101000000000010; #10;//srl $t2 $zero 0x1
instruction_set = 32'b00000000001000000101000000000000; #10;//sll $t2 $zero 0x1
instruction_set = 32'b00000000001000000101000000101011; #10;//SLTU $t2 $v0 $v0
//....continue for all instruction types.... must be least 9 control
end

initial begin
  $monitor("Test-Time:%2d, instruction : %32b ,Result: %32b",
            $time,instruction_set,result);
end


endmodule