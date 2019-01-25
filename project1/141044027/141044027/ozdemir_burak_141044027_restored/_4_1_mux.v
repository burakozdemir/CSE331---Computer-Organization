module _4_1_mux(Sum,Select,A,B);
input [4:0]A;
input [4:0]B;
input [1:0]Select;
output [4:0]Sum;
//////////
wire [4:0]tempand,tempor,tempxor,tempadd;

_5bit_and myand(tempand,A,B);
_5bit_or myor(tempor,A,B);
_5bit_xor myxor(tempxor,A,B);
_5bit_adder myadder(tempadd,C,A,B,0);

_4to1mux a1(Sum[0],Select,tempand[0],tempadd[0],tempor[0],tempxor[0]),
			a2(Sum[1],Select,tempand[1],tempadd[1],tempor[1],tempxor[1]),
			a3(Sum[2],Select,tempand[2],tempadd[2],tempor[2],tempxor[2]),
			a4(Sum[3],Select,tempand[3],tempadd[3],tempor[3],tempxor[3]),
			a5(Sum[4],Select,tempand[4],tempadd[4],tempor[4],tempxor[4]);
		
endmodule