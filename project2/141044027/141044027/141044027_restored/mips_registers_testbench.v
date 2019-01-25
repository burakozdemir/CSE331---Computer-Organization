module mips_registers_testbench();

wire [31:0] read_data_1, read_data_2;
reg [31:0] write_data;
reg [4:0] read_reg_1, read_reg_2, write_reg;
reg signal_reg_write, clk;

mips_registers x(read_data_1,read_data_2,write_data,read_reg_1,read_reg_2,1,1);

initial begin
write_data = 5'b00001;
write_reg = 5'b00000;
read_reg_1 = 5'b00001;
read_reg_2 = 5'b00010; #10;	

end


initial begin
  $monitor("Test-Time:%2d,read_reg_1:%5b,read_reg_2:%5b ,read_data_1:%32b, read_data_2:%32b,",
            $time,read_reg_1,read_reg_2,read_data_1,read_data_2);
end

	
endmodule