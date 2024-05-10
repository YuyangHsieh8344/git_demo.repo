library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity regist_fp is 
	generic (
	width : positive := 32);
	port (
	in1 	: in std_logic_vector(width-1 downto 0);
	enable 	: in std_logic;
	clk 	: in std_logic;
	output 	: out std_logic_vector(width-1 downto 0);
	rst : in std_logic
	);
	
	
end regist_fp;



architecture bhv of regist_fp is 

begin 

	process(clk, rst)
	begin 
	if (rst ='1') then 
		output <= std_logic_vector(to_unsigned(0,width));

		elsif (clk = '1' and clk'event) then		
			if(enable = '1') then
				output <= in1;
		end if;
	end if;
	
end process;

end bhv;