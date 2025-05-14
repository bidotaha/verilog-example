module ALU (F,A,B,OP);
    parameter c = 4;
    output reg [c-1:0] F;
    input [c-1:0] A,B;
    input [1:0] OP;

    always @(*) begin
        case (OP)
            2'b00  : F = A + B;  
            2'b01  : F = A | B; 
            2'b10  : F = A - B; 
            2'b11  : F = A ^ B; 
            default: F = 0;
        endcase
    end 
             
    
endmodule