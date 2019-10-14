library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use work.all;

entity ps2_e is
    generic (
        LEN  : natural := 4
    );
    port (
        -- Gloabals
        clk                : in  std_logic                     := '0';             
        reset              : in  std_logic                     := '0';             

        -- I/Os
		PS2_CLK   : inout std_logic;                    -- ps2_clock signal inout;
    	PS2_DAT   : inout std_logic;                    -- ps2_data  signal inout;

        -- Avalion Memmory Mapped Slave
        avs_address     : in  std_logic_vector(3 downto 0)  := (others => '0'); 
        avs_read        : in  std_logic                     := '0';             
        avs_readdata    : out std_logic_vector(31 downto 0) := (others => '0'); 
        avs_write       : in  std_logic                     := '0';             
        avs_writedata   : in  std_logic_vector(31 downto 0) := (others => '0')
    );
end entity ps2_e;

architecture rtl of ps2_e is


component ps2 is
   port(
    iSTART    : in    std_logic;                    -- press the button for tranxrdb -merge .Xdefaultssmitting instrucions to device;
    iRST_n    : in    std_logic;                    -- FSM reset signal;
    iCLK_50   : in    std_logic;                    -- clock source;
    PS2_CLK   : inout std_logic;                    -- ps2_clock signal inout;
    PS2_DAT   : inout std_logic;                    -- ps2_data  signal inout;
    oLEFBUT   : out   std_logic;                    -- left button press display;
    oRIGBUT   : out   std_logic;                    -- right button press display;
    oMIDBUT   : out   std_logic;                    -- middle button press display;
    oX        : out   std_logic_vector(7 downto 0); -- X axis.
    oY        : out   std_logic_vector(7 downto 0) -- Y axis.
    );
end component ps2;
  
signal oX, oY: std_logic_vector(7 downto 0);
signal iSTART, irst_n, oLEFBUT, ORIGBUT, OMIDBUT: std_logic; 

begin

u1: component ps2 port map(
    iSTART    => iSTART,
    iRST_n    => irst_n,
    iCLK_50   => clk,
    PS2_CLK   => PS2_CLK,
    PS2_DAT   => PS2_DAT,
    oLEFBUT   => oLEFBUT,
    oRIGBUT   => oRIGBUT,
    oMIDBUT   => oMIDBUT,
    oX        => oX,
    oY        => oY
  
);

process(clk)
begin
	irst_n <= not IRST_n;
    if (reset = '1') then
        iSTART <= '0';
    elsif(rising_edge(clk)) then
        if(avs_read = '1' ) then
				if(avs_address = "0000") then
					avs_readdata(0) <= iSTART;
				elsif(avs_address = "0001") then
					avs_readdata(7 downto 0) <= oX;
               avs_readdata(15 downto 8) <= oY;
					avs_readdata(16) <= oLEFBUT;
					avs_readdata(17) <= oRIGBUT;
					avs_readdata(18) <= oMIDBUT;
			   elsif(avs_address = "0010") then
					  avs_readdata <= x"A5A5A5A5";

            end if;
				
        end if;
        if(avs_address = "0000") then
            iSTART <= '1';
        end if;
        if(avs_write = '1') then
           
        end if;
    end if;
end process;

end rtl;

