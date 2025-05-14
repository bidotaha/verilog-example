module tesla #( parameter MIN_DISTANCE = 40 )
              ( output reg unloack_doors,accelerate_car,
                input [7:0] speed_limit,car_speed,
                input [6:0] leading_distance,
                input clk,rst);
parameter STOP = 2'b00;
parameter ACCELERATE = 2'b01;
parameter DECELERATE = 2'b10;

reg [1:0] cs,ns;

always @(posedge clk , posedge rst) begin
    if (rst)
       cs <= STOP;
    else 
       cs <= ns;   
end
always @(*) begin
    case (cs)
        STOP       : begin
                     if (leading_distance < MIN_DISTANCE)
                         ns = STOP;
                     else 
                         ns = ACCELERATE;
                     end
        ACCELERATE : begin
                     if ((leading_distance >= MIN_DISTANCE) && (car_speed < speed_limit))
                         ns = ACCELERATE;
                     else if ((leading_distance < MIN_DISTANCE) || (car_speed > speed_limit))
                         ns = DECELERATE;   
                     end
        DECELERATE : begin
                     if ((leading_distance < MIN_DISTANCE) || (car_speed > speed_limit))
                         ns = DECELERATE;
                     else if ((leading_distance >= MIN_DISTANCE) && (car_speed < speed_limit))
                         ns = ACCELERATE;
                     else if (car_speed == 0)
                         ns = STOP;
                     end                      
        default    : ns = STOP;
    endcase
end
always @(cs) begin
    case (cs)
        STOP       : begin
                     unloack_doors = 1;
                     accelerate_car = 0;
                     end
        ACCELERATE : begin
                     unloack_doors = 0;
                     accelerate_car = 1;
                     end
        DECELERATE : begin
                     unloack_doors = 0;
                     accelerate_car = 0;
                     end 
    endcase
end    
endmodule
/*
module tesla_ts ();
wire unloack_doors,accelerate_car;
reg [7:0] speed_limit,car_speed;
reg [6:0] leading_distance;
reg clk,rst;
tesla m (unloack_doors,accelerate_car,speed_limit,car_speed,leading_distance,clk,rst);
initial begin
    clk = 0;
    forever begin
        #1 clk = ~clk;
    end
end    
initial begin
    rst = 1;
    speed_limit = 8'd100;
    @(negedge clk)
    rst = 0;
    repeat (100) begin
    car_speed = $random;
    leading_distance = $random;  
    @(negedge clk);  
    end
    $stop;    
end
initial begin
    $monitor ("clk=%b rst=%b speed_limit=%d car_speed=%d leading_distance=%d unloack_doors=%b accelerate_car=%b",clk,rst,speed_limit,car_speed,leading_distance,unloack_doors,accelerate_car);

end
endmodule
*/