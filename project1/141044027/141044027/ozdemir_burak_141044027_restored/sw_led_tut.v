module sw_led_tut(led,input1,input2,select);
input [4:0]input1,input2;
input [1:0]select;
output [4:0]led;

likeALU as(out,input1,input2,select);
endmodule 