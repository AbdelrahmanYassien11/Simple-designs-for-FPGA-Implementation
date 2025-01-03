module smartwatch(
	input clk, reset,
    input [5:0] alarm_minutes,
    input [4:0] alarm_hours,
    // input [5:0] seconds_initial, minutes_initial,
    input [4:0] hours_initial,

	input start_stopwatch, reset_stopwatch,

	output [6:0] clock_second1_display,
	output [6:0] clock_second2_display,

	output [6:0] clock_minute1_display,
	output [6:0] clock_minute2_display,

	output [6:0] clock_hour1_display,
	output [6:0] clock_hour2_display,

	output digitalwatch_alarm_flash,

	output [6:0] stopwatch_second1_display,
	output [6:0] stopwatch_second2_display
);

	wire [5:0] digitalwatch_second_count;
	wire [5:0] digitalwatch_minute_count;
	wire [4:0] digitalwatch_hour_count;

	wire [6:0] stopwatch_second_count;

	digitalwatch digitalwatch1 (
		.clk(clk),
		.reset(reset),
		.alarm_minutes(alarm_minutes),
		.alarm_hours(alarm_hours),
		// .seconds_initial(seconds_initial),
		// .minutes_initial(minutes_initial),
		.hours_initial(hours_initial),
		.second_count(digitalwatch_second_count),
		.minute_count(digitalwatch_minute_count),
		.hour_count(digitalwatch_hour_count),
		.alarm_flash(digitalwatch_alarm_flash)
	);

	stopwatch stopwatch1(
		.clk(clk),
		.reset(reset),
		.start(start_stopwatch),
		.reset_stopwatch(reset_stopwatch),
		.seconds(stopwatch_second_count)
	);


	sevensegment sevensegment1(
		.reset(reset),

		.digitalwatch_second(digitalwatch_second_count),
		.digitalwatch_minute(digitalwatch_minute_count),
		.digitalwatch_hour(digitalwatch_hour_count),

		.stopwatch_second(stopwatch_second_count),
		.start_stopwatch(start_stopwatch),
		.reset_stopwatch(reset_stopwatch),

		// .seconds_initial(seconds_initial),
		// .minutes_initial(minutes_initial),
		.hours_initial(hours_initial),

		.clock_second1_display(clock_second1_display),
		.clock_second2_display(clock_second2_display),
		.clock_minute1_display(clock_minute1_display),
		.clock_minute2_display(clock_minute2_display),
		.clock_hour1_display(clock_hour1_display),
		.clock_hour2_display(clock_hour2_display),

		.stopwatch_second1_display(stopwatch_second1_display),
		.stopwatch_second2_display(stopwatch_second2_display)

	);
endmodule