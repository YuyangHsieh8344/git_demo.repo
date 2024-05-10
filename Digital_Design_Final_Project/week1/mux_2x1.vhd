library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_2x1 is 
	generic (
	width : positive := 32);
	port (
	in1, in2 : in std_logic_vector(width-1 downto 0);
	sel : in std_logic;
	output : out std_logic_vector(width-1 downto 0)
	);
	
	
end mux_2x1;


architecture bhv of mux_2x1 is 

begin 

	process(sel, in1, in2)
	begin 
		case sel is 
			when '0' =>
				output <= in1;
			when '1' => 
				output <= in2;
				
			when others => null;
		end case;
end process;

end bhv;
	
	
