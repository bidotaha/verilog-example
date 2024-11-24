/// problem_4_37
module half_adder ( output s,c,
                    input x,y);
xor (s,x,y);
and (c,x,y);

endmodule 


module full_adder ( output s,c,
                    input x,y,z);

wire s1,c1,c2;
half_adder ha1 (s1,c1,x,y);
half_adder ha2 (s,c2,s1,z); 
or g1(c,c2,c1);

endmodule 

module ripple_carry_4_bit_adder ( output [3:0] sum , output c4,
                                  input [3:0] A,B , input c0);

wire c1,c2,c3;
full_adder fa0 (sum[0],c1,A[0],B[0],co),
           fa1 (sum[1],c2,A[1],B[1],c1),
           fa2 (sum[2],c3,A[2],B[2],c2),
           fa3 (sum[3],c4,A[3],B[3],c3);

endmodule 

module add_sub_4_bit ( output [3:0] s, output c4,
                       input [3:0] A,B, input M);

wire c1,c2,c3;
wire [3:0] B_xor;

xor (B_xor[0],B[0],M);
xor (B_xor[1],B[1],M);
xor (B_xor[2],B[2],M);
xor (B_xor[3],B[3],M);

ripple_carry_4_bit_adder r1 (s,c4,A,B_xor,M);

endmodule 

//// problem_4_38
module quad_2x1_mux( output [3:0] y,
                     input [3:0] a,b,
                     input e,s);
assign y = e ? 0 : (s ? b : a);

endmodule 

/////// problem_4_40
module adder_sub_4_bit ( output [3:0] s,
                         output c,
                         input [3:0] a,b,
                         input m);
assign {c,s} = m ? (a - b) : (a + b);

endmodule 

module problem_4_41 ( output reg [3:0] s,
                      output reg c,
                      input [3:0] a,b,
                      input m);
always @ (a,b,m)
case (m)
0 : {c,s} = a + b;
1 : {c,s} = a - b;
endcase

endmodule 













