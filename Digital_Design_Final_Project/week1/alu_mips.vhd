library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity alu_mips is 
generic ( 
WIDTH : positive := 32
); 

port ( 
input1 	 	: in std_logic_vector(WIDTH-1 downto 0); 
input2  	: in std_logic_vector(WIDTH-1 downto 0); 
IR 		 	: in std_logic_vector(10 downto 6); 
OPSelect 	: in std_logic_vector(5 downto 0);
output 	 	: out std_logic_vector(WIDTH-1 downto 0);
output_high : out std_logic_vector(2*width-1 downto width);
Branch 	 	: out std_logic

); 
end alu_mips;

architecture BHV of alu_mips is
begin


process (input1, input2, IR, OPSelect)
		variable temp_add, temp_sub	: unsigned(width-1 downto 0);
		--variable temp_mult, holder : unsigned(2*width-1 downto 0);
		--variable temp_mult_s, holder_s : signed(2*width-1 downto 0);
		variable temp_mult, temp_mult_s  : std_logic_vector(2*width-1 downto 0);
		variable temp_left, temp_right : unsigned(width-1 downto 0);
		variable holder1  : unsigned(width-1 downto 0);
		variable holder1_s  : signed(width-1 downto 0);
		--variable twocomp : unsigned(width-1 downto 0);
		variable branch_temp : unsigned(width-1 downto 0);
		
		variable shiftbit : std_logic;
		variable tempASR  : std_logic_vector(width-1 downto 0);
		
		
	
begin 
	Branch <= '0';
	output_high <= std_logic_vector(to_unsigned(0, width));
	output <= std_logic_vector(to_unsigned(0, width));
	
	case OPSelect is 
		--input1 + input2   answer is 44 +  overflow (256) 
		when "000000" => 
			temp_add := unsigned(input1) + unsigned(input2);
			output <= std_logic_vector(temp_add);
		
		--input1 - input2
		when "000001" =>
			temp_sub := unsigned(input1) - unsigned(input2);
			output <= std_logic_vector(temp_sub);
		
		--mult input1 input2 (signed)
		when "000010" =>
			temp_mult_s := (others => '0');
			temp_mult_s := std_logic_vector(signed(input1) * signed(input2));
			
			--holder_s := shift_right(temp_mult_s, width);
			--holder1_s := resize(holder_s, width);
			
			output <= std_logic_vector(temp_mult_s(width-1 downto 0));
			output_high <= std_logic_vector(temp_mult_s(2*width-1 downto width));
		
		--mult input1 input2 (unsigned)		
		when "000011" =>
			temp_mult := (others => '0');
			temp_mult := std_logic_vector(signed(input1) * signed(input2));
			
			--holder :=  shift_right(temp_mult, width);
			--holder1 := resize(holder, width);
			
			output <= std_logic_vector(temp_mult(width-1 downto 0));
			output_high <= std_logic_vector(temp_mult(2*width-1 downto width));
			
		--AND
		when "000100" => 
			 output <= input1 and input2;
		
		--OR
		when "000101" => 
			output <= input1 or input2;
		
		--XOR
		when "000110" => 
			output <= input1 xor input2;
		
		--logic shift right (mult by 2)
		when "000111" => 
			output <= std_logic_vector(shift_right(unsigned(input2), to_integer(unsigned(IR))));
			output_high <= (others => '1');
			Branch <= '0';
			
		--logic shift left (divide by 2)
		when "001000" => 
			output <= std_logic_vector(shift_left(unsigned(input2), to_integer(unsigned(IR))));
			output_high <= (others => '1');
			Branch <= '0';
			
			
		--arithmetic shift right
		when "001001" => 
			tempASR := input2;
			shiftbit := tempASR(31);
			tempASR := std_logic_vector(shift_right(unsigned(tempASR), to_integer(unsigned(IR))));
			tempASR(31 downto (31 - to_integer(unsigned(IR)))) := (others => shiftbit);
			
			
			output <= tempASR;
			output_high <= (others => '1');
			Branch <= '0';
			
			
		--set if input1 > input2 signed 		
		when "001010" => 
			if (signed(input1) >= signed(input2)) then 
				output <= std_logic_vector(to_unsigned(0, width));
			elsif(signed(input1) < signed(input2)) then  
				output <= std_logic_vector(to_unsigned(1, width));
			end if;
		
		--set if input1 > input2 unsigned 		
		when "001011" =>
			if (unsigned(input1) >= unsigned(input2)) then 
				output <= std_logic_vector(to_unsigned(0, width));
			elsif( unsigned(input1) < unsigned(input2)) then  
				output <= std_logic_vector(to_unsigned(1, width));
			end if;
			
		
		--6 branches case
		--branch on equal (17)
		when "010001" =>
			temp_add := unsigned(input1) + unsigned(input2);
			output <= std_logic_vector(temp_add);
			if (unsigned(input1) = unsigned(input2)) then
				Branch <= '1';
			else 
				Branch <= '0';
			end if;
			
		
		--branch not equal (18)
		when "010010" => 
			temp_add := unsigned(input1) + unsigned(input2);
			output <= std_logic_vector(temp_add);
			if (unsigned(input1) /=  unsigned(input2)) then
				Branch <= '1';
			else 
				Branch <= '0';
			end if;
		
		--Branch on less than or equal to 0 (19)
		when "010011" =>
			temp_add := unsigned(input1) + unsigned(input2);
			output <= std_logic_vector(temp_add);
			if (unsigned(input1) <= 0) then 
				Branch <= '1';		
			else
				Branch <=  '0';			
			end if;
		
		--branch on greater than 0 (20)
		when "010100" => 
			temp_add := unsigned(input1) + unsigned(input2);
			output <= std_logic_vector(temp_add);
			if (unsigned(input1) > 0) then 
				Branch <= '1';		
			else
				Branch <=  '0';			
			end if;
		
		--branch on less than zero (21)	
		when "010101" =>
			temp_add := unsigned(input1) + unsigned(input2);
			output <= std_logic_vector(temp_add);
			if (unsigned(input1) < 0) then 
				Branch <= '1';		
			else
				Branch <=  '0';			
			end if;
		
		--branch on greater than or equal to zero (22)
		when "010110" => 
			temp_add := unsigned(input1) + unsigned(input2);
			output <= std_logic_vector(temp_add);
			if (unsigned(input1) >= 0) then 
				Branch <= '1';		
			else
				Branch <=  '0';			
			end if;
		
		
		when "010111" =>
		
		
		
		when "001111" => 
			output <= std_logic_vector(shift_left(unsigned(input1),2));
			output_high <= (others => '0');
		
		--store word (cal mem address for SW)
		when "010000" => 
			output <= std_logic_vector(unsigned(input2)-4);
			output_high <= (others => '0');
			
			
		when others =>
		
		output <= (others => '0');
		output_high <= (others => '0');
		
	end case;
		
		
end process;

end BHV;