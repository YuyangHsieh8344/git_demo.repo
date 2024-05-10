library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity alu_controller is 
generic(
width : positive := 32);
port(
ALUOp	  : in std_logic_vector(5 downto 0);
IR 		  : in std_logic_vector(5 downto 0);
HI_en	  : out std_logic;
Lo_en	  : out std_logic;
ALU_LO_HI : out std_logic_vector(1 downto 0);
OPSelect : out std_logic_vector(5 downto 0)
);
end alu_controller;

architecture bhv of alu_controller is
begin 

process(ALUOp, IR)
begin 

ALU_LO_HI <= "00";
HI_en <= '0';
Lo_en <= '0';
OPSelect <= "000000";



case ALUOp is
		
	when "000000" => 
			
			
	when "000001" =>
		
	--Rtype
	when "000010" => 
		--add
		if (IR = "100001") then 
			--hex 0x21
			OPSelect <= "000000";		
			
		--sub
		elsif(IR = "100011") then	
			--hex 0x23	
			OPSelect <= "000001";
			
		--mult	
		elsif(IR = "011000") then
			--hex 0x18
			HI_en <= '1';
			Lo_en <= '1';
		
		--multu unsigned
		elsif(IR = "011001") then
			--hex 0x19
			OPSelect <= "000011";
			
				HI_en <= '1';
				Lo_en <= '1';
	
		
		--and	
		elsif(IR = "100100") then
			--hex 0x24
			OPSelect <= "000100";
		
		--or
		elsif(IR = "100101") then
			--hex 0x25
			OPSelect <= "000101";
		
		--xor
		elsif(IR = "100110") then
			--hex 0x26
			OPSelect <= "000110";
		
		--srl (logic shift right (mult by 2))
		elsif(IR = "000010") then
			--hex 0x2
			OPSelect <= "000111";
			
		--sll (logic shift left (divide by 2))
		elsif(IR = "000000") then
			--hex 0x0
			OPSelect <= "001000";
			
		
		--sra (arithmetic shift right)  
		elsif(IR = "000011") then
			OPSelect <= "001001";
			
			
		--slt		
		elsif(IR = "101010") then   
			--hex 0x2A
			OPSelect <= "001010";
		
		--sltu	
		elsif(IR = "101011") then  
			--hex 0x2B
			OPSelect <= "001011";
		
		--mfhi (move fromn high)
		elsif(IR = "010000") then   
			ALU_LO_HI <= "10";
			
			
		--mflo (move from low)	
		elsif(IR = "010010") then  
			ALU_LO_HI <= "01";
		
		--jump register
		elsif(IR = "001000") then  
			--hex 0x008
			OPSelect <= "010111";
			
	
			
		
		end if;
		
	--branch on equal 
	when "000011" =>
		OPSelect <= "010001";
	--branch not equal
	when "000100" => 
		OPSelect <= "010010";
		
	--branch on less than or queal to 0
	when "000101" => 
		OPSelect <= "010011";
	
	--branch on greater than 0
	when "000110" =>
		OPSelect <= "010100";
	
	--branch on less than 0
	when "000111" => 
		OPSelect <= "010101";
	
	--branch on greater than or equal to zero
	when "001000" => 
		OPSelect <= "010110";
	
	--add for branch	
	when "001001" => 
		if (IR = "100001") then 
			--hex 0x21
			OPSelect <= "000000";	
		end if;
	
	
	--itype
	--addiu (0x21 -> 33)
	when "100001" =>
		OPSelect <= "000000";
		
	--subiu	(0x23 -> 35)
	when "100011" =>
		OPSelect <= "000001";	
	
	--andi (0x24 -> 36)
	when "100100" => 
		OPSelect <= "000100";	
	
	--ori (0x25 -> 37)
	when "100101" =>
		OPSelect <= "000101";	
	
	--xori (0x26 -> 38)
	when "100110" =>
		OPSelect <= "000110";	
	
	--slti (0x2A -> 42)
	when "101010" =>
		OPSelect <= "001010";	
	
	--slitiu (0x2B -> 43)
	when "101011" =>
		OPSelect <= "001011";
	
	
		
	
	
	if (ALUOp = "001111") then 
		OPSelect <= "001111";
		
	--cal mem addrss (inport0)
	elsif(ALUOp = "010000") then 
		OPSelect <= "010000";
		
		
		
	

	end if;
		
	
		
	when others => null;
	
	end case;
end process;

end bhv;