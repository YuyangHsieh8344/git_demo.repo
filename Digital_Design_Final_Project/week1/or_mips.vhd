library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 
use ieee.math_real.all;


entity or_mips is

port(
    in1    : in std_logic;
	in2    : in std_logic;
    output : out std_logic
);
end or_mips;

architecture bhv of or_mips is 

begin 

    process(in1, in2)
    begin 

        output <= in1 or in2;

end process;

end bhv;