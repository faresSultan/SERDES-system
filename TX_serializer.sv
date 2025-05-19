
typedef enum reg { IDLE = 1'b0, SERIALIZING = 1'b1 } state_e;

module TX_serializer (TX_serializer_IF.DUT ser_if);

    state_e current_state,next_state;

    reg [$clog2(ser_if.WIDTH)-1:0] bit_to_serialize;

        
    // current state logic

    always @(posedge ser_if.clk or posedge ser_if.rst) begin
        if(ser_if.rst) begin
            current_state <= IDLE;
            bit_to_serialize <= 'b0;
        end
        else begin
            current_state <= next_state;
            if(current_state == SERIALIZING && !ser_if.finished)
                bit_to_serialize <= bit_to_serialize + 1;
            else if (current_state == IDLE)
                bit_to_serialize <='b0;
        end 
    end


    // next state logic

    always @(*) begin
        case(current_state)
            IDLE: begin
                if(!ser_if.ready)
                    next_state = IDLE;

                else if (ser_if.ready)
                    next_state = SERIALIZING;
            end

            SERIALIZING: begin
                if(ser_if.finished)
                    next_state = IDLE;

                else if (!ser_if.finished)
                    next_state = SERIALIZING;
            end 
        endcase
    end

    //output logic

    always @(*) begin
        case (current_state)
            IDLE : begin
                ser_if.serial_out = 0;
                ser_if.finished = 0;
            end

            SERIALIZING: begin
                if (bit_to_serialize < ser_if.WIDTH-1) begin
                    ser_if.serial_out = ser_if.data_in[bit_to_serialize];
                    ser_if.finished = 0;
                end
                else if(bit_to_serialize == ser_if.WIDTH-1) begin
                    ser_if.finished = 1;
                end
            end
        endcase
    end

endmodule