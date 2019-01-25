module _4to1mux(Sum,Select,tempand,tempadd,tempor,tempxor);
input [1:0]Select;
input tempor,tempxor,tempand,tempadd;
output Sum;
wire temp1,temp2,temp3,temp4;
wire noselect0,noselect1;

not negatif(noselect0,Select[0]),
	 negatif1(noselect1,Select[1]);	

and	x1(temp1,noselect0,noselect1,tempand),
		x2(temp2,noselect1,Select[0],tempadd),
		x3(temp3,Select[1],noselect0,tempor),
		x4(temp4,Select[1],Select[0],tempxor);
		
		

or result(Sum,temp1,temp2,temp3,temp4);
	
endmodule