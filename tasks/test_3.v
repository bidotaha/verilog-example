module MUX3x1_Design_3 ( output reg out,
                input D0,D1,D2,S0,S1);
     always @(*) begin
        casex ({S1,S0})
            2'b00  : out = D0; 
            2'b01  : out = D1;
            2'b1x  : out = D2;
        endcase
     end
endmodule