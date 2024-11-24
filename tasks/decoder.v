module decoder_2x4 ( output [3:0] d,
                     input A,B,E);

wire An,Bn;

not (An,A);
not (Bn,B);
and (d[0],An,Bn,E);
and (d[1],An,B,E);
and (d[2],A,Bn,E);
and (d[3],A,B,E);

endmodule 


module decoder_3x8 ( output [7:0] d,
                     input x,y,z,E);

wire xn,yn,zn;

not (xn,x);
not (yn,y);
not (zn,z);

and (d[0],zn,yn,xn,E);
and (d[1],z,yn,xn,E);
and (d[2],zn,y,xn,E);
and (d[3],z,y,xn,E);
and (d[4],zn,yn,x,E);
and (d[5],z,yn,x,E);
and (d[6],zn,y,x,E);
and (d[7],z,y,x,E);

endmodule 


module decoder_5x32 ( output [31:0] D,
                      input [4:0] A,
                      input E);
wire [3:0] c;

decoder_2x4 m(c[3:0],A[4],A[3],E);
decoder_3x8 w1(D[7:0],A[2],A[1],A[0],c[0]);
decoder_3x8 w2(D[15:8],A[2],A[1],A[0],c[1]);
decoder_3x8 w3(D[23:16],A[2],A[1],A[0],c[2]);
decoder_3x8 w4(D[31:24],A[2],A[1],A[0],c[3]);

endmodule 
 
`timescale 1ns/1ps

module decoder_5x32_ts();

reg [4:0] A;
reg E;
wire [31:0] D2;
integer i = 0;  

decoder_5x32 c(D2,A,E);

initial
begin

E = 1'b0;
A = 5'b0;

$monitor ("in : %d E : %b out : %b",A,E,D2); 

#10 E = 1'b1;
for (i = 1 ; i <= 32 ; i = i + 1)
#10 A = A + 1;
end

endmodule  


module decoder_2x4_22 ( output [3:0] d,
                     input A,B,E);

assign d[0] = E & (~A) & (~B);
assign d[1] = E & (~A) & (B);
assign d[2] = E & (A) & (~B);
assign d[3] = E & (A) & (B);

endmodule 


module decoder_3x8_22 ( output [7:0] d,
                     input x,y,z,E);

assign d[0] = E & (~z) & (~y) & (~x);
assign d[1] = E & (z) & (~y) & (~x);
assign d[2] = E & (~z) & (y) & (~x);
assign d[3] = E & (z) & (y) & (~x);
assign d[4] = E & (~z) & (~y) & (x);
assign d[5] = E & (z) & (~y) & (x);
assign d[6] = E & (~z) & (y) & (x);
assign d[7] = E & (z) & (y) & (x);

endmodule 


module decoder_5x32_22 ( output [31:0] D,
                      input [4:0] A,
                      input E);
wire [3:0] c;

decoder_2x4_22 m(c[3:0],A[4],A[3],E);
decoder_3x8_22 w1(D[7:0],A[2],A[1],A[0],c[0]);
decoder_3x8_22 w2(D[15:8],A[2],A[1],A[0],c[1]);
decoder_3x8_22 w3(D[23:16],A[2],A[1],A[0],c[2]);
decoder_3x8_22 w4(D[31:24],A[2],A[1],A[0],c[3]);

endmodule 
 
`timescale 1ns/1ps

module decoder_5x32_22_ts();

reg [4:0] A;
reg E;
wire [31:0] D2;
integer i = 0;  

decoder_5x32_22 c(D2,A,E);

initial
begin

E = 1'b0;
A = 5'b0;

$monitor ("in : %d E : %b out : %b",A,E,D2); 

#10 E = 1'b1;
for (i = 1 ; i <= 32 ; i = i + 1)
#10 A = A + 1;
end

endmodule 