module stopwatch(
    input wire clk,      // Clock input
    input wire reset,      // Reset input
    input wire start,    // Start/Stop control signal
    input wire reset_stopwatch,
    output reg [6:0] seconds
    // output reg [6:0] seconds_display1, // 8-bit time counter (you can adjust this width)
    // output reg [6:0] seconds_display2 // 8-bit time counter (you can adjust this width)
    // output reg [6:0] minutes_display1, // 8-bit time counter (you can adjust this width)
    // output reg [6:0] minutes_display2 // 8-bit time counter (you can adjust this width)
    // output reg done       // Signal to indicate that the stopwatch is running 
    );


    // reg [3:0] seconds1; //reg for case statement for single seconds
    // reg [3:0] seconds2; //reg for case statement for tenth minutes
    // reg [3:0] minutes1; //reg for case statement for single seconds
    // reg [3:0] minutes2; //reg for case statement for tenth minutes

    integer clk_div;

    // reg [5:0] seconds; //counters
    // reg [8:0] minutes; //counters

    // reg [7:0] count;   // 8-bit counter for stopwatch

    // always@(seconds) begin
    //     if(reset) begin
    //         seconds_display1 = 7'b1000000; 
    //     end
    //     else if (reset_stopwatch) begin
    //         seconds_display1 = 7'b1000000;
    //     end
    //     else begin
    //         seconds1 = seconds % 10;
    //         case(seconds1)
    //             0: seconds_display1 = 7'b1000000;  // 0
    //             1: seconds_display1 = 7'b1111001;  // 1
    //             2: seconds_display1 = 7'b0100100;  // 2
    //             3: seconds_display1 = 7'b0110000;  // 3
    //             4: seconds_display1 = 7'b0011001;  // 4
    //             5: seconds_display1 = 7'b0010010;  // 5
    //             6: seconds_display1 = 7'b0000010;  // 6
    //             7: seconds_display1 = 7'b1111000;  // 7
    //             8: seconds_display1 = 7'b0000000;  // 8
    //             9: seconds_display1 = 7'b0010000;  // 9
    //             default: seconds_display1 = 7'b1111111;
    //         endcase
    //     end
    // end

    // always@(seconds) begin
    //     if(reset) begin
    //         seconds_display2 = 7'b1000000; 
    //     end
    //     else if (reset_stopwatch) begin
    //         seconds_display2 = 7'b1000000;
    //     end
    //     else begin
    //         seconds2 = seconds / 10;
    //         case(seconds2) 
    //             0: seconds_display2 = 7'b1000000;  // 0
    //             1: seconds_display2 = 7'b1111001;  // 1
    //             2: seconds_display2 = 7'b0100100;  // 2
    //             3: seconds_display2 = 7'b0110000;  // 3
    //             4: seconds_display2 = 7'b0011001;  // 4
    //             5: seconds_display2 = 7'b0010010;  // 5
    //             6: seconds_display2 = 7'b0000010;  // 6
    //             7: seconds_display2 = 7'b1111000;  // 7
    //             8: seconds_display2 = 7'b0000000;  // 8
    //             9: seconds_display2 = 7'b0010000;  // 9
    //             default: seconds_display2 = 7'b1111111;
    //         endcase
    //     end
    // end

    // always@(minutes) begin
    //     if(reset) begin
    //         minutes_display1 = 7'b1000000; 
    //     end
    //     else if (reset_stopwatch) begin
    //         minutes_display1 = 7'b1000000;
    //     end
    //     else begin
    //         minutes1 = minutes % 10; 
    //         case(minutes1)
    //             0: minutes_display1 = 7'b1000000;  // 0
    //             1: minutes_display1 = 7'b1111001;  // 1
    //             2: minutes_display1 = 7'b0100100;  // 2
    //             3: minutes_display1 = 7'b0110000;  // 3
    //             4: minutes_display1 = 7'b0011001;  // 4
    //             5: minutes_display1 = 7'b0010010;  // 5
    //             6: minutes_display1 = 7'b0000010;  // 6
    //             7: minutes_display1 = 7'b1111000;  // 7
    //             8: minutes_display1 = 7'b0000000;  // 8
    //             9: minutes_display1 = 7'b0010000;  // 9
    //             default: minutes_display1 = 7'b1111111; 
    //         endcase
    //     end
    // end

    // always@(minutes) begin
    //     if(reset) begin
    //         minutes_display2 = 7'b1000000; 
    //     end
    //     else if (reset_stopwatch) begin
    //         minutes_display2 = 7'b1000000;
    //     end
    //     else begin
    //         minutes2 = minutes % 10; 
    //         case(minutes2) 
    //             0: minutes_display2 = 7'b1000000;  // 0
    //             1: minutes_display2 = 7'b1111001;  // 1
    //             2: minutes_display2 = 7'b0100100;  // 2
    //             3: minutes_display2 = 7'b0110000;  // 3
    //             4: minutes_display2 = 7'b0011001;  // 4
    //             5: minutes_display2 = 7'b0010010;  // 5
    //             6: minutes_display2 = 7'b0000010;  // 6
    //             7: minutes_display2 = 7'b1111000;  // 7
    //             8: minutes_display2 = 7'b0000000;  // 8
    //             9: minutes_display2 = 7'b0010000;  // 9
    //             default: minutes_display2 = 7'b1111111;
    //         endcase
    //     end
    // end

    always@(posedge clk or posedge reset) begin
        if(reset) begin
            clk_div <= 0;
        end
        else if(start) begin
            if(clk_div == 17_000_000) begin
                clk_div <= 0;
            end
            else begin
                clk_div <= clk_div + 1;               
            end
        end
        else begin
            if(reset_stopwatch)  begin
                clk_div <= 0;
            end
            else begin
                clk_div <= clk_div;
            end
        end
    end

    // Counter logic, increment every clock cycle if the stopwatch is running
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            seconds <= 0;
            // count <= 8'b0;   // Reset counter to 0
            // done <= 1'b0;    // Clear done signal
        end 
        else if (start) begin
            if(clk_div == 17_000_000) begin
                // if(seconds == 59) begin
                //     seconds <= 0;
                //     // minutes <= minutes + 1;
                // end
                // else begin
                    //seconds <= seconds + 1;
                // end
                seconds <= seconds + 1; // Increment counter on each clock cycle
                // done <= 1'b0;       // Not done since we have no limit
            end
            else begin
                seconds <= seconds;
                // minutes <= minutes;
            end
        end 
        else begin
            if(reset_stopwatch) begin
                seconds <= 0;
                // minutes <= 0;
            end
            else begin
                seconds <= seconds;
                // minutes <= minutes;                    
            end
        end
    end

endmodule
