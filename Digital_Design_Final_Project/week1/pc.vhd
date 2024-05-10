library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc is 
	generic(
	width : positive := 32);
	port(
	clk 	: in std_logic;
	rst 	: in std_logic;
	load_n  : in std_logic;
	input   : in std_logic_vector(width-1 downto 0);
	output  : out std_logic_vector(width-1 downto 0)
	);
end pc;

architecture bhv of pc is 
begin 

process (clk, rst)

variable counter : std_logic_vector(width-1 downto 0);

begin 

	output <= counter;
	
	if (rst = '1') then 
		
		counter := std_logic_vector(to_unsigned(0,width));
	
	elsif(rising_edge(clk)) then 
		
		if (load_n = '1') then 
			
			counter := input;
	end if;
	
	end if;
end process;
end bhv;