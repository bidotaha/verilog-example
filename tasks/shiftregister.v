module shiftregister_bh ( output reg [3:0] Q,
                       input [3:0] I,
                       input load,clk,shift);
always @ (posedge clk)
begin
if (shift)
begin
Q[3:1] <= Q[2:0];
Q[0] <= 1'b0;
end
else if (load)
Q <= I;

end 
endmodule 

`timescale 1ns/1ps

module shiftregister_bh_ts();
wire [3:0] Q;
reg shift,clk,Load;
reg [3:0] I;
shiftregister_bh P2 (Q,I,Load, CLK, shift);
initial
begin
clk=0;
forever
#2 clk=~clk;
end
initial
begin
I=4'b1011;shift=0;Load=0;
#5 shift=0;Load=1;
#5 shift=1;Load=0;
#5 shift=0;Load=0;
#5 shift=1;Load=0;
#5 I=4'b1010;shift=0;Load=0;
#5 shift=0;Load=1;
#10 shift=1;
end
endmodule

/////////////////////////////////////////////////

module D_FF (output reg Q,
             input D, CLK);
always@(posedge CLK)
Q<=D;
endmodule

module shift_1 (input load, shift,serial_in, I0, CLK,
                output A0);
wire load_bar,shift_bar, O1, O2, O3, FF_in;
not (load_bar, load);
not (shift_bar, shift);
and (O1,A0,load_bar,shift_bar);
and (O2,I0,load,shift_bar);
and (O3,serial_in,shift);
or  (FF_in, O1,O2,O3);
D_FF FF1(A0,FF_in,CLK);
endmodule

module shift_4 (output [3:0] Q,
                input [3:0] I,
                input load, CLK, shift,serial_in);
shift_1 R0 (load, shift,serial_in, I[0], CLK, Q[0]);
shift_1 R1 (load, shift,Q[0], I[1], CLK, Q[1]);
shift_1 R2 (load, shift,Q[1], I[2], CLK, Q[2]);
shift_1 R3 (load, shift,Q[2], I[3], CLK, Q[3]);
endmodule

`timescale 1ns/1ps

module shift_4_ts();
reg [3:0] I;
reg shift,serial_in,CLK,Load;
wire [3:0] Q;
shift_4 P1 (Q,I,Load, CLK, shift,serial_in);
initial
begin
CLK=0;
forever
#2 CLK=~CLK;
end
initial
begin
I=4'b1011;shift=0;Load=0;serial_in=0;
#5 shift=0;Load=1;
#5 shift=1;Load=0;
#5 shift=0;Load=0;
#5 shift=1;Load=0;
#5 I=4'b1010;shift=0;Load=0;
#5 shift=0;Load=1;
#10 shift=1;
end
endmodule 