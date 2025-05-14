module fifo # ( parameter FIFO_WIDTH = 16 ,
                parameter FIFO_DEPTH = 512)
              ( output reg full,empty,
                output reg [FIFO_WIDTH-1:0] dout_b,
                input [FIFO_WIDTH-1:0] din,
                input wen_a,ren_b,clk_a,clk_b,rst);
 reg [FIFO_WIDTH-1:0] mem [FIFO_DEPTH-1:0] ;
 reg [8:0] rd_ptr,wr_ptr,count;
 always @(posedge clk_a) begin
    if (rst) begin
        wr_ptr <= 0;
        full <= 0;
        count <= 0;
    end
    else begin
        if ((wen_a) && (!full)) begin
            mem[wr_ptr] <= din;
            wr_ptr <= wr_ptr + 1;
            count <= count + 1;
        end
    end
    if (count == (FIFO_DEPTH-1))
        full <= 1;
    else 
        full <= 0;    
 end 
  always @(posedge clk_b) begin
    if (rst) begin
        dout_b <= 0;
        rd_ptr <= 0;
        empty <= 0;
    end
    else begin
        if ((ren_b) && (!empty)) begin
            dout_b <= mem[rd_ptr];
            rd_ptr <= rd_ptr + 1;
            count <= count - 1;
        end
    end
    if (count == 0)
          empty <= 1;
    else 
          empty <= 0;    
 end             
endmodule

module  fifo_ts ();
parameter FIFO_WIDTH_ts = 16 ;
parameter FIFO_DEPTH_ts = 512;
wire full,empty;
wire [FIFO_WIDTH_ts-1:0] dout_b;
reg [FIFO_WIDTH_ts-1:0] din;
reg wen_a,ren_b,clk,rst;

fifo #(.FIFO_WIDTH(FIFO_WIDTH_ts),.FIFO_DEPTH(FIFO_DEPTH_ts)) p (full,empty,dout_b,din,wen_a,ren_b,clk,clk,rst);

initial begin
    clk = 0;
    forever begin
        #1 clk = ~clk;
    end
end 
initial begin
    rst = 1;
    @(negedge clk);
    rst = 0;
    wen_a = 1;
    ren_b = 0;
    repeat(10) begin
        din = $random;
        @(negedge clk);
    end
    wen_a = 0;
    ren_b = 1;
    repeat(10) begin
        din = $random;
        @(negedge clk);
    end 
    $stop;   
end
initial begin
    $monitor ("clk=%b rst=%b wen=%b ren=%b full=%b empty=%b din=%d dout=%d",clk,rst,wen_a,ren_b,full,empty,din,dout_b);

end

endmodule 