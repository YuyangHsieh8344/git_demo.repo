library ieee;
use ieee.std_logic_1164.all;
entity mux_7x1 is
generic(
	width : positive := 32
	);
port(
	in1, in2, in3, in4, in5, in6, in7 : in std_logic_vector(width-1 downto 0);
	sel : in std_logic_vector(2 downto 0);
	output : out std_logic_vector(width-1 downto 0)
);
end mux_7x1;

architecture bhv of mux_7x1 is 

begin 

	process(sel, in1, in2, in3, in4, in5, in6, in7)
	begin 
		case sel is 
			when "000" =>
				output <= in1;
			
			when "001" =>
				output <= in2;
				
			when "010" =>
				output <= in3;
			
			when "011" =>
				output <= in4;
				
			when "100" =>
				output <= in5;
			
			when "101" =>
				output <= in6;
			
			when "110" =>
				output <= in7;
				
			when others  => 
					output <= in1;
			
			end case;
			
end process;

end bhv;