library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Entrega1 is
	port (
			sw:   in  std_logic_vector(3 downto 0);
			key:   in  std_logic_vector(1 downto 0);
			clk: in  std_logic;
			LED:   out std_logic_vector(5 downto 0)
			);
end entity;

architecture arch_entrega of Entrega1 is
	component LED_peripheral is
		port (
				 -- Gloabals
				  fpga_clk_50   : in  std_logic;
				  en            : in std_logic_vector(1 downto 0);
				  freq          : in std_logic_vector(3 downto 0);
				  
				  -- I/Os
				  LEDs          : out std_logic_vector(5 downto 0)
				);
	end component;
	begin
		 LED_out: LED_peripheral port map (clk, key, sw, LED);
	    
end arch_entrega;