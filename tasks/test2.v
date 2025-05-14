module vending_machine ( output dispense,change,
                         input d_in,q_in,clk,rst);
  parameter wait = 2'b00;
  parameter q_25 = 2'b01;
  parameter q_50 = 2'b10;

  reg [1:0] cs,ns;
  always @(posedge clk , negedge rst) begin
    if (!rst)
       cs <= wait;
    else 
       cs <= ns;  
  end  
  always @(*) begin
    case (cs)
        wait   : begin
                 if (d_in) 
                    ns = wait;
                 else if (q_in)
                    ns = q_25;
                 end
        q_25   : begin
                  if (q_in)
                    ns = q_50;
                 end  
        q_50   : begin
                  if (q_in)
                    ns = wait;
                 end                     
        default: ns = wait;
    endcase
  end
  assign dispense = (cs==wait && d_in==1 || cs==q_50 && q_in==1) ? 1'b1 : 1'b0;
  assign change = (cs==wait && d_in==1) ? 1'b1 : 1'b0;
  
    
endmodule

module vending_machine_ts ();
wire dispense,change;
reg d_in,q_in,clk,rst;

vending_machine r (dispense,change,d_in,q_in,clk,rst);
endmodule