
module unsaved (
	clk_clk,
	key_export,
	leds_writeresponsevalid_n,
	reset_reset_n,
	ps2_data_ps2_data,
	ps2_clk_ps2_clk);	

	input		clk_clk;
	input	[3:0]	key_export;
	output	[3:0]	leds_writeresponsevalid_n;
	input		reset_reset_n;
	inout		ps2_data_ps2_data;
	inout		ps2_clk_ps2_clk;
endmodule
