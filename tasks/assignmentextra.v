///////////////// MUX2_1 /////////////////

module MUX2_1 ( output I,
                input A0,A1,sel);
assign I = (sel ==0) ? A0 : A1;    

endmodule

///////////////////// question_1 ///////////////////////

module circuit_2 ( output out,
                   input [3:0] A);
    assign out = (A > 4'b0010 && A < 4'b1000) ? 1'b1 : 1'b0;

endmodule

///////////////////// question_3 ///////////////////////

module circuit_3 ( output F,
                   input A,B,C);

    //assign F = (A^B)&(B~^C)&(C);
    wire w0,w1;
    
    xor 	(w0,A,B);
    xnor 	(w1,B,C);
    and 	(F,w0,w1);
    /* F=1 when A=0 B=1 C=1 */
    
endmodule 

///////////////////// question_4 ///////////////////////

module ALU ( output reg result,carry_out,
             input A,B,Ainvert,Binvert,carry_in,
             input [1:0] operation);
      wire w0,w1;
      MUX2_1 e (w0,A,~A,Ainvert);
      MUX2_1 f (w1,B,~B,Binvert);
      always @(*) begin
        case (operation)
            2'b00: result = w0&w1; 
            2'b01: result = w0|w1;
            2'b10: {carry_out,result} = w0+w1+carry_in; 
            default: result = 0;
        endcase
      end
    
endmodule