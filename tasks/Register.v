module D_flip_flop (
    output reg Q, 
    input D, 
    input CLK);

always @(posedge CLK)
   Q<=D;
endmodule

module Register_1 (
     output A,
     input load,clear,I,clk);

wire notload1,notload2,notclear,C0,C1,C2;

not n0(notload1,load);
not n1(notload2,notload1);
not n2(notclear,clear);
and n3(C0,A,notload1,notclear);
and n4(C1,I,notload2,notclear);
or n5(C2,C0,C1);

D_flip_flop w (A,C2,clk);

endmodule 


module Register_4 ( 
   output [3:0] A,
   input [3:0] I,
   input load,clk,clear);

Register_1 W0 (A[0],load,clear,I[0],clk);
Register_1 W1 (A[1],load,clear,I[1],clk);
Register_1 W2 (A[2],load,clear,I[2],clk);
Register_1 W3 (A[3],load,clear,I[3],clk);

endmodule 

`timescale 1ns/1ps
module Register_4_ts ();

wire [3:0] A;
reg [3:0] I;
reg load,clk,clear;

Register_4 W4 (A,I,load,clk,clear);

initial
begin
clk = 0;
forever
#5 clk = ~clk;
end
initial
begin
#10 clear=0;
#10 load=1;
#10 I=4'b0101;
#10 load=0;
#10 I=4'b1001;
#10 load=1;
#10 I=4'b1001;
#10 clear=1;
end
endmodule  


module Register_4_bh ( output reg D,
                       input load,clr,clk,I);

always @ (posedge clk) 
begin
if ( load ==1 && clr==0)
D = I;
else if ( clr == 1)
D = 0;

end
endmodule  


`timescale 1ns/1ps
module Register_4_ts_2 ();

wire [3:0] A;
reg [3:0] I;
reg load,clk,clear;

Register_4_bh W5 (A,I,load,clk,clear);

initial
begin
clk = 0;
forever
#5 clk = ~clk;
end
initial
begin
#10
I = 4'b1011;
clear = 1'b0;
load = 1'b0;
#20
clear = 1'b0;
load = 1'b1;
#20
clear = 1'b1;
load = 1'b0;
#20
clear = 1'b1;
load = 1'b1;
end
endmodule






