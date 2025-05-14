module rom_4x4 ( output reg [3:0] data_out,
                 input [1:0] address,
                 input clk,rst);

        reg [3:0] mem [3:0] ;

        always @(posedge clk) begin
            if (rst)
               data_out <= 0;
            else
               data_out <= mem[address];   
        end         
       
endmodule

module rom_4x4_ts ();

wire [3:0] data_out;
reg [1:0] address;
reg clk , rst;

rom_4x4 p (data_out,address,clk,rst);

initial begin
    clk = 0;
    forever #1 clk = ~clk;
end
initial begin
    $readmemb ("mem_extra_q4.txt", p.mem);
    rst = 1;
    repeat (5) @(negedge clk);
    rst = 0;
    repeat (100) begin
        address = $random;
        @(negedge clk);
    end
    $stop;
end

initial begin
    $monitor ("clk=%b rst=%b address=%b out=%b",clk,rst,address,data_out);
end
endmodule