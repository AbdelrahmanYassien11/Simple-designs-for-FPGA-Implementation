module sevensegment(

	input reset,
	input [5:0] digitalwatch_second, digitalwatch_minute,
	input [4:0] digitalwatch_hour,
	input [6:0] stopwatch_second,

	// input [5:0] seconds_initial, minutes_initial,
    input [4:0] hours_initial,


	input start_stopwatch, reset_stopwatch,

	output reg [6:0]  clock_second1_display,
	output reg [6:0]  clock_second2_display,

	output reg [6:0]  clock_minute1_display,
	output reg [6:0]  clock_minute2_display,

	output reg [6:0]  clock_hour1_display,
	output reg [6:0]  clock_hour2_display,

	output reg [6:0]  stopwatch_second1_display,
	output reg [6:0]  stopwatch_second2_display

);

	reg [6:0] digitalwatch_seconds_reg1;
	reg [6:0] digitalwatch_seconds_reg2;

	reg [6:0] digitalwatch_minutes_reg1;
	reg [6:0] digitalwatch_minutes_reg2;

	reg [6:0] digitalwatch_hours_reg1;
	reg [6:0] digitalwatch_hours_reg2;


	reg [6:0] stopwatch_seconds_reg1;
	reg [6:0] stopwatch_seconds_reg2;

	reg [6:0] stopwatch_minutes_reg1;
	reg [6:0] stopwatch_minutes_reg2;

		
		// إعداد الأرقام للعرض
		// تحويل الرقم إلى تنسيق سبعة segmentos
	always@(*) begin
		if(reset) begin
			// digitalwatch_seconds_reg1 = seconds_initial % 10;
			// digitalwatch_seconds_reg2 = seconds_initial / 10;
			 digitalwatch_seconds_reg1 = 0;
			 digitalwatch_seconds_reg2 = 0;
		    case (digitalwatch_seconds_reg1)
		        0: clock_second1_display = 7'b1000000;  // 0
		        1: clock_second1_display = 7'b1111001;  // 1
		        2: clock_second1_display = 7'b0100100;  // 2
		        3: clock_second1_display = 7'b0110000;  // 3
		        4: clock_second1_display = 7'b0011001;  // 4
		        5: clock_second1_display = 7'b0010010;  // 5
		        6: clock_second1_display = 7'b0000010;  // 6
		        7: clock_second1_display = 7'b1111000;  // 7
		        8: clock_second1_display = 7'b0000000;  // 8
		        9: clock_second1_display = 7'b0010000;  // 9
		        default: clock_second1_display = 7'b1111111; // إيقاف العرض
		    endcase
			 case (digitalwatch_seconds_reg2)
		        0: clock_second2_display = 7'b1000000;  // 0
		        1: clock_second2_display = 7'b1111001;  // 1
		        2: clock_second2_display = 7'b0100100;  // 2
		        3: clock_second2_display = 7'b0110000;  // 3
		        4: clock_second2_display = 7'b0011001;  // 4
		        5: clock_second2_display = 7'b0010010;  // 5
		        6: clock_second2_display = 7'b0000010;  // 6
		        7: clock_second2_display = 7'b1111000;  // 7
		        8: clock_second2_display = 7'b0000000;  // 8
		        9: clock_second2_display = 7'b0010000;  // 9
		        default: clock_second2_display = 7'b1111111; // إيقاف العرض
		    endcase
		end
		else begin
		 	digitalwatch_seconds_reg1 = digitalwatch_second % 10;
		 	digitalwatch_seconds_reg2 = digitalwatch_second / 10 ;      
	      // seconds_reg3 = second_count / 100 ;  
		 
	    case (digitalwatch_seconds_reg1)
	        0: clock_second1_display = 7'b1000000;  // 0
	        1: clock_second1_display = 7'b1111001;  // 1
	        2: clock_second1_display = 7'b0100100;  // 2
	        3: clock_second1_display = 7'b0110000;  // 3
	        4: clock_second1_display = 7'b0011001;  // 4
	        5: clock_second1_display = 7'b0010010;  // 5
	        6: clock_second1_display = 7'b0000010;  // 6
	        7: clock_second1_display = 7'b1111000;  // 7
	        8: clock_second1_display = 7'b0000000;  // 8
	        9: clock_second1_display = 7'b0010000;  // 9
	        default: clock_second1_display = 7'b1111111; // إيقاف العرض
	    endcase
		 case (digitalwatch_seconds_reg2)
	        0: clock_second2_display = 7'b1000000;  // 0
	        1: clock_second2_display = 7'b1111001;  // 1
	        2: clock_second2_display = 7'b0100100;  // 2
	        3: clock_second2_display = 7'b0110000;  // 3
	        4: clock_second2_display = 7'b0011001;  // 4
	        5: clock_second2_display = 7'b0010010;  // 5
	        6: clock_second2_display = 7'b0000010;  // 6
	        7: clock_second2_display = 7'b1111000;  // 7
	        8: clock_second2_display = 7'b0000000;  // 8
	        9: clock_second2_display = 7'b0010000;  // 9
	        default: clock_second2_display = 7'b1111111; // إيقاف العرض
	    endcase
		 
		end
	end

	always@(*)begin
		if(reset) begin
			// digitalwatch_minutes_reg1 = minutes_initial % 10;
			// digitalwatch_minutes_reg2 = minutes_initial / 10;
			digitalwatch_minutes_reg1 = 0;
			digitalwatch_minutes_reg2 = 0;
		    case (digitalwatch_minutes_reg1)
		        0: clock_minute1_display = 7'b1000000;  // 0
		        1: clock_minute1_display = 7'b1111001;  // 1
		        2: clock_minute1_display = 7'b0100100;  // 2
		        3: clock_minute1_display = 7'b0110000;  // 3
		        4: clock_minute1_display = 7'b0011001;  // 4
		        5: clock_minute1_display = 7'b0010010;  // 5
		        6: clock_minute1_display = 7'b0000010;  // 6
		        7: clock_minute1_display = 7'b1111000;  // 7
		        8: clock_minute1_display = 7'b0000000;  // 8
		        9: clock_minute1_display = 7'b0010000;  // 9
		        default: clock_minute1_display = 7'b1111111; // إيقاف العرض
		    endcase
			 
		    case (digitalwatch_minutes_reg2)
		        0: clock_minute2_display = 7'b1000000;  // 0
		        1: clock_minute2_display = 7'b1111001;  // 1
		        2: clock_minute2_display = 7'b0100100;  // 2
		        3: clock_minute2_display = 7'b0110000;  // 3
		        4: clock_minute2_display = 7'b0011001;  // 4
		        5: clock_minute2_display = 7'b0010010;  // 5
		        6: clock_minute2_display = 7'b0000010;  // 6
		        7: clock_minute2_display = 7'b1111000;  // 7
		        8: clock_minute2_display = 7'b0000000;  // 8
		        9: clock_minute2_display = 7'b0010000;  // 9
		        default: clock_minute2_display = 7'b1111111; // إيقاف العرض
		    endcase			
		end
		else begin
		 digitalwatch_minutes_reg1 = digitalwatch_minute % 10;
		 digitalwatch_minutes_reg2 = digitalwatch_minute / 10;
	    case (digitalwatch_minutes_reg1)
	        0: clock_minute1_display = 7'b1000000;  // 0
	        1: clock_minute1_display = 7'b1111001;  // 1
	        2: clock_minute1_display = 7'b0100100;  // 2
	        3: clock_minute1_display = 7'b0110000;  // 3
	        4: clock_minute1_display = 7'b0011001;  // 4
	        5: clock_minute1_display = 7'b0010010;  // 5
	        6: clock_minute1_display = 7'b0000010;  // 6
	        7: clock_minute1_display = 7'b1111000;  // 7
	        8: clock_minute1_display = 7'b0000000;  // 8
	        9: clock_minute1_display = 7'b0010000;  // 9
	        default: clock_minute1_display = 7'b1111111; // إيقاف العرض
	    endcase
		 
	    case (digitalwatch_minutes_reg2)
	        0: clock_minute2_display = 7'b1000000;  // 0
	        1: clock_minute2_display = 7'b1111001;  // 1
	        2: clock_minute2_display = 7'b0100100;  // 2
	        3: clock_minute2_display = 7'b0110000;  // 3
	        4: clock_minute2_display = 7'b0011001;  // 4
	        5: clock_minute2_display = 7'b0010010;  // 5
	        6: clock_minute2_display = 7'b0000010;  // 6
	        7: clock_minute2_display = 7'b1111000;  // 7
	        8: clock_minute2_display = 7'b0000000;  // 8
	        9: clock_minute2_display = 7'b0010000;  // 9
	        default: clock_minute2_display = 7'b1111111; // إيقاف العرض
	    endcase
		end
	end

	always@(*)begin
		if(reset) begin
			// digitalwatch_hours_reg1 = hours_initial % 10;
			// digitalwatch_hours_reg2 = hours_initial / 10;
			 digitalwatch_hours_reg1 = 0;
			 digitalwatch_hours_reg2 = 0;
		    case (digitalwatch_hours_reg1)
		        0: clock_hour1_display = 7'b1000000;  // 0
		        1: clock_hour1_display = 7'b1111001;  // 1
		        2: clock_hour1_display = 7'b0100100;  // 2
		        3: clock_hour1_display = 7'b0110000;  // 3
		        4: clock_hour1_display = 7'b0011001;  // 4
		        5: clock_hour1_display = 7'b0010010;  // 5
		        6: clock_hour1_display = 7'b0000010;  // 6
		        7: clock_hour1_display = 7'b1111000;  // 7
		        8: clock_hour1_display = 7'b0000000;  // 8
		        9: clock_hour1_display = 7'b0010000;  // 9
		        default: clock_hour1_display = 7'b1111111; // إيقاف العرض
		    endcase
			 
			case (digitalwatch_hours_reg2)
		        0: clock_hour2_display = 7'b1000000;  // 0
		        1: clock_hour2_display = 7'b1111001;  // 1
		        2: clock_hour2_display = 7'b0100100;  // 2
		        3: clock_hour2_display = 7'b0110000;  // 3
		        4: clock_hour2_display = 7'b0011001;  // 4
		        5: clock_hour2_display = 7'b0010010;  // 5
		        6: clock_hour2_display = 7'b0000010;  // 6
		        7: clock_hour2_display = 7'b1111000;  // 7
		        8: clock_hour2_display = 7'b0000000;  // 8
		        9: clock_hour2_display = 7'b0010000;  // 9
		        default: clock_hour2_display = 7'b1111111; // إيقاف العرض
		    endcase			
		end
		else begin
		 digitalwatch_hours_reg1 = digitalwatch_hour % 10;
		 digitalwatch_hours_reg2 = digitalwatch_hour / 10;
	    case (digitalwatch_hours_reg1)
	        0: clock_hour1_display = 7'b1000000;  // 0
	        1: clock_hour1_display = 7'b1111001;  // 1
	        2: clock_hour1_display = 7'b0100100;  // 2
	        3: clock_hour1_display = 7'b0110000;  // 3
	        4: clock_hour1_display = 7'b0011001;  // 4
	        5: clock_hour1_display = 7'b0010010;  // 5
	        6: clock_hour1_display = 7'b0000010;  // 6
	        7: clock_hour1_display = 7'b1111000;  // 7
	        8: clock_hour1_display = 7'b0000000;  // 8
	        9: clock_hour1_display = 7'b0010000;  // 9
	        default: clock_hour1_display = 7'b1111111; // إيقاف العرض
	    endcase
		 
		case (digitalwatch_hours_reg2)
	        0: clock_hour2_display = 7'b1000000;  // 0
	        1: clock_hour2_display = 7'b1111001;  // 1
	        2: clock_hour2_display = 7'b0100100;  // 2
	        3: clock_hour2_display = 7'b0110000;  // 3
	        4: clock_hour2_display = 7'b0011001;  // 4
	        5: clock_hour2_display = 7'b0010010;  // 5
	        6: clock_hour2_display = 7'b0000010;  // 6
	        7: clock_hour2_display = 7'b1111000;  // 7
	        8: clock_hour2_display = 7'b0000000;  // 8
	        9: clock_hour2_display = 7'b0010000;  // 9
	        default: clock_hour2_display = 7'b1111111; // إيقاف العرض
	    endcase
		end
	end






    always@(stopwatch_second) begin
        if(reset) begin
            stopwatch_second1_display = 7'b1000000; 
        end
        else if (reset_stopwatch) begin
            stopwatch_second1_display = 7'b1000000;
        end
        else begin
            stopwatch_seconds_reg1 = stopwatch_second % 10;
            case(stopwatch_seconds_reg1)
                0: stopwatch_second1_display = 7'b1000000;  // 0
                1: stopwatch_second1_display = 7'b1111001;  // 1
                2: stopwatch_second1_display = 7'b0100100;  // 2
                3: stopwatch_second1_display = 7'b0110000;  // 3
                4: stopwatch_second1_display = 7'b0011001;  // 4
                5: stopwatch_second1_display = 7'b0010010;  // 5
                6: stopwatch_second1_display = 7'b0000010;  // 6
                7: stopwatch_second1_display = 7'b1111000;  // 7
                8: stopwatch_second1_display = 7'b0000000;  // 8
                9: stopwatch_second1_display = 7'b0010000;  // 9
                default: stopwatch_second1_display = 7'b1111111;
            endcase
        end
    end

    always@(stopwatch_second) begin
        if(reset) begin
            stopwatch_second2_display = 7'b1000000; 
        end
        else if (reset_stopwatch) begin
            stopwatch_second2_display = 7'b1000000;
        end
        else begin
            stopwatch_seconds_reg2 = stopwatch_second / 10;
            case(stopwatch_seconds_reg2) 
                0: stopwatch_second2_display = 7'b1000000;  // 0
                1: stopwatch_second2_display = 7'b1111001;  // 1
                2: stopwatch_second2_display = 7'b0100100;  // 2
                3: stopwatch_second2_display = 7'b0110000;  // 3
                4: stopwatch_second2_display = 7'b0011001;  // 4
                5: stopwatch_second2_display = 7'b0010010;  // 5
                6: stopwatch_second2_display = 7'b0000010;  // 6
                7: stopwatch_second2_display = 7'b1111000;  // 7
                8: stopwatch_second2_display = 7'b0000000;  // 8
                9: stopwatch_second2_display = 7'b0010000;  // 9
                default: stopwatch_second2_display = 7'b1111111;
            endcase
        end
    end

endmodule