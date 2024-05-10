library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 
use ieee.math_real.all; 

entity zero_extend is
generic(
    width : positive := 32
    );
port(
    in1: in std_logic_vector(9 downto 0);
    output : out std_logic_vector(width-1 downto 0)
);
end zero_extend;

architecture bhv of zero_extend is 

begin 

    process(in1)
    begin 

        output <= (31 downto in1'length => '0') & in1;

end process;

end bhv;