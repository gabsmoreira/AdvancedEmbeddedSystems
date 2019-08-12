library IEEE;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_1164.all;

entity LED_peripheral is
	generic (
				OFFSET: integer := 0
	
				);

    port (
        -- Gloabals
        fpga_clk_50   : in  std_logic;
		  en            : in std_logic;
		  freq          : in std_logic_vector(3 downto 0);
		  
        -- I/Os
        LEDs          : out std_logic_vector(5 downto 0)
		  );
end entity LED_peripheral;

architecture arch_LED_peripheral of LED_peripheral is

-- signal
signal blink  : std_logic := '0';


begin

  process(fpga_clk_50) 
      variable counter : integer range 0 to 25000000 := 0;
      begin
        if (rising_edge(fpga_clk_50)) then
                  if (counter < 20000000) then
                      counter := counter + to_integer(unsigned(freq)) + OFFSET;
                  else
                      blink <= not blink;
                      counter := 0;
                  end if;
        end if;
  end process;
  
  LEDs(0) <= blink and en;
  LEDs(1) <= blink and en;
  LEDs(2) <= blink and en;
  LEDs(3) <= blink and en;
  LEDs(4) <= blink and en;
  LEDs(5) <= blink and en;

end arch_LED_peripheral;