library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mips_processor is 
	generic (
	width : positive := 32);
	port(
	clk : in std_logic;
	rst : in std_logic;
	button_processor  : in std_logic;
	switches : in std_logic_vector(9 downto 0);
	--top level/interface outputs
	led 	 : out std_logic_vector(width-1 downto 0)
	
	);
	
	
end mips_processor;

architecture bhv of mips_processor is 

signal PCWriteConds  : std_logic;
signal PCWrites 	:  std_logic;
signal	IorDs		:  std_logic;
signal MemReads 	: std_logic;
signal MemWrites	:  std_logic;
signal MemToRegs	:  std_logic;
signal IRWrites		:  std_logic;
signal JumpAndLinks	: std_logic;
signal IsSigneds	: std_logic;
signal PCSources	: std_logic_vector(1 downto 0);
signal ALUOps		:  std_logic_vector(5 downto 0);
signal ALUSrcBs		:  std_logic_vector(1 downto 0);
signal ALUSrcAs		:  std_logic;
signal RegWrites	:  std_logic;
signal RegDsts 		: std_logic;
signal IR_out_temp  : std_logic_vector(31 downto 26);

signal BL       : std_logic_vector(20 downto 16);

signal  OP_2	: std_logic_vector(5 downto 0);

begin

--datapath
U_da :entity work.datapath_mips
generic map(
	width => width)
port map(
	clk 	=> clk,
	rst 	=> rst,
	enable	=> '0',
	
	--controller input
	PCWriteCond => PCWriteConds,
	PCWrite 	=> PCWrites,
	IorD		=> IorDs,
	MemRead 	=> MemReads,
	MemWrite	=> MemWrites,
	MemToReg	=> MemToRegs,
	IRWrite		=> IRWrites,
	JumpAndLink	=> JumpAndLinks,
	IsSigned	=> IsSigneds,
	PCSource	=> PCSources,
	ALUOp		=>  ALUOps,
	ALUSrcB		=> ALUSrcBs,
	ALUSrcA		=> ALUSrcAs,
	RegWrite	=> RegWrites,
	RegDst 		=> RegDsts,
	
	button 	=>  button_processor,
	switches    => switches,
	led 		=> led,
	
	IR_out     => IR_out_temp,
	IR_out_2   => OP_2
	
	);
	

U_ctrl : entity work.controller_mips 
generic map(
width => width)
port map(
	clk 	=> clk,
	rst 	=> rst,
	
	OP 		=>  IR_out_temp,
	
	BL      => BL,
	
	OP_2    =>  OP_2,
	--controller input
	PCWriteCond => PCWriteConds,
	PCWrite 	=> PCWrites,
	IorD		=> IorDs,
	MemRead 	=> MemReads,
	MemWrite	=> MemWrites,
	MemToReg	=> MemToRegs,
	IRWrite		=> IRWrites,
	JumpAndLink	=> JumpAndLinks,
	IsSigned	=> IsSigneds,
	PCSource	=> PCSources,
	ALUOp		=>  ALUOps,
	ALUSrcB		=> ALUSrcBs,
	ALUSrcA		=> ALUSrcAs,
	RegWrite	=> RegWrites,
	RegDst 		=> RegDsts
	
);

end bhv;