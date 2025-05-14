///////////////// MUX2_1 /////////////////

module MUX2_1 ( output I,
                input A0,A1,sel);
assign I = (sel ==0) ? A0 : A1;    

endmodule

///////////////// question_1 /////////////////

module circuit_1 ( output out,out_bar,
                   input A,B,C,D,E,F,sel);
    wire w0,w1;
    and (w0,A,B,C);
    xnor (w1,D,E,F);
    MUX2_1 q0 (out,w0,w1,sel);
    not (out_bar,out); 
endmodule 

///////////////// question_2 /////////////////

module adder ( output [3:0] c,
               input [3:0] A,B);
      assign c = A + B;          
    
endmodule

///////////////// question_3 /////////////////

module decoder2_4 ( output [3:0] D,
                    input [1:0] A);
   assign D = (A==2'b00) ? 4'b0001 : (A==2'b01) ? 4'b0010 : (A==2'b10) ? 4'b0100 : 4'b1000;
    
endmodule

///////////////// question_4 /////////////////

module even_parity ( output [8:0] out,
                     input [7:0] A);
    wire parity_bit;
    assign parity_bit = ^A;
    assign out = {A,parity_bit};
    
endmodule

///////////////// question_5 /////////////////

module comparator ( output A_greaterthan_B,A_lessthan_B,A_equals_B,
                    input [3:0] A,B);
    assign A_greaterthan_B = (A > B) ? 1'b1 : 1'b0;
    assign A_lessthan_B = (A < B) ? 1'b1 : 1'b0;
    assign A_equals_B = (A == B) ? 1'b1 : 1'b0;
    
endmodule

