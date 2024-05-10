library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all; 

entity sign_extend is 
    generic (
    width : positive := 32);
    port (
    in1 : in std_logic_vector(15 downto 0);
    en: in std_logic;
    output : out std_logic_vector(31 downto 0)
    );


end sign_extend;



architecture bhv of sign_extend is 

signal new_out : std_logic_vector(width-1 downto 0);
begin 

    process(en, in1)
    begin 
        if (en = '1') then
            output <= std_logic_vector(resize(signed(in1), new_out'length));


        else 
            output <= (31 downto in1'length => '0') & in1;
        end if;
end process;

end bhv;
