module comparator_4_bit( output reg [5:0] Y,
                         input [3:0] A,
                         input [3:0] B);

always @* begin
    // Equals
    Y[5] = (A == B);
    
    // Not Equal
    Y[4] = (A != B);
    
    // Greater Than
    Y[3] = (A > B);
    
    // Less Than
    Y[2] = (A < B);
    
    // Greater Than or Equal
    Y[1] = (A >= B);
    
    // Less Than or Equal
    Y[0] = (A <= B);
end

endmodule


module comparator_4_bit_ts ();

  reg [3:0] A;
  reg [3:0] B;
  wire [5:0] Y;

  comparator_4_bit C (Y,A,B);
  initial 
  begin
    $monitor("A=%b, B=%b, Y=%b", A, B, Y);
    
    // Test case 1: A = B
    A = 4'b1111; B = 4'b1111; #10;
    
    // Test case 2: A > B
    A = 4'b1110; B = 4'b1101; #10;
    
    // Test case 3: A < B
    A = 4'b0001; B = 4'b0110; #10;
    
    // Test case 4: A >= B
    A = 4'b1111; B = 4'b1110; #10;
    
    // Test case 5: A <= B
    A = 4'b0010; B = 4'b0010; #10;
  
  end

endmodule
