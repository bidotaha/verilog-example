module ram #( parameter MEM_WIDTH = 16,
              parameter MEM_DEPTH = 1024,
              parameter ADDR_SIZE = 10,
              parameter ADDR_PIPELINE = "FALSE",
              parameter DOUT_PIPELINE = "TRUE",
              parameter PARITY_ENABLE = 1)
             ( output reg [MEM_WIDTH-1:0] dout,
               output reg parity_out,
               input [MEM_WIDTH-1:0] din,
               input [ADDR_SIZE-1:0] addr,
               input wr_en,rd_en,blk_select,addr_en,dout_en,clk,rst);
  reg [MEM_WIDTH-1:0] mem [MEM_DEPTH-1:0] ;
  reg [ADDR_SIZE-1:0] addr_reg;
  reg [MEM_WIDTH-1:0] dout_reg;
  always @(posedge clk) begin
    if (rst)
       dout_reg <= 0;
    else if (addr_en && (ADDR_PIPELINE == "TRUE"))
       addr_reg <= addr;   
  end             
  always @(posedge clk) begin
    if (rst)
       dout_reg <= 0;
    else if (wr_en && blk_select)
       mem[addr] <= din;
    else if (rd_en && blk_select)
       dout_reg <= mem[(ADDR_PIPELINE=="TRUE") ? addr_reg : addr];   
  end      
  always @(posedge clk) begin
    if (rst)
       dout <= 0;
    else if (dout_en && (DOUT_PIPELINE=="TRUE"))
       dout <= dout_reg;
    else if (!DOUT_PIPELINE)
       dout <= dout_reg;      
  end
  always @(posedge clk) begin
      if (rst)
         parity_out <= 0;
       else 
           if (PARITY_ENABLE)
               parity_out <= ^dout;
            else 
               parity_out <= 0;     
  end
endmodule

module  ram_ts();
parameter MEM_WIDTH_ts = 16;
parameter ADDR_SIZE_ts = 10;
wire [MEM_WIDTH_ts-1:0] dout;
wire parity_out;
reg [MEM_WIDTH_ts-1:0] din;
reg [ADDR_SIZE_ts-1:0] addr;
reg wr_en,rd_en,blk_select,addr_en,dout_en,clk,rst;

ram #(.MEM_WIDTH(MEM_WIDTH_ts),.ADDR_SIZE(ADDR_SIZE_ts)) p (dout,parity_out,din,addr,wr_en,rd_en,blk_select,addr_en,dout_en,clk,rst);

initial begin
    clk = 0;
    forever begin
        #1 clk = ~clk;
    end
end 
initial begin
    rst = 1;
    repeat (10) begin
        wr_en = $random;
        rd_en = $random;
        addr = $random;
        din = $random;
        addr_en = $random;
        dout_en = $random;
        blk_select = $random;
        @(negedge clk);
    end
    rst = 0;
    rd_en = 0;
    addr_en = 1;
    dout_en = 0;
    dout_en = 1;
    blk_select = 1;
    addr = 10'b0000000011;
    din = 16'h222;
    repeat(10) begin
        wr_en = $random;
        @(negedge clk);
    end
    rd_en = 1;
    wr_en = 0;
    dout_en = 1;
    din = 16'h222;
    repeat(10) @(negedge clk);
    $stop;
end
initial begin
     $monitor ("clk=%b rst=%b wr=%b rd=%b blk=%b addr_en=%b dout_en=%b addr=%b din=%b dout=%b parity=%b",clk,rst,wr_en,rd_en,blk_select,addr_en,dout_en,addr,din,dout,parity_out);
end
endmodule

