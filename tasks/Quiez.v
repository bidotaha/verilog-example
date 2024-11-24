module Quiz_1 ( output reg z0,z1,
                 input x,clk);
parameter s0=2'b00,s1=2'b01,s2=2'b10,s3=2'b11;
reg [1:0] current_state,next_state;
always @ (posedge clk)
begin
current_state <= next_state;
end
always @ (current_state,x)
begin
case (current_state)
s0 : if (x == 0) next_state = s0; else if (x == 1) next_state = s1; 
s1 : if (x == 0) next_state = s1; else if (x == 1) next_state = s2; 
s2 : if (x == 0) next_state = s2; else if (x == 1) next_state = s3; 
s3 : if (x == 0) next_state = s3; else if (x == 1) next_state = s0; 
default : next_state = s0;
endcase
end
always @ (current_state)
begin
case(current_state)
s0 : {z0,z1} = 2'b00;
s1 : {z0,z1} = 2'b01;
s2 : {z0,z1} = 2'b10;
s3 : {z0,z1} = 2'b11;
endcase 
end 
endmodule 

`timescale 1ns/1ps

module Quiz_1_ts ();
reg clk,x;
wire z0,z1;
Quiz_1 mn (z0,z1,x,clk);
initial
begin
$monitor (" z0 z1 %b%b",z0,z1);
clk = 1'b1;
forever #2 clk =~clk;
end
initial
begin
x = 0;
forever #4 x =~x;
end 
endmodule 