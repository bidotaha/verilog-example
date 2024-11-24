module D_FF (input wire load,clear,i,clk
            ,output reg A);
wire load1,load2,c1,x1,x2,d;
not n1(load1,load);
not n2(load2,load1);
not n3(c1,clear);
and n4(x1,A,load1,c1);
and n5(x2,i,c1,load2);
or  n6(d,x1,x2);
always @ (posedge clk)
 A<=d;      
endmodule 

module fourbit_D_FF(input load,clear,clk
                   ,input [3:0]i  
                  ,output [3:0]a);
D_FF u1(load,clear,i[0],clk,a[0]);
D_FF u2(load,clear,i[1],clk,a[1]);
D_FF u3(load,clear,i[2],clk,a[2]);
D_FF u4(load,clear,i[3],clk,a[3]);
endmodule 
`timescale 1ns/1ps
module fourbit_D_FF_tb();
reg load,clear,clk;
reg [3:0]i;
wire [3:0]a; 
 fourbit_D_FF u5(load,clear,clk,i,a);
initial 
begin
clk=0;
forever
#5 clk=~clk;
end
initial 
begin
#10 clear=0;
#10 load=1;
#10 i=4'b0101;
#10 load=0;
#10 i=4'b1001;
#10 load=1;
#10 i=4'b1001;
#10 clear=1;

end
endmodule
