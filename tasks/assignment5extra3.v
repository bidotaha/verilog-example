module circuit_2 ( output y,
                   input x,clk,rst);
parameter S0 = 2'b00;                  
parameter S1 = 2'b01;
parameter S2 = 2'b10;
parameter S3 = 2'b11;

reg [1:0] cs,ns;

always @(posedge clk , posedge rst) begin
    if (rst) begin
       cs <= S0;
    end
    else begin
       cs <= ns;
       
    end
end
always @(*) begin
    case (cs)
        S0   : begin
                      if (x)
                         ns = S1;
                      else 
                         ns = S0;               
                 end
        S1   : begin
                      if (x)
                         ns = S2;
                      else 
                         ns = S1;               
                 end
        S2    : begin
                      if (x)
                         ns = S3;
                      else 
                         ns = S2;               
                 end               
        S3   : begin
                      if (x)
                         ns = S1;
                      else 
                         ns = S0;               
                 end                   
    endcase
end

assign y = ((cs == S2) && (x==1)) ? 1'b1 : 1'b0;

endmodule

module circuit_2_ts ();
wire y;
reg x,clk,rst;

circuit_2 u (y,x,clk,rst);

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
    x = $random;    
    @(negedge clk);  
    end
    $stop;    
end
initial begin
    $monitor ("clk=%b rst=%b x=%b y=%b",clk,rst,x,y);

end
endmodule