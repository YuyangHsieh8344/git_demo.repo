library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all; 

entity controller_mips is 
	generic (
	width : positive := 32);
	port(
	clk 		: in std_logic;
	rst 		: in std_logic;
	OP			: in std_logic_vector(31 downto 26);
	
	BL          : in std_logic_vector(20 downto 16);
	OP_2      	: in std_logic_vector(5 downto 0);
	
	--controller input
	--enable the PC register if the "Branch" singal is asserted
	PCWriteCond : out std_logic;
	--enable the PC register
	PCWrite 	: out std_logic;
	--select btw the PC or the ALU ouput as the memory adress
	IorD		: out std_logic;
	--enable meeory read
	MemRead 	: out std_logic;
	--enable memory write
	MemWrite	: out std_logic;
	--select btw "memory data register: or "ALU output" as input to "write data" signal 
	MemToReg	: out std_logic;
	--enable the instruction register
	IRWrite		: out std_logic;
	JumpAndLink	: out std_logic;     --not this week
	--when assert "signed extend" will output a 32 bit signed extended representation of 16 bit input
	IsSigned	: out std_logic;
	--select btw the "ALU output", "ALU OUT reg" or a "shift to left PC" as an input to PC
	PCSource	: out std_logic_vector(1 downto 0);
	--used by the alu controller to determine the desired operation to be executed by the alu. (up to us how to use the function)
	ALUOp		: out std_logic_vector(5 downto 0);
	--select btw RegA or PC as the input1 of the ALU
	ALUSrcB		: out std_logic_vector(1 downto 0);
	--select btw regB, "4", "IR15-0" or "shift IR 15-0 " as the input2 of the alu
	ALUSrcA		: out std_logic;
	--enable the register file
	RegWrite	: out std_logic;
	--select btw IR20-16 or IR15-11 as the input to the "write reg"
	RegDst 		: out std_logic
	
	);
	
end controller_mips;

architecture BHV of controller_mips is

type state_type is (read_instruction, write_instruction, decode_instruction, Rtype_execution, Rtype_comp, branch_comp, Itype_execution, 
Itype_comp, jump_comp, jump_comp2, s_rst, lw_sw_comp, lw_mem_access, sw_mem_access, lw_mem_read, halt, wait_0, branch_taken);

signal state, next_state : state_type;


begin 

process(clk, rst)
begin 
if (rst ='1') then
	state <= s_rst;

elsif (rising_edge(clk))then 
	state <= next_state;
end if;

end process;


process (state, OP, OP_2, BL)

begin 	

PCWrite <= '0';
PCWriteCond <= '0';
PCSource <= "00";
IsSigned <= '0';
IorD <= '0';
MemRead <= '0';
MemWrite <= '0';
MemToReg <= '0';
IRWrite <= '0';
ALUOp <= "000000";
ALUSrcB <= "00";
ALUSrcA <= '0';
RegWrite <= '0';
RegDst <= '0';
JumpAndLink <= '0';



case state is 
	when s_rst =>
		next_state <= read_instruction;
	
	when read_instruction =>
		MemRead <= '1';
		
		next_state <= write_instruction;
	
	
		
	--PC + 4
	when write_instruction =>
		IRWrite <= '1';
		ALUSrcB <= "01";
		--make the ALU add the number
		PCWrite <= '1';
		
		next_state <= wait_0;
		
		
	when wait_0 => 
		next_state <= decode_instruction;
		
	when decode_instruction =>
		ALUSrcB <= "10";
		ALUSrcA <= '1';
		ALUOp <= "100001";
		
		
		if(unsigned(OP) = 0) then
			next_state <= Rtype_execution;
			
		elsif (unsigned(OP) = 9 OR unsigned(OP) = 16 OR unsigned(OP) = 12 OR unsigned(OP) = 13 OR unsigned(OP) = 14 OR unsigned(OP) = 10 OR unsigned(OP) = 11) then
            next_state <= Itype_execution;
			
		--load / store
		elsif (unsigned(OP) = 35 or unsigned(OP) = 43) then 
			next_state <= lw_sw_comp;
			
		elsif (unsigned(OP) = 1 or unsigned(OP) = 4 or unsigned(OP) = 5 or unsigned(OP) = 6 or unsigned(OP) = 7) then
			next_state <= branch_comp;
			
		elsif (unsigned(OP) = 2 OR unsigned(OP) = 3) then
            next_state <= jump_comp;
			
		elsif (OP = "111111") then
			next_state <= halt;
		
		else 
			next_state <= decode_instruction;
			
		end if;
		
		
	when halt =>
		next_state <= halt;
		
	--Rtype
	when Rtype_execution =>
		ALUSrcA <= '1';
		ALUOp <= "000010";
		IsSigned <= '1';
		
		
		next_state <= Rtype_comp;
		
	when Rtype_comp =>
		RegDst <= '1';
		RegWrite <= '1';
		
		--OPSelect to mult 
		if(OP_2 = "011001" or OP_2 = "011000") then 
			RegWrite <= '0';
		else 
			RegWrite <= '1';
		end if;
			
		
		next_state <= read_instruction;
		
	
	when branch_comp =>
		IsSigned <= '1';
		
		--get offset 4  
		ALUSrcB <= "11";
		
		ALUOp <= "001001";
		PCWriteCond <= '1';
		PCSource <= "01";
	
			
			
		
		next_state <= branch_taken;
	
	when branch_taken => 
		--ALUOp <= "001001";
		ALUSrcA <= '1';
		PCWriteCond <= '1';
		PCSource <= "01";
		
		if(unsigned(OP) = 4) then 
			ALUOp <= "000011";
			
		elsif(unsigned(OP) = 5) then 
			ALUOp <= "000100";
			
		elsif(unsigned(OP) = 6) then 
			ALUOp <= "000101";
		
		elsif(unsigned(OP) = 7) then 
			ALUOp <= "000110";
			
		elsif(unsigned(OP) = 1) then 
			if(BL = "00001") then
				ALUOp <= "001000";
			
			elsif (BL ="00000") then
				ALUOp <= "000111";
				
			end if;
			
		
		end if;
		
		
		next_state <= read_instruction;
		
		
		
	when jump_comp =>
		PCWrite <= '1';
		PCSource <= "10";
		
		next_state <= jump_comp2;
		
	when jump_comp2 => 
		PCWrite <= '1';
		PCSource <= "10";
		
		if(unsigned(OP) = 3) then 
			JumpAndLink <= '1';
		end if; 
		
		next_state <= read_instruction;
	
	--Itype
	when Itype_execution =>
		ALUSrcA <= '1';
		ALUSrcB <= "10";
		
		if (unsigned(OP) = 9) then 
		IsSigned <= '1';
		ALUOp <= "100001";
		--subiu
		elsif(unsigned(OP) = 16) then
		IsSigned <= '1';
		ALUOp <= "100011";
		
		--andi
		elsif(unsigned(OP) = 12) then
		IsSigned <= '0';		
		ALUOp <= "100100";
		
		--ori
		elsif(unsigned(OP) = 13) then
		IsSigned <= '0';
		ALUOp <= "100101";
		
		--xori
		elsif(unsigned(OP) = 14) then 
		IsSigned <= '0';
		ALUOp <= "100110";
		
		--slti
		elsif(unsigned(OP) = 10) then 
		IsSigned <= '1';
		ALUOp <= "101010";
		
		--sltiu
		elsif(unsigned(OP) = 11) then
		IsSigned <= '1';
		ALUOp <= "101011";
		
		
		end if;
		next_state <= Itype_comp;
		
		
	when Itype_comp =>
		RegWrite <= '1';
		
		next_state <= read_instruction;
		
		
	--issigned is always 0
	
	when lw_sw_comp =>
		--ALUOp <= "010000";
		--hex 0x23
		if(unsigned(OP) = "100011" ) then 
			MemRead <= '1';
			MemWrite <= '0';
			IorD <= '1';
			next_state <= lw_mem_access;
		--hex 0x2B
		else 
		--sw is just taking reg 5 and put into outport
			ALUOp <= "010000";
			MemWrite <= '1';
			IorD <= '1';
			
			next_state <= sw_mem_access;
		end if;
	
	--waiting for clk cycle
	when lw_mem_access =>
		
		--read from memory 
		next_state <= lw_mem_read;	
		
	when sw_mem_access =>
	
		MemToReg <= '1';
		
		
		--go back to fetch new instructions
		next_state <= read_instruction;
		
		
	when lw_mem_read =>
		MemToReg <= '1';
		RegWrite <= '1';
		
		
		next_state <= read_instruction;
		
		
	when others => 
		next_state <= halt;
	
	end case;


end process;

 

end BHV;



