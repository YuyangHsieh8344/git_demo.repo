library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity alu_mips_tb is
end alu_mips_tb;

architecture TB of alu_mips_tb is

    component alu_mips

        generic (
            WIDTH : positive := 32
            );
       port( 
			input1 	 	: in std_logic_vector(WIDTH-1 downto 0); 
			input2  	: in std_logic_vector(WIDTH-1 downto 0); 
			IR 		 	: in std_logic_vector(10 downto 6); 
			OPSelect 	: in std_logic_vector(5 downto 0);
			output 	 	: out std_logic_vector(WIDTH-1 downto 0);
			output_high : out std_logic_vector(2*width-1 downto width);
			Branch 	 	: out std_logic

		); 

    end component alu_mips;

    constant WIDTH : positive := 32;
    signal input1     	 : std_logic_vector(WIDTH-1 downto 0);
    signal input2     	 : std_logic_vector(WIDTH-1 downto 0); 
    signal IR      		 : std_logic_vector(10 downto 6);
	signal sel    		 : std_logic_vector(5 downto 0);
    signal output  		 : std_logic_vector(WIDTH-1 downto 0);
	signal output_high   : std_logic_vector(2*width-1 downto width);
	signal Branch		 : std_logic;
	 

begin  -- TB

    UUT : alu_mips
        generic map (
		WIDTH => WIDTH)
        port map (
            input1   => input1,
            input2   => input2,
            IR    => IR,
			OPSelect => sel,
            output   => output,
			output_high => output_high,
			Branch => Branch			
			);

process
    begin

        --test 10+ 15 (no overflow)
        sel    <= "000000";
        input1 <= conv_std_logic_vector(10, input1'length);
        input2 <= conv_std_logic_vector(15, input2'length);
        wait for 40 ns;
        
		--test 6-2 (no overflow)
        sel    <= "000001";
        input1 <= conv_std_logic_vector(25, input1'length);
        input2 <= conv_std_logic_vector(10, input2'length);
        wait for 40 ns;
       
        
		-- test 10* -4 (signed)
        sel    <= "000010";
        input1 <= conv_std_logic_vector(10, input1'length);
        input2 <= conv_std_logic_vector(-4, input2'length);
        wait for 40 ns;
       
		
		--test 65536 * 131072
		sel    <= "000011";
        input1 <= conv_std_logic_vector(65536, input1'length);
        input2 <= conv_std_logic_vector(131072, input2'length);
        wait for 40 ns;
       
		
		
		--test 0x0000FFFF and 0xFFFF1234
		sel    <= "000100";
        input1 <= conv_std_logic_vector(16#0000FFFF#, input1'length);
        input2 <= conv_std_logic_vector(16#FFFF1234#, input2'length);
        wait for 40 ns;
        
		
		-- test right logical 0x0000000F by 4
		sel    <= "000111";
		input1 <= conv_std_logic_vector(16#0000000F#, input1'length);
		IR <= conv_std_logic_vector(4, IR'length);
		wait for 40 ns;
		


		-- test right arithmetic 0xF0000008 by 1
		sel    <= "001001";
		input1 <= conv_std_logic_vector(16#F0000008#, input1'length);
		IR <= conv_std_logic_vector(1, IR'length);
		wait for 40 ns;
		


		-- test right arithmetic 0x00000008 by 1
		sel    <= "001001";
		input1 <= conv_std_logic_vector(16#00000008#, input1'length);
		IR <= conv_std_logic_vector(1, IR'length);
		wait for 40 ns;
		


		-- test set on less than using 10 and 15
		sel    <= "001010";
		input1 <= conv_std_logic_vector(10, input1'length);
		input2 <= conv_std_logic_vector(15, input2'length);
		wait for 40 ns;
		


		-- test set on less than using 15 and 10
		sel    <= "001011";
		input1 <= conv_std_logic_vector(15, input1'length);
		input2 <= conv_std_logic_vector(10, input2'length);
		wait for 40 ns;
		

		-- test branch taken output = 0 for 5<=0
		sel    <= "010011";
		input1 <= conv_std_logic_vector(5, input1'length);
		Branch <= '0';
		wait for 40 ns;
		
		-- test branch taken output=1 for 5>0
		sel    <= "010100";
		input1 <= conv_std_logic_vector(5, input1'length);
		Branch <= '1';
		wait for 40 ns;
	

		
		wait;
		
    end process;
        
end TB;
		
		
		
		
		
       