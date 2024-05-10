library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mips_tb is
end  mips_tb;

architecture TB of  mips_tb is

  constant WIDTH   : positive := 32;
  constant TIMEOUT : time     := 1 ms;

  signal clk_en   : std_logic := '1';
  signal clk      : std_logic := '0';
  signal rst      : std_logic := '1';
  signal button0  :  std_logic := '0';
  signal switches : std_logic_vector(9 downto 0) := "0000000000";
	--top level/interface outputs
  signal leds 	  : std_logic_vector(width-1 downto 0);

	

begin

U_mp : entity work.mips_processor
generic map( 
width => width)
port map(
	clk => clk,
	rst => rst,
	button_processor => button0,
	switches => switches,
	led => leds
);

clk <= not clk and clk_en after 20 ns;

process
begin 

wait for 100 ns;
rst <= '0';

    wait for 40 ns;
            rst <= '0';
            --switches <= "0000010000";   --16
			--switches <= "0000001000";   --8
			--switches   <= "0001001110";    --78
			switches  <=  "0100000000";     --256
			
            button0 <= '1';
        wait for 40 ns;
            rst <= '0';
            --switches <= "1000000011";    --3 
			--switches <= "1000000100";    --4
			--switches <= "1000000010";    --2
			--switches   <= "1000010010";     --18
			switches   <=  "1001000000";   --64
            button0 <= '1';
        
        wait for 40 ns;
	
 end process;

end TB;