module lcd_washing (
    input wire clk,          // System clock
    input wire reset,        // Reset signal

    input power,
    input water_full,
    input detergent_full,

    output  wash_ongoing,
    output  spin_ongoing,
    output  dry_ongoing,
    output  finished,

    output reg rs,           // Register Select
    output reg rw,           // Read/Write
    output reg en,           // Enable
    output reg [7:0] data,   // Data to be displayed
    output reg done          // Done signal after word is displayed


);

    localparam INIT = 3'b000;
    localparam COMMAND = 3'b001;
    localparam DATA = 3'b010;
    localparam WAIT = 3'b011;

    wire [2:0] washing_machine_state;
    reg [2:0] old_wm_state;
    reg [2:0] state;
    integer count;           // Counter for controlling the sequence
    reg [15:0] delay_count;  // Delay counter

    llccdd wm1(.clk(clk), .reset(reset), .power(power), .water_full(water_full),
               .detergent_full(detergent_full), .wash_ongoing(wash_ongoing), .spin_ongoing(spin_ongoing), 
               .dry_ongoing(dry_ongoing), .finished(finished), .state(washing_machine_state));

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= INIT;     // On reset, initialize LCD
            count <= 0;        // Reset counter
            delay_count <= 0;  // Reset delay counter
            en <= 0;           // Ensure disable
            done <= 0;
        end else begin
            case (state)
                INIT: begin
                    rs <= 0;
                    rw <= 0;
                    en <= 1;
                    data <= 8'h38; // Set 8-bit mode
                    state <= COMMAND;
                    delay_count <= 0; // Start delay counter
                end
                COMMAND: begin
                    en <= 0;  // Disable
                    delay_count <= delay_count + 1;
                    if (delay_count == 50000) begin // Delay for LCD processing
                        delay_count <= 0;
                        if (count == 0) begin
                            data <= 8'h0C;  // Turn display on (cursor off)
                            count <= count + 1;
                        end else if (count == 1) begin
                            data <= 8'h01;  // Clear display
                            count <= count + 1;
                        end else if (count == 2) begin
                            data <= 8'h06;  // Entry Mode Set (cursor moves right)
                            count <= count + 1;
                        end else if (count == 3) begin
                            state <= DATA; // Transition to data state
                            count <= 0;
                        end
                        en <= 1;  // Enable LCD
                    end
                end
                DATA: begin
                    en <= 1;
                    rs <= 1;   // Set to data mode
                    rw <= 0;   // Write mode
                    old_wm_state <= washing_machine_state;
                    case(washing_machine_state)
                        3'b000: begin
                            if (count <= 3) begin
                                case (count)
                                    0: data <= "I";
                                    1: data <= "D";
                                    2: data <= "L";
                                    3: data <= "E";
                                    4: data <= ".";
                                    5: data <= ".";
                                    6: data <= ".";                                    
                                endcase
                                count <= count + 1;  // Increment counter
                                state <= WAIT;       // Move to WAIT state after each character
                            end else begin
                                state <= WAIT;  // All characters sent, wait now
                                done <= 1;      // Indicate completion
                            end
                        end

                        3'b001: begin
                            if (count <= 6) begin
                                case (count)
                                    0: data <= "W";
                                    1: data <= "A";
                                    2: data <= "S";
                                    3: data <= "H";
                                    4: data <= "I";
                                    5: data <= "N";
                                    6: data <= "Z";
                                endcase
                                count <= count + 1;  // Increment counter
                                state <= WAIT;       // Move to WAIT state after each character
                            end else begin
                                state <= WAIT;  // All characters sent, wait now
                                done <= 1;      // Indicate completion
                            end
                        end

                        3'b010: begin
                            if (count <= 6) begin
                                case (count)
                                    0: data <= "S";
                                    1: data <= "P";
                                    2: data <= "I";
                                    3: data <= "N";
                                    4: data <= "I";
                                    5: data <= "N";
                                    6: data <= "X";
                                endcase
                                count <= count + 1;  // Increment counter
                                state <= WAIT;       // Move to WAIT state after each character
                            end else begin
                                state <= WAIT;  // All characters sent, wait now
                                done <= 1;      // Indicate completion
                            end
                        end

                        3'b011: begin
                            if (count <= 6) begin
                                case (count)
                                    0: data <= "D";
                                    1: data <= "R";
                                    2: data <= "Y";
                                    3: data <= "I";
                                    4: data <= "I";
                                    5: data <= "N";
                                    6: data <= "Y";
                                endcase
                                count <= count + 1;  // Increment counter
                                state <= WAIT;       // Move to WAIT state after each character
                            end else begin
                                state <= WAIT;  // All characters sent, wait now
                                done <= 1;      // Indicate completion
                            end
                        end
                    endcase
                end

                WAIT: begin
                    en <= 0;           // Disable
                    //delay_count <= delay_count + 1; // Delay before next operation
                    // if (delay_count == 50000 && count <= 6) begin // Wait time before moving forward
                    //     state <= DATA; // Return to DATA state to send next character
                    //     delay_count <= 0;  // Reset delay counter
                    // end
                    // else if (count > 6) begin
                    //     state <= WAIT;
                    //     count <= 0;
                    // end

                    if((washing_machine_state != old_wm_state) ) begin
                        state <= DATA;
                        //delay_count <= 0;
                        count <= 0;
                    end
                    else if ( (washing_machine_state == old_wm_state) )  begin
                        state <= DATA;
                        //delay_count <= 0;
                        count <= count;
                    end
                    else begin
                        state <= state;
                    end


                end
            endcase
        end
    end
endmodule
