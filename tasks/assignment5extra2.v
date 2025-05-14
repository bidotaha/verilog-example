module circuit_1 ( output reg y,
                   output reg [9:0] count,
                   input x,clk,rst);
parameter IDLE = 2'b00;                  
parameter ZERO = 2'b01;
parameter STORE = 2'b10;
parameter ONE = 2'b11;

reg [1:0] cs,ns;

always @(posedge clk , posedge rst) begin
    if (rst) begin
       cs <= IDLE;
       count <= 0;
    end
    else begin
       cs <= ns;
       
    end
end
always @(*) begin
    case (cs)
        IDLE   : begin
                      if (x)
                         ns = IDLE;
                      else 
                         ns = ZERO;               
                 end
        ZERO   : begin
                      if (x)
                         ns = ONE;
                      else 
                         ns = ZERO;               
                 end
        ONE    : begin
                      if (x)
                         ns = IDLE;
                      else 
                         ns = STORE;               
                 end               
        STORE   : begin
                      if (x)
                         ns = IDLE;
                      else 
                         ns = ZERO;               
                 end                   
    endcase
end
always @(*) begin
    case (cs)
        IDLE      : y = 0; 
        ZERO      : y = 0;
        ONE       : y = 0;
        STORE     : begin 
                         y = 1;
                         count = count + 1;
                    end      
    endcase
end
endmodule

module circuit_1_ts ();
wire y;
wire [9:0] count;
reg x,clk,rst;

circuit_1 o (y,count,x,clk,rst);

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
    $monitor ("clk=%b rst=%b x=%b y=%b count=%d",clk,rst,x,y,count);

end
endmodule