module _5bit_and(sum,A,B);
input [4:0]A,B; 
output [4:0]sum;

and 	x1(sum[0],A[0],B[0]),
		x2(sum[1],A[1],B[1]),
		x3(sum[2],A[2],B[2]),
		x4(sum[3],A[3],B[3]),
		x5(sum[4],A[4],B[4]);
endmodule
