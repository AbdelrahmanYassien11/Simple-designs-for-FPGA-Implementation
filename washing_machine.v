module washing_machine(
    input clk,
    input reset,
    input power,
    input water_full,
    input detergent_full,
    output reg wash_ongoing,
    output reg spin_ongoing,
    output reg dry_ongoing,
    output reg finished,

    output reg [2:0] state 
);

    reg [31:0] clk_div;
    reg [3:0] counter;
    parameter IDLE = 4'b0000;
    parameter WRITE_DATA = 4'b0001;
   always @(posedge clk or posedge reset) begin
      if (reset) begin
        wash_ongoing <= 0;
        spin_ongoing <= 0;
        dry_ongoing <= 0;
        clk_div <=0;
        counter <= 0;
        finished <= 0;
        state <= 3'b000; 
      end 
      else if (power) begin
        case (state)
          3'b000: begin
            wash_ongoing <= 0;
            spin_ongoing <= 0;
            dry_ongoing <= 0;
            finished <= 0;
            if(water_full && detergent_full)begin
              state <= 3'b001; // Start washing
            end
            else begin
              state <= state;
            end
          end
          3'b001: begin
            wash_ongoing <= 1;
            spin_ongoing <= 0;
            dry_ongoing <= 0;
            finished <= 0;
            if(counter == 12) begin
              state <= 3'b010; // Move to spin-dry state
              counter <= 0;
            end
            else begin
              state <= state;
              if(clk_div == 20000000) begin
                counter <= counter + 1;
                clk_div <= 0;
              end
              else begin
                clk_div <= clk_div+1;
              end
            end
          end
          3'b010: begin
            spin_ongoing <= 1;
            wash_ongoing <=0;
            dry_ongoing <= 0;
            finished <= 0;
            if(counter == 8) begin
              state <= 3'b011; 
              counter <= 0;
            end
            else begin
              if(clk_div == 20000000) begin
                counter <= counter + 1;
                clk_div <= 0;
              end
              else begin
                clk_div <= clk_div+1;
              end
            end
          end
          3'b011: begin
            dry_ongoing <= 1;
            spin_ongoing <= 0;
            wash_ongoing <=0;
            finished <= 0;
            if(counter == 8) begin
              state <= 3'b100; // Move to Idle
              dry_ongoing <= 0;
              counter <= 0;
            end
            else begin
              state <= state;
              if(clk_div == 20000000) begin
                counter <= counter + 1;
                clk_div <= 0;
              end
              else begin
                clk_div <= clk_div+1;
              end
            end
          end
          3'b100: begin
            dry_ongoing <= 0;
            spin_ongoing <= 0;
            wash_ongoing <= 0;
            finished <= 1;
          end
        endcase
      end
    end

endmodule