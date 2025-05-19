module top();
    
    bit clk;

    always #1 clk = ~clk;

    TX_serializer_IF ser_if(clk);

    TX_serializer DUT (ser_if);
    serializer_tb tb (ser_if);
endmodule