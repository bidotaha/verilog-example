module MUX3x1_ts ();
    wire out_ts1, out_ts2;
    reg D0_t,D1_t,D2_t,S0_t,S1_t;

    MUX3x1_Design_2 q0 (out_ts1,D0_t,D1_t,D2_t,S0_t,S1_t);
    MUX3x1_Design_3 q1 (out_ts2,D0_t,D1_t,D2_t,S0_t,S1_t);
    
    integer i;
    initial begin
        for (i=0 ; i<10 ; i=i+1 ) begin
            D0_t = $random;
            D1_t = $random;
            D2_t = $random;
            S0_t = $random;
            S1_t = $random;
            #10
            if (out_ts1 != out_ts2) begin
                $display (" ERROR ");
                $stop;
        end
    end
    end
    initial begin
        $monitor (" D0 = %b D1 = %b D2 = %b S0 = %b S1 = %b out_ts1 = %b out_ts2 = %b",D0_t,D1_t,D2_t,S0_t,S1_t,out_ts1,out_ts2);
    end 
endmodule