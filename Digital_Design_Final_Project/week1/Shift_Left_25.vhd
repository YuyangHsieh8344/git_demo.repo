library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 
use ieee.math_real.all; 

entity Shift_Left_25 is
generic(
    width : positive := 32
    );
port(
    in1: in std_logic_vector(25 downto 0);
    output : out std_logic_vector(27 downto 0)
);
end Shift_Left_25;

architecture bhv of Shift_Left_25 is 


begin 

    process(in1)
	
	variable size_up : std_logic_vector(27 downto 0);
    begin 
		size_up := std_logic_vector(resize(unsigned(in1), 28));
		output <= std_logic_vector(shift_left(unsigned(size_up),2));   

end process;

end bhv;