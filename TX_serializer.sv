module TX_serializer (TX_serializer_IF ser_if);

    reg current_state,next_state;

    always @(posedge ser_if.clk or posedge ser_if.rst) begin
        if (ser_if.rst) begin
            
        end
    end
endmodule