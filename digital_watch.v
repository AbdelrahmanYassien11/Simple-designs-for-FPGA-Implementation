module digitalwatch(
    input wire clk,         // إشارة الساعة
    input wire reset,       // إشارة إعادة التعيين
    input [5:0] alarm_minutes,
    input [4:0] alarm_hours,
    // input [5:0] seconds_initial, minutes_initial,
    input [4:0] hours_initial,
    output reg [5:0] second_count,
    output reg [5:0] minute_count,
    output reg [4:0] hour_count,
    output reg alarm_flash
);

integer freq_div;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        // second_count <= seconds_initial;
        // minute_count <= minutes_initial;
        second_count <= 0;
        minute_count <= 0;
        hour_count <= hours_initial;
    end 
    else begin
        // زيادة الثانية
        if (second_count == 60) begin
            second_count <= 0;
            // زيادة الدقيقة
            if (minute_count == 60) begin
                minute_count <= 0;
                // زيادة الساعة
                if (hour_count == 24) begin
                    hour_count <= 0;
                end 
                else begin
                    hour_count <= hour_count + 1;
                end
            end 
            else begin
                minute_count <= minute_count + 1;
			end
		end
		else begin
			if(freq_div == 17_000_000) begin
				second_count <= second_count + 1;
			end
			else begin
				second_count <= second_count;
			end
        end
    end
end

always@(minute_count or hour_count or second_count)begin
    if(reset) begin
        alarm_flash = 0;
    end
    else if ((alarm_minutes == minute_count) & (alarm_hours == hour_count)) begin
        alarm_flash = ~alarm_flash;
    end
    else begin
        alarm_flash = 0;
    end
end

always@(posedge clk or posedge reset) begin
	if(reset)begin
		freq_div <= 0;
	end
	else begin
		if(freq_div == 17_000_000) begin
			freq_div <= 0;
		end else begin
			freq_div <= freq_div +1;
		end
	end
end	


endmodule