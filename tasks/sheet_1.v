module problem_3_33 ( output  f,
                      input x,y);
wire c1,c2,c3,c4;
not (c1,x);
not (c2,y);
and (c3,x,c2);
and (c4,y,c1);
or (f,c3,c4);
endmodule 

module problem_3_33_ts ();
reg x,y;
wire f;
problem_3_33 q (f,x,y);
initial
begin
x = 1'b0; y = 1'b0;
#100 y = 1'b1;
end
endmodule

module problem_3_34 ( output o1,o2,o3,
                      input a,b,c,d);
assign o1 = (a|(~b))&(~c)&(c|d);
assign o2 = (((~c)&d)|(b&c&d)|(c&(~d)))&((~a)|b);
assign o3 = (((a&b)|c)&d)|((~b)&c);

endmodule 

// problem_3_37
primitive table_4b ( output f,
                  input a,b,c,d);
table
0 0 0 0 : 0;
0 0 0 1 : 0;
0 0 1 0 : 0;
0 0 1 1 : 0;
0 1 0 0 : 0; 
0 1 0 1 : 0;
0 1 1 0 : 0;
0 1 1 1 : 1;
1 0 0 0 : 0;
1 0 0 1 : 0;
1 0 1 0 : 0;
1 0 1 1 : 1;
1 1 0 0 : 0;
1 1 0 1 : 1;
1 1 1 0 : 1; 
1 1 1 1 : 1;
endtable 
endprimitive

module problem_3_37 ( output f,
                      input a,b,c,d);
 table_4b w (f,a,b,c,d);
endmodule 

module problem_3_38 ();
wire e,f;
reg a,b,c,d;
Circut_With_UDP_02467 w2 (e,f,a,b,c,d);
initial
begin
    a = 1'b1; b = 1'b1; c = 1'b0; d = 1'b0;
#10                     c = 1'b1;
#5                                d = 1'b1;
#5            b = 1'b0; c = 1'b0;
#10                     c = 1'b1; d = 1'b0;
#10 a = 1'b0; b = 1'b1; c = 1'b0;
#10                     c = 1'b1; d = 1'b1;
#10           b = 1'b0; c = 1'b0;
#10                     c = 1'b1; d = 1'b0;
end
endmodule    





















