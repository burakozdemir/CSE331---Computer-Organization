module likeALU(out,inp_A,inp_B,select);
input [4:0]inp_A,inp_B;
input [1:0]select;
output [4:0]out;

_4_1_mux result(out,select,inp_A,inp_B);

endmodule