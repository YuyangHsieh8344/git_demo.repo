library ieee;
use ieee.std_logic_1164.all;
entity mux_4x1 is
generic(
	width : positive := 32
	);
port(
	in1, in2, in3, in4 : in std_logic_vector(width-1 downto 0);
	sel : in std_logic_vector(1 downto 0);
	output : out std_logic_vector(width-1 downto 0)
);
end mux_4x1;

architecture bhv of mux_4x1 is 

begin 

	process(sel, in1, in2, in3, in4)
	begin 
		case sel is 
			when "00" =>
				output <= in1;
			
			when "01" =>
				output <= in2;
				
			when "10" =>
				output <= in3;
			
			when "11" =>
				output <= in4;
				
			when others  => null;
			
			end case;
			
end process;

end bhv;