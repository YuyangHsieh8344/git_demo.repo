library ieee;
use ieee.std_logic_1164.all;
entity mux_3x1 is
generic(
	width : positive := 32
	);
port(
	in1, in2, in3 : in std_logic_vector(width-1 downto 0);
	sel : in std_logic_vector(1 downto 0);
	output : out std_logic_vector(width-1 downto 0)
);
end mux_3x1;

architecture bhv of mux_3x1 is 

begin 

	process(sel, in1, in2, in3)
	begin 
		case sel is 
			when "00" =>
				output <= in1;
			
			when "01" =>
				output <= in2;
				
			when "10" =>
				output <= in3;
				
			when others => 
				output <= in1;
			
			end case;
			
end process;

end bhv;