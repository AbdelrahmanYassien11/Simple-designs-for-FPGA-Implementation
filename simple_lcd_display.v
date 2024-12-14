module lcd_display (
    input clk,              // System Clock
    input reset,            // Reset
    output reg [7:0] lcd_data,  // Data to be written to LCD
    output reg lcd_rs,      // Register Select (0: Command, 1: Data)
    output reg lcd_rw,      // Read/Write (0: Write, 1: Read)
    output reg lcd_en,      // Enable signal
    output reg done,         // Done signal after word is displayed
    output reg lcd_on,
    output reg back_light_on
);

    // LCD Commands
    parameter CLEAR_DISPLAY = 8'h01;
    parameter HOME = 8'h02;
    parameter ENTRY_MODE_SET = 8'h06;
    parameter DISPLAY_ON = 8'h0C;
    parameter CURSOR_LEFT = 8'h10;
    parameter CURSOR_RIGHT = 8'h14;

    // ROM for the word "WASHING"
    reg [7:0] rom[6:0];   // ROM to store the word "WASHING" (7 characters)
    
    // ROM Initialization with the word "WASHING"
    initial begin
        rom[0] = "W";
        rom[1] = "A";
        rom[2] = "S";
        rom[3] = "H";
        rom[4] = "I";
        rom[5] = "N";
        rom[6] = "G";
    end

    // FSM States
    reg [3:0] state, next_state;
    
    // State encoding
    localparam IDLE = 4'b0001;
    localparam INIT_LCD = 4'b0010;
    localparam SETTING_COMMAND = 4'b0011;
    localparam SEND_DATA = 4'b0100;
    localparam CURSOR_MOVE = 4'b1000;
    localparam DONE = 4'b0000;

    // Registers for ROM index and display position
    reg [2:0] rom_index;   // Points to the current character in ROM
    reg [3:0] display_pos; // LCD position (0-15 for 16x2)

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            lcd_on <= 1;
            back_light_on <= 1;
        end else begin
            state <= next_state;
            lcd_on <= lcd_on;
            back_light_on <= back_light_on;
        end
    end

    // Next state and output logic (FSM)
    always @(*) begin

        case(state)
            IDLE: begin
                lcd_rs = 0;
                lcd_rw = 0;
                lcd_en = 0;
                lcd_data = 8'h00;
                done = 0;
                rom_index = 0;
                display_pos = 0;

                next_state = INIT_LCD;
            end

            INIT_LCD: begin
                // Initialize LCD: clear screen, home cursor, set entry mode
                if (rom_index == 0) begin
                    lcd_data = CLEAR_DISPLAY;
                    lcd_rs = 0;
                    lcd_rw = 0;
                    lcd_en = 1;
                    done = done;
                    rom_index = 0;
                    display_pos = 0;
                    next_state = SETTING_COMMAND;
                    lcd_en = 0;
                end
            end

            SETTING_COMMAND: begin
                lcd_data = ENTRY_MODE_SET;
                lcd_rs = 0;
                lcd_rw = 0;
                lcd_en = 1;
                done = done;
                rom_index = 0;
                display_pos = 0;
                next_state = SEND_DATA;
                lcd_en = 0;
            end

            SEND_DATA: begin
                // Display characters from ROM
                done = done;
                if (rom_index < 7) begin
                    lcd_data = rom[rom_index];  // Get character from ROM
                    lcd_rs = 1;  // Data mode
                    lcd_rw = 0;  // Write mode
                    lcd_en = 1;
                    rom_index = rom_index + 1;
                end else begin
                    // Cursor moves to the next line if the screen is full
                    //lcd_data = CURSOR_LEFT;
                    lcd_data = lcd_data;
                    lcd_rs = 0; 
                    lcd_rw = 0;
                    lcd_en = 1;
                    display_pos = 0;
                    rom_index = 0;
                    next_state = DONE;
                end
                lcd_en = 0;
            end

            DONE: begin
                lcd_rs = lcd_rs;
                lcd_rw = lcd_rw;
                lcd_en = lcd_en;
                display_pos = display_pos;
                rom_index = rom_index;
                done = 1;  // Indicate that the word has been displayed
                next_state = IDLE; // Wait for reset
            end
        endcase
    end

endmodule
