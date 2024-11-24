module testbench5 ;
reg [31:0] A ;

initial 
begin 
$monitor ( $time ,, "%d  %b  %h",A,A,A);
A = 1101;
#5
A = 32 'b 1101;
#5
A = 32 'h AAAAA;
end
endmodule 

//////////////////////////////////////

module testbench6 ;
reg A,B;
reg [13:0] C ;
reg [16:0] D ;

initial 
begin
$monitor ("%b  %b  %b  %b",A,B,C,D);
A = 0;
B = 1;
C = 14 'b 1101;
D = {B , C[3:0] , {3{A}}};
end
endmodule 

///////////////////////////////////////////

module testbench7 ;
reg A,B;
reg [13:0] C ;
reg [16:0] D ;
initial 
begin
$monitor ("%b  %b  %b  %b",A,B,C,D);
A = 0;
B = 1;
C = 14 'b 1101001001;
D = (A == B) ? C : 20;
end
endmodule 

///////////////////////////////////

module testbench8 ;
reg A,B;
reg [13:0] C ;
reg [16:0] D ;
initial 
begin
$monitor ("%d  %d  %d  %d",A,B,C,D);
A = 0;
B = 1;
C = 5;
case (C)
10 : D = 14;
15 : D = 15;
default : D = 10;
endcase
end
endmodule 

///////////////////////////////////

module testbench9 ;
reg A,B;
reg [16:0] C ;
reg [16:0] D ;
 
initial 
begin
$monitor ("%d  %d  %d  %d",A,B,C,D);
A = 0;
B = 1;
C = 14 'b 1100110011xx1;
D = 14 'b 1100110011xx1;
D = (C === D) ? 30 : 20;
end
endmodule 

/////////////////////////////////

module testbench10 ;
reg A,B;
reg [15:0] C ;
reg [15:0] D ;

initial 
begin 
$monitor ("%d  %d  %d  %d",A,B,C,D);
#5
A = 5;
B = 10;
#10
A = 10;
B = 15;
end
endmodule 

//////////////////////////////////