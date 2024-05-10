library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 
use ieee.math_real.all; 

entity Shift_Left_2 is
generic(
    width : positive := 32
    );
port(
    in1: in std_logic_vector(width-1 downto 0);
    output : out std_logic_vector(width-1 downto 0)
);
end Shift_Left_2;

architecture bhv of Shift_Left_2 is 

begin 

    process(in1)
    begin 

		output <= std_logic_vector(shift_left(unsigned(in1),2));

end process;

end bhv;