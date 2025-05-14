module  bit_stream ( output err,
          input din,clk,rst);
parameter start    = 3'b000;
parameter d0_is_1  = 3'b001; 
parameter d1_is_1  = 3'b010; 
parameter d0_not_1 = 3'b011; 
parameter d1_not_1 = 3'b100;
reg [1:0] cs,ns;
always @(posedge clk , posedge rst) begin
    if (rst)
       cs <= start;
    else 
       cs <= ns;   
end
always @(cs) begin
    case (cs)
        start  : begin
                 if (din)
                    ns = d0_is_1;
                 else
                    ns = d0_not_1;      
                 end 
        d0_is_1  : begin
                   if (din)
                      ns = d1_is_1;
                   else
                      ns = d1_not_1;      
                   end
        d1_is_1   : ns = start;
        d0_not_1  : ns = d1_not_1;
        d1_not_1  : ns = start;                                      
        default: ns = start;
    endcase
end 

assign err = (cs == d1_is_1 && din == 1) ? 1'b1 : 1'b0;

endmodule

module  bit_stream_ts ();
wire err;
reg  din,clk,rst;
bit_stream m (err,din,clk,rst);
initial begin
    clk = 0;
    forever begin
        #1 clk = ~clk;
    end
end    
initial begin
    rst = 1;
    @(negedge clk)
    rst = 0;
    repeat (100) begin
    din = $random;      
    @(negedge clk);  
    end
    $stop;    
end
initial begin
    $monitor ("clk=%b rst=%b din=%b err=%b",clk,rst,din,err);

end
endmodule