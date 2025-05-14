//////////////////////////// question3/////////////////////////////////////////////////

 module TDM ( output reg [1:0] out,
              input [1:0] in0,in1,in2,in3,
            input clk,rst);
 reg [1:0] counter;
 always @(posedge clk , posedge rst) begin
     if (rst)
        counter <= 0;
     else 
        counter <= counter + 2'b01;
 end           
 always @(*) begin
    case (counter)
        2'b00  : out = in0; 
        2'b01  : out = in1;
        2'b10  : out = in2;
        2'b11  : out = in3;
        default: out = 0; 
    endcase
 end
    
 endmodule

 module TDM_ts ();
wire [1:0] out;
reg [1:0] in0,in1,in2,in3;
reg clk,rst;

TDM o (out,in0,in1,in2,in3,clk,rst);

initial begin
    clk = 0;
    forever #1 clk = ~clk;
end

initial begin
    rst = 1;
    repeat (10) begin
        in0 = $random;
        in1 = $random;
        in2 = $random;
        in3 = $random;
        @(negedge clk);
    end
    rst = 0;
    repeat (100) begin
        in0 = $random;
        in1 = $random;
        in2 = $random;
        in3 = $random;
        @(negedge clk);
    end 
    $stop;   
end

initial begin
    $monitor ("clk=%b rst=%b in0=%b in1=%b in2=%b in3=%b out=%b",clk,rst,in0,in1,in2,in3,out);
end
 endmodule

 */