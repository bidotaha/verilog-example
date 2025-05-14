///////////////////////question_1///////////////////////////

module ALSU #( parameter INPUT_PRIORITY = "a",
               parameter FULL_ADDER = "on")
             ( output reg [5:0] out,
               output reg [15:0] leds,
               input [2:0] a,b,opcode,
               input clk,rst,cin,serial_in,red_op_a,red_op_b,bypass_a,bypass_b,direction);
   reg [3:0] addfulladder_out;
   reg [3:0] adderhalfadder_out;
   reg [5:0] multiplier_out;

    c_addsub_0 adder1 (
  .A(a),        // input wire [2 : 0] A
  .B(b),        // input wire [2 : 0] B
  .C_IN(cin),  // input wire C_IN
  .S(addfulladder_out)        // output wire [3 : 0] S
);
    c_addsub_1 adder2 (
  .A(a),  // input wire [2 : 0] A
  .B(b),  // input wire [2 : 0] B
  .S(adderhalfadder_out)  // output wire [3 : 0] S
);
    mult_gen_0 multiplier (
  .A(a),  // input wire [2 : 0] A
  .B(b),  // input wire [2 : 0] B
  .P(multiplier_out)  // output wire [5 : 0] P
);
    always @(posedge clk , posedge rst) begin
        if (rst) begin
           out <= 0;
           leds <= 0;
        end
        else begin
            if (INPUT_PRIORITY == "a" && bypass_a)
                out <= a;
            else if (INPUT_PRIORITY == "b" && bypass_b)
                out <= b;
            else begin
                   
            case (opcode)
                3'b000 : begin
                if (INPUT_PRIORITY == "a") begin                   
                         if (red_op_a)
                            out <= &a;
                         else 
                            out <= a&b;   
                end
                else if (INPUT_PRIORITY == "b") begin
                         if (red_op_b)
                            out <= &b;
                         else 
                            out <= a&b; 
                end          
                end
                3'b001 : begin
                if (INPUT_PRIORITY == "a") begin                   
                         if (red_op_a)
                            out <= ^a;
                         else 
                            out <= a^b;   
                end
                else if (INPUT_PRIORITY == "b") begin
                         if (red_op_b)
                            out <= ^b;
                         else 
                            out <= a^b; 
                end          
                end
                3'b010 : begin
                         if (FULL_ADDER == "on")
                            //out <= a+b+cin;
                            out <= addfulladder_out;
                         else if (FULL_ADDER == "off")
                            //out <= a+b;
                            out <= adderhalfadder_out;   
                end 
                3'b011 : out <= multiplier_out;                   //out <= a*b; 
                3'b100 : begin
                         if (direction)
                            out <= {out[4:0],serial_in};
                         else 
                         out <= {serial_in,out[5:1]};
                end
                3'b101 : begin
                         if (direction)
                            out <= {out[4:0],out[5]};
                         else 
                         out <= {out[0],out[5:1]};
                end
                3'b110 : begin 
                         leds <= 16'b1111111111111111;
                         out <= 0;
                end
                3'b111 : begin 
                         leds <= 16'b1111111111111111;
                         out <= 0;
                end                
                default: out <= 0;
            endcase
            end
        end    
     end              
    
endmodule
 
 module ALSU_ts ();
wire [5:0] out;
reg [5:0] out_expected;
wire [15:0] leds;
reg [2:0] a,b,opcode;
reg clk,rst,cin,serial_in,red_op_a,red_op_b,bypass_a,bypass_b,direction;

ALSU r (out,leds,a,b,opcode,clk,rst,cin,serial_in,red_op_a,red_op_b,bypass_a,bypass_b,direction);

initial begin
    clk = 0;
    forever #1 clk = ~clk;
end

initial begin
    rst = 1;
    repeat (5) begin
        a = $random;
        b = $random;
        opcode = $urandom_range(0,7);
        @(negedge clk);
        if (rst)
           out_expected = 0;
    end
    rst = 0;
    bypass_a =1;
    bypass_b =1;
    repeat (5) begin
        a = $random;
        b = $random;
        opcode = $urandom_range(0,7);
        repeat (2) @(negedge clk);
        if (bypass_a)
           out_expected = a;
        else if (bypass_b)
           out_expected = b;   
    end
    bypass_a =0;
    bypass_b =0;
    opcode =0;
    repeat (5) begin
        a = $random;
        b = $random;
        red_op_a = $random;
        red_op_b = $random;
        repeat (2) @(negedge clk);                                   
         if (red_op_a)
             out_expected = &a;
          else 
             out_expected = a&b;   
         if (red_op_b)
             out_expected = &b;
         else 
             out_expected = a&b;
    end
    opcode = 1;
    repeat (5) begin
        a = $random;
        b = $random;
        red_op_a = $random;
        red_op_b = $random;
        repeat (2) @(negedge clk);                                   
         if (red_op_a)
             out_expected = ^a;
          else 
             out_expected = a^b;   
         if (red_op_b)
             out_expected = ^b;
         else 
             out_expected = a^b;
    end
    opcode = 2;
    red_op_a = 0;
    red_op_b = 0;
    repeat (5) begin
        a = $random;
        b = $random;
        cin = $random;
        repeat (2) @(negedge clk);
        out_expected = a+b+cin; 
    end
    opcode = 3;
    repeat (5) begin
        a = $random;
        b = $random;
        repeat (2) @(negedge clk); 
        out_expected = a*b;
    end
    opcode = 4;
    repeat (5) begin
         a = $random;
         b = $random;
         direction = $random;
         serial_in = $random;
         repeat (2) @(negedge clk); 
    end
    opcode = 5;
    repeat (5) begin
         a = $random;
         b = $random;
         direction = $random;
         repeat (2) @(negedge clk); 
    end    
    opcode = 6;
    repeat (5) begin
        a = $random;
        b = $random;
        repeat (2) @(negedge clk); 
    end
    $stop;
end
initial begin
    $monitor ("clk=%b rst=%b pass_a=%b pass_b=%b red_a=%b red_b=%b c=%b s_in=%b d=%b op=%b a=%b b=%b out=%b out_ex=%b led=%b",clk,rst,bypass_a,bypass_b,red_op_a,red_op_b,cin,serial_in,direction,opcode,a,b,out,out_expected,leds);
end
 endmodule


