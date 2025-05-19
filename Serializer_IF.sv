interface TX_serializer_IF(input bit clk);
    parameter WIDTH = 8;
    bit rst,ready;
    bit [WIDTH-1 : 0] data_in;
    logic finished;
    logic serial_out;

    modport DUT(input rst,ready,data_in, output serial_out,finished );
    modport TEST(output rst,ready,data_in, input serial_out,finished );

endinterface