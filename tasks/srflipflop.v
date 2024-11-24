module srflipflop (Q , Qbar , s , r , clk , masterset);

output Q , Qbar;
reg Q , Qbar;
input s , r , clk , masterset;

always@(masterset)
begin
if(masterset == 1)
begin Q = 1; Qbar = 0; end
end

always@(posedge clk)
begin

if(s == 1 && r == 0)
begin Q = 1; Qbar = 0; end

if(s == 0 && r == 1)
begin Q = 0; Qbar = 1; end

if(s == 1 && r == 1)
begin Q = 1'bx; Qbar = 1'bx; end

if(s == 0 && r == 0)
begin Q = Q; Qbar = Qbar; end

end

endmodule 


module testbench4 ;

reg clk , s , r , masterset;
wire Q , Qbar;

initial 
begin

$monitor ($time ,, "clk = %b  masterset = %b  s = %b  r = %b  Q = %b  Qbar = %b",clk,masterset,s,r,Q,Qbar);

clk = 0;
masterset = 1;
#2
masterset = 0;

#6
s = 0;
r = 0;

#6
s = 1;
r = 1;

#6
s = 0;
r = 1;

#6
s = 1;
r = 0;


end

always
begin
#5 clk = ~clk ;
end

srflipflop srr (Q,Qbar,s,r,clk,masterset);

endmodule 