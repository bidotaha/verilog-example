module full_adder #( parameter WIDTH_1 =4,
                     parameter PIPELINE_ENABLE =1,
                     parameter FULL_ADDER =1)
                    ( output [WIDTH_1-1:0] sum,
                      output reg cout,
                      input [WIDTH_1-1:0] a,b,
                      input cin,clk,rst);
   reg [WIDTH_1-1:0] sum_s,sum_c;
   assign sum = (PIPELINE_ENABLE) ? sum_s : sum_c;
   always @(posedge clk) begin
      if (rst)
      sum_s <= 0;
      else begin
        if (FULL_ADDER)
           {cout,sum_s} <= a+b+cin;
        else
           {cout,sum_s} <= a+b;
      end
   end 
      always @(*) begin
      if (rst)
      sum_c = 0;
      else begin
        if (FULL_ADDER)
           {cout,sum_c} = a+b+cin;
        else
           {cout,sum_c} = a+b;
      end
   end                    
    
endmodule

module full_adder_ts ();
  parameter WIDTH_2 =4;
  wire [WIDTH_2-1:0] sum;
  reg [WIDTH_2-1:0] sum_expected;
  wire cout;
  reg [WIDTH_2-1:0] a,b;
  reg cin,clk,rst;

  full_adder #(.WIDTH_1(WIDTH_2),.PIPELINE_ENABLE(1),.FULL_ADDER(1)) r (sum,cout,a,b,clk,rst);

  initial begin
    clk = 0;
    forever #1 clk = ~clk;
  end
  initial begin
    rst = 1;
    repeat(10) begin
        a = $random;
        b = $random;
        cin = $random;
        @(negedge clk);
        sum_expected = 0;
    end
    rst = 0;
    repeat(10) begin
        a = $random;
        b = $random;
        cin = $random;
        @(negedge clk);
        sum_expected = a+b+cin;
    end
    $stop;    
  end
    initial begin
        $monitor("clk=%b rst=%b a=%d b=%d cin=%d sum=%d sum_expected=%d cout=%d",clk,rst,a,b,cin,sum,sum_expected,cout);
    end  
    
endmodule