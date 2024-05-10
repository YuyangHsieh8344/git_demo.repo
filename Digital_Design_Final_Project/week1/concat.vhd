library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 
use ieee.math_real.all; 

entity Concat is
generic(
    width : positive := 32
    );
port(
    in1        : in std_logic_vector(27 downto 0);
    in2        : in std_logic_vector(31 downto 28);
    output  : out std_logic_vector(width-1 downto 0)
);
end Concat;

architecture bhv of Concat is 

begin 

    process(in1,in2)
    begin 

        output <= std_logic_vector(unsigned(in2) & unsigned(in1));  --32

end process;

end bhv;