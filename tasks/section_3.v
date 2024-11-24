module prob_Q1 ( output reg A,B,
                 input x,y,clk);
parameter s0=2'b00,s1=2'b01,s2=2'b10,s3=2'b11;
reg [1:0] current_state,next_state;
always @ (posedge clk)
begin
current_state <= next_state;
end
always @ (current_state,x,y)
begin
case (current_state)
s0 : if ({x,y} == 2'b00 || {x,y} == 2'b01) next_state = s0; else if ({x,y} == 2'b10) next_state = s3;
     else if ({x,y} == 2'b11) next_state = s1;
s1: if ({x,y} == 2'b00 || {x,y} == 2'b01) next_state = s0; else next_state = s2;
s2: if ({x,y} == 2'b00 || {x,y} == 2'b01) next_state = s0; else next_state = s1;
s3: if ({x,y} == 2'b00 || {x,y} == 2'b01) next_state = s0; else next_state = s3;
default : next_state = s0;
endcase
end
always @ (current_state)
begin
case(current_state)
s0 : {A,B} = 2'b00;
s1 : {A,B} = 2'b01;
s2 : {A,B} = 2'b10;
s3 : {A,B} = 2'b11;
endcase 
end 
endmodule 

`timescale 1ns/1ps

module prob_Q1_st ();
wire A,B;
reg x,y,clk;
prob_Q1 we(A,B,x,y,clk);
initial
begin
clk = 1;
forever #2 clk =~ clk;
end
initial
begin
$monitor ("A = %b , B = %b , x = %b , y = %b",A,B,x,y);
#4 {x,y} = 2'b00;
#4 {x,y} = 2'b01;
#4 {x,y} = 2'b10;
#4 {x,y} = 2'b10;
#4 {x,y} = 2'b11;
#4 {x,y} = 2'b00;
#4 {x,y} = 2'b11;
#4 {x,y} = 2'b11;
#4 {x,y} = 2'b00;
#4 {x,y} = 2'b11;
#4 {x,y} = 2'b10;
end
endmodule 

/////////////////////////////////////////////

module prob_3_36 ( output reg A,B,
                   input clk,reset);

parameter s0=2'b00,s1=2'b01,s2=2'b10,s3=2'b11;
reg [1:0] current_state,next_state;
always @ (posedge clk,negedge reset)
if (!reset)
current_state <= s3;
else
current_state <= next_state;
always @ (current_state)
case(current_state)
s0 : next_state = s1;
s1 : next_state = s2;
s2 : next_state = s0;
s3 : next_state = s0;
default : next_state = s0;
endcase  
always @ (current_state)
begin
case(current_state)
s0 : {A,B} = 2'b00;
s1 : {A,B} = 2'b01;
s2 : {A,B} = 2'b10;
s3 : {A,B} = 2'b11;
endcase 
end 
endmodule 

`timescale 1ns/1ps

module prob_3_36_ts ();
reg clk,reset;
wire A,B;
prob_3_36 m (A,B,clk,reset);
initial 
begin 
clk = 0; reset = 0;
$monitor (" AB %b%b",A,B);
repeat (20)
#2 clk = ~clk;  
end 
initial 
begin
#20 reset = ~reset;
end

endmodule

 ////////////////////////////////////////////////////

module prob_Q3 ( output reg A,B,
                 input x,clk,reset);
parameter s0=2'b00,s1=2'b01,s2=2'b10,s3=2'b11;
reg [1:0] current_state,next_state;
always @ (posedge clk,negedge reset)
if (~reset)
current_state <= s0;
else
current_state <= next_state;
always @ (current_state,x)
case(current_state)
s0 : if (x == 0) next_state = s0; else if (x == 1) next_state = s3; 
s1 : if (x == 0) next_state = s0; else if (x == 1) next_state = s2; 
s2 : if (x == 0) next_state = s2; else if (x == 1) next_state = s3; 
s3 : if (x == 0) next_state = s1; else if (x == 1) next_state = s1; 
default : next_state = s0;
endcase  
always @ (current_state)
begin
case(current_state)
s0 : {A,B} = 2'b00;
s1 : {A,B} = 2'b01;
s2 : {A,B} = 2'b10;
s3 : {A,B} = 2'b11;
endcase 
end 
endmodule 

`timescale 1ns/1ps

module prob_Q3_ts ();
reg clk,x,reset;
wire A,B;
prob_Q3 n (A,B,clk,x,reset);
initial
begin
$monitor (" AB %b%b",A,B);
reset = 1'b1;
#1 reset = 1'b0;
#3 reset = 1'b1;
end
initial   
begin
clk = 1'b1;
forever #2 clk =~clk;
end
initial
begin
x = 0;
forever #4 x =~x;
end 
endmodule   