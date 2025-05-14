  module d_flipflop_r ( output reg q,
                      input d,
                      input clk,rst);
  always @(posedge clk , posedge rst) begin
      if (rst)
         q <= 0;
      else 
         q <= d;   
  end    
 endmodule

  module d_flipflop_s ( output reg q,
                        input d,
                        input clk,set);
  always @(posedge clk , posedge set) begin
      if (set)
         q <= 1;
      else 
         q <= d;   
  end    
 endmodule
 
 module  LFSR ( output [3:0] out,
                input clk,rst,set);
  wire y1;

  d_flipflop_s d1 (out[0],out[3],clk,set); 
  xor (y1,out[0],out[3]); 
  d_flipflop_r d2 (out[1],y1,clk,rst);
  d_flipflop_r d3 (out[2],out[1],clk,rst);
  d_flipflop_r d4 (out[3],out[2],clk,rst);

 endmodule

 module LFSR_ts ();
    wire [3:0] out;
    reg clk,rst,set;

    LFSR o (out,clk,rst,set);

    initial begin
        clk = 0;
        forever begin
            #1 clk = ~clk;
        end
    end

    initial begin
        rst = 1;
        set = 1;
        repeat(10) @(negedge clk);
        rst = 0;
        set = 0;
        repeat(10) @(negedge clk);
        $stop;
    end
    initial begin
        $monitor("clk=%b rst=%b set=%b out: %b",clk,rst,set,out);
    end
 endmodule