module myandgate (o1 , in1 , in2 );

output o1 ;
input in1 , in2;

assign o1 = in1 & in2;

endmodule 


module testmodule1 ;

reg a,b ;
wire c ;

initial
begin

$monitor (" %b  %b  %b ",a,b,c);

#10
a = 0;
b = 0;

#10
a = 1;
b = 0;

#10
a = 0;
b = 1;

#10
a = 1;
b = 1;

end

myandgate g1 (c,a,b);


endmodule 

module secondtestmodule ( in1 , o1 , o2);

input in1;
output o1 , o2;
reg o1 , o2;

initial
begin

$monitor (" %b %b %b",o1,o2,in1);
#10
o1 = 0;
o2 = 0;

#10
o1 = 1;
o2 = 0;

#10
o1 = 0;
o2 = 1;

#10
o1 = 1;
o2 = 1;

end 

endmodule 

module testbench ;

myandgate f1(w1,w2,w3);

secondtestmodule e1 (w1,w2,w3);

endmodule 

module myandgate2 ;

reg a,b;
wire c;

assign c = a & b;

initial 
begin 

$monitor (" in1 = %b   in2 = %b   o = %b ",a,b,c);

#10
a = 0;
b = 0;

#10
a = 1;
b = 0;

#10
a = 0;
b = 1;

#10
a = 1;
b = 1;

end 

endmodule 