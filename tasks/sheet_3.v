module prob_4_44 ( output reg [15:0] Y, 
                   input[15:0] A,B, 
                   input[2 :0] Sel);
always@(*)
case( Sel) 3'd0: Y <= 16'b0 ;
3'd1: Y <= A & B ;
3'd2: Y <= A | B ;
3'd3: Y <= A ^ B ;
3'd4: Y <= ~ A ;
3'd5: Y <= A - B ;
3'd6: Y <= A + B ;
3'd7: Y <= 16'hff ;
endcase
endmodule

////////////////////////////////

module prob_4_48 ( output reg [15:0] Y, 
                   input[15:0] A,B, 
                   input[2 :0] Sel);
always@(*)
case( Sel) 3'd0: Y <= 16'b0 ;
3'd1: Y <= A & B ;
3'd2: Y <= A | B ;
3'd3: Y <= A ^ B ;
3'd4: Y <= ~ A ;
3'd5: Y <= A - B ;
3'd6: Y <= A + B ;
3'd7: Y <= 16'hff ;
endcase
endmodule 

module prob_4_48_ts();
wire [15:0] Y ;
reg [15:0] A,B; reg [2 :0] Sel;
reg en; 
prob_4_48 M(Y, A, B, Sel); 
initial
begin
A=0; B=0; Sel=0; en=0;
#100 A=16'd20; B=16'd10; en=1;
end
always
#100 Sel=Sel+1;
always
#300 en=~en;
endmodule 

/////////////////////////////////

module prob_4_51 ( output reg [6:0] Y,
                   input [3:0]BCD ); 
always@(*) 
case ( BCD)
0: Y=7'b1111110; 
1: Y=7'b0110000;
2: Y=7'b1101101;
3: Y=7'b1111001;
4: Y=7'b0110011;
5: Y=7'b1011011;
6: Y=7'b1011111;
7: Y=7'b1110000;
8: Y=7'b1111111;
9: Y=7'b1111011;
endcase
endmodule 

module prob_4_51_ts ();
wire [6:0] Y;
reg [0:3]BCD;
prob_4_51 M2(Y ,BCD); 
initial
begin
 BCD=0;
repeat (10) #100 BCD=BCD+1; 
end
endmodule 

/////////////////////////////////////

module prob_4_52_a ( output [3:0]Sum, 
                     output Carry,
                     input [3:0]A );
assign {Carry, Sum} = A+1;
endmodule

module prob_4_52_a_ts();
wire [3:0]Sum;
wire Carry;
reg [3:0] A; 
prob_4_52_a M3(Sum, Carry, A); 
initial
begin
A=4'b0000;
#100 A=4'b0001;
#100 A=4'b0010;
end
endmodule 

///////////////////////////////

module prob_4_52_b ( output [3:0]Sum,
                     output Carry,
                     input [3:0]A );
assign {Carry, Sum} = A-1;
endmodule

module prob_4_52_b_ts();
wire [3:0]Sum;
wire Carry;
reg [3:0] A; 
prob_4_52_b M4(Sum, Carry, A); 
initial
begin
A=4'b0000;
#100 A=4'b0001;
#100 A=4'b0010;
end
endmodule 

//////////////////////////////

module prob_53 ( output [3:0] Sum, 
                 output Output_carry,
                 input [3:0] A,B,
                 input Carry_in);
wire [3:0] Z, Addend_i;
wire and_1, and_2, K;
assign {K, Z}=A + B + Carry_in;
assign and_1 = Z[3] & Z[2];
assign and_2 = Z[3] & Z[1];
assign Output_carry=and_2 | and_1 | K;
assign Addend_i ={1'b0, Output_carry, Output_carry,1'b0};
assign Sum = Addend_i + Z; 
endmodule 
/////////////////////////////