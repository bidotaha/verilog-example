module gray_fsm ( output reg [1:0] y,
                  input clk,rst);
parameter A = 2'b00;                  
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

reg [1:0] cs,ns;
always @(posedge clk , posedge rst) begin
    if (rst) 
        cs <= A;
    else
        cs <= ns;   
end
always @(*) begin
    case (cs)
        A      : ns = B;
        B      : ns = C;
        C      : ns = D;
        D      : ns = A; 
        default: ns = A;
    endcase
end
always @(cs) begin
    case (cs)
        A      : y = 2'b00; 
        B      : y = 2'b01;
        C      : y = 2'b11;
        D      : y = 2'b10; 
    endcase
end
endmodule

module gray_fsm_ts ();
wire [1:0] y;
reg  clk,rst;
gray_fsm m (y,clk,rst);
initial begin
    clk = 0;
    forever #1 clk = ~clk;
end    
initial begin
    rst = 1;
    @(negedge clk)
    rst = 0;
    repeat (100) @(negedge clk);  
    $stop;    
end
initial begin
    $monitor ("clk=%b rst=%b y=%b",clk,rst,y);
end
endmodule

module gray_counter ( output reg [1:0] gray_out,
                      input clk, rst );
    reg [1:0] counter;

    always @(posedge clk , posedge rst) begin
        if (rst) begin
            counter <= 2'b00;    
            gray_out <= 2'b00;   
        end 
        else begin
            counter <= counter + 2'b01;  
            gray_out <= {counter[1],^ counter};  
        end
    end
endmodule

module gray_counter_ts ();
wire [1:0] y;
reg  clk,rst;
gray_counter m (y,clk,rst);
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
    @(negedge clk);  
    end
    $stop;    
end
initial begin
    $monitor ("clk=%b rst=%b y=%b",clk,rst,y);

end
endmodule

module gray_ts ();
wire [1:0] y1,y2;
reg  clk,rst;
gray_fsm m1 (y1,clk,rst);
gray_counter m2 (y2,clk,rst);
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
    @(negedge clk);  
    end
    $stop;    
end
initial begin
    $monitor ("clk=%b rst=%b y1=%b y2=%b",clk,rst,y1,y2);

end
endmodule