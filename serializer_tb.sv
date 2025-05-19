module serializer_tb(TX_serializer_IF.TEST ser_if);

initial begin
    ser_if.rst = 1;
    @(negedge ser_if.clk);

    ser_if.data_in = 'b1111_1010;
    ser_if.ready = 1;
    ser_if.rst = 0;

    repeat (10) begin
        @(negedge ser_if.clk);
        $display("data_in[%0d] = %0d", DUT.bit_to_serialize, ser_if.data_in[DUT.bit_to_serialize]);    
    end
    
    @(negedge ser_if.clk);
    @(negedge ser_if.clk);
    @(negedge ser_if.clk);
    @(negedge ser_if.clk);
    @(negedge ser_if.clk);
    @(negedge ser_if.clk);
    @(negedge ser_if.clk);
    @(negedge ser_if.clk);
    @(negedge ser_if.clk);
    @(negedge ser_if.clk);
    @(negedge ser_if.clk);
    @(negedge ser_if.clk);
    @(negedge ser_if.clk);

    $stop;
end    


endmodule