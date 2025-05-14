module MUX3x1_Design_2 ( output out,
                input D0,D1,D2,S0,S1);
    assign out = (S0==0 && S1==0) ? D0 : (S0==1 && S1==0) ? D1 : (S1==1) ? D2 : D2;  
endmodule