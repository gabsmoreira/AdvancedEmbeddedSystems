	component unsaved is
		port (
			clk_clk                   : in    std_logic                    := 'X';             -- clk
			key_export                : in    std_logic_vector(3 downto 0) := (others => 'X'); -- export
			leds_writeresponsevalid_n : out   std_logic_vector(3 downto 0);                    -- writeresponsevalid_n
			reset_reset_n             : in    std_logic                    := 'X';             -- reset_n
			ps2_data_ps2_data         : inout std_logic                    := 'X';             -- ps2_data
			ps2_clk_ps2_clk           : inout std_logic                    := 'X'              -- ps2_clk
		);
	end component unsaved;

	u0 : component unsaved
		port map (
			clk_clk                   => CONNECTED_TO_clk_clk,                   --      clk.clk
			key_export                => CONNECTED_TO_key_export,                --      key.export
			leds_writeresponsevalid_n => CONNECTED_TO_leds_writeresponsevalid_n, --     leds.writeresponsevalid_n
			reset_reset_n             => CONNECTED_TO_reset_reset_n,             --    reset.reset_n
			ps2_data_ps2_data         => CONNECTED_TO_ps2_data_ps2_data,         -- ps2_data.ps2_data
			ps2_clk_ps2_clk           => CONNECTED_TO_ps2_clk_ps2_clk            --  ps2_clk.ps2_clk
		);

