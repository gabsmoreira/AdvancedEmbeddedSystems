library IEEE;
use IEEE.std_logic_1164.all;

entity topLevel is
    port (
        -- Gloabals
        fpga_clk_50        : in  std_logic;             -- clock.clk
		  
        -- I/Os
        fpga_led_pio       : out std_logic_vector(5 downto 0);
		  fpga_key_pio       : in std_logic_vector(3 downto 0)
		  
	);
end entity topLevel;

architecture rtl of topLevel is

component unsaved is port (
  clk_clk       : in  std_logic                    := 'X'; -- clk
  reset_reset_n : in  std_logic                    := 'X'; -- reset_n
  leds_export   : out std_logic_vector(5 downto 0);         -- export
  key_export    : in  std_logic_vector(3 downto 0) := (others => 'X') -- export
);
end component unsaved;

begin
 
u0 : component unsaved port map (
  clk_clk       => fpga_clk_50,    --  clk.clk
  reset_reset_n => '1',            --  reset.reset_n
  leds_export   => fpga_led_pio,   --  leds.export
  key_export => fpga_key_pio
  
  
);
	
end rtl;
