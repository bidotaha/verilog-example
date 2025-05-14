///////////////////////////////// question2 ////////////////////////////

 module d_flipflop #(parameter N = 18 )
                    ( output reg [N-1:0] q,
                      input [N-1:0] d,
                      input clk,rstn);
  always @(posedge clk) begin
      if (!rstn)
         q <= 0;
      else 
         q <= d;   
  end    
 endmodule

 module add_sub #( parameter TYPE = "ADD", parameter M =19)
                 ( output reg [M-1:0] result,
                   input [M-1:0] a,b);
      always @(*) begin
         if (TYPE == "ADD")
            result = a+b;
         else if (TYPE == "SUB")
            result = a-b;
      end             
    
 endmodule

 module multi ( output [47:0] out,
                input [18:0] x,
                input [17:0] y);
   assign out = x*y;  
 endmodule 

 module circuit ( output [47:0] p,
                  input [17:0] a,b,d,
                  input [47:0] c,
                  input clk,rstn);
wire [17:0] d_f,b_f,a_f1,a_f2;
wire [47:0] c_f1,c_f2,c_f3;
wire [18:0] w1,w1_f;
wire [47:0] w2,w2_f,w3;

d_flipflop #(18) d1 (d_f,d,clk,rstn);
d_flipflop #(18) d2 (b_f,b,clk,rstn);
add_sub #(.M(19)) a1 (w1,{1'b0,d_f},{1'b0,b_f});
d_flipflop #(19) d6 (w1_f,w1,clk,rstn);
d_flipflop #(18) d3 (a_f1,a,clk,rstn);
d_flipflop #(18) d4 (a_f2,a_f1,clk,rstn);
multi b1 (w2,w1_f,a_f2);
d_flipflop #(48) d7 (w2_f,w2,clk,rstn);
d_flipflop #(48) d5 (c_f1,c,clk,rstn);
d_flipflop #(48) d9 (c_f2,c_f1,clk,rstn);
d_flipflop #(48) d10 (c_f3,c_f2,clk,rstn);
add_sub #(.M(48)) a2 (w3,w2_f,c_f3);
d_flipflop #(48) d8 (p,w3,clk,rstn);

 endmodule
/*
 module circuit_ts ();
 wire [47:0] p;
reg [17:0] a,b,d;
reg [47:0] c;
reg clk,rstn;

circuit r (p,a,b,d,c,clk,rstn);

initial begin
    clk = 0;
    forever #1 clk = ~clk;
end

initial begin
    rstn = 0;
    repeat (10) begin
        a = $urandom_range(0,7);
        b = $urandom_range(0,7);
        c = $urandom_range(0,7);
        d = $urandom_range(0,7);
        @(negedge clk);
    end
    rstn = 1;
    repeat (100) begin
        a = $urandom_range(0,7);
        b = $urandom_range(0,7);
        c = $urandom_range(0,7);
        d = $urandom_range(0,7);
        @(negedge clk);
end
$stop;
end
initial begin
    $monitor ("clk=%b rstn=%b d=%d b=%d a=%d c=%d p=%d",clk,rstn,d,b,a,c,p);
end
 endmodule
 */