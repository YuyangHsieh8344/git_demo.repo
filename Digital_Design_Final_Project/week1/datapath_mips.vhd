library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity datapath_mips is 
	generic (
	width : positive := 32);
	port(
	clk 		: in std_logic;
	rst 		: in std_logic;
	enable		: in std_logic;
	
	--controller input
	PCWriteCond : in std_logic;
	PCWrite 	: in std_logic;
	IorD		: in std_logic;
	MemRead 	: in std_logic;
	MemWrite	: in std_logic;
	MemToReg	: in std_logic;
	IRWrite		: in std_logic;
	JumpAndLink	: in std_logic;
	IsSigned	: in std_logic;
	PCSource	: in std_logic_vector(1 downto 0);
	ALUOp		: in std_logic_vector(5 downto 0);
	ALUSrcB		: in std_logic_vector(1 downto 0);
	ALUSrcA		: in std_logic;
	RegWrite	: in std_logic;
	RegDst 		: in std_logic;	
	button 	: in std_logic;
	switches    : in std_logic_vector(9 downto 0);
	led 		: out std_logic_vector(width-1 downto 0);
	
	IR_out_2   : out std_logic_vector(5 downto 0);
	IR_out     : out std_logic_vector(31 downto 26)
	
	
	);
	
end datapath_mips;
	
	

architecture bhv of datapath_mips is 

signal pc_out : std_logic_vector(width-1 downto 0);
signal pc_en  : std_logic;

signal 	out25to0  :  std_logic_vector(25 downto 0);
signal	out25to21 : std_logic_vector(25 downto 21);
signal	out20to16 :  std_logic_vector(20 downto 16);
signal	out15to11 : std_logic_vector(15 downto 11);
signal	out10to6  :  std_logic_vector(10 downto 6);
signal	out5to0   : std_logic_vector(5 downto 0);
signal	out15to0  :  std_logic_vector(15 downto 0);



signal regA_out   : std_logic_vector(width-1 downto 0);
signal regB_out   : std_logic_vector(width-1 downto 0);

signal rd_data1   : std_logic_vector(width-1 downto 0);
signal rd_data2	  : std_logic_vector(width-1 downto 0);

signal mux0_out   : std_logic_vector(width-1 downto 0);
signal mux1_out   : std_logic_vector(4 downto 0);
signal mux2_out   : std_logic_vector(width-1 downto 0);
signal mux3_out   : std_logic_vector(width-1 downto 0);
signal mux4_out   : std_logic_vector(width-1 downto 0);
signal mux5_out   : std_logic_vector(width-1 downto 0);
signal mux6_out   : std_logic_vector(width-1 downto 0);

signal alu_out   : std_logic_vector(width-1 downto 0);
signal result_low_out   : std_logic_vector(width-1 downto 0);
signal result_hi_out   : std_logic_vector(width-1 downto 0);

signal Branch     : std_logic;
signal Result_HI  : std_logic_vector(width-1 downto 0);
signal Result : std_logic_vector(width-1 downto 0);

signal sign_extend_out : std_logic_vector(width-1 downto 0);
signal shift_left_out  : std_logic_vector(width-1 downto 0);
signal shift_left_out_0  : std_logic_vector(27 downto 0);

signal mem_out  : std_logic_vector(width-1 downto 0);	
signal mdr_out  : std_logic_vector(width-1 downto 0);	

signal concat_out  : std_logic_vector(width-1 downto 0);	

--memory		
signal switch_data : std_logic_vector(width-1 downto 0);		
signal Outport : std_logic_vector(width-1 downto 0);

--alu
signal OPSelect_out : std_logic_vector(5 downto 0);

signal ALU_LO_HI  : std_logic_vector(1 downto 0);
signal ALU_LO_HI_out : std_logic_vector(1 downto 0);
signal HI_en_out : std_logic;
signal LO_en_out : std_logic;

signal zero_out : std_logic_vector(width-1 downto 0);

signal inport0 : std_logic;
signal inport1 : std_logic;



begin 

pc_en <= (PCWriteCond and Branch) or PCWrite;
inport0 <= button and not switches(9);
inport1 <= button and switches(9);
--pc
U_pc : entity work.pc
generic map(
	width => width)
port map(
	clk 	=> clk,
	rst 	=> rst,
	load_n  => pc_en,
	input  => mux5_out,
	output  => pc_out
	);


--pc to mux_2x1
U_mux0 : entity work.mux_2x1
	generic map(
	width => width)
	port map(
	in1 => pc_out,
	in2 => alu_out,   --ALU out 
	sel =>	IorD,
	output => mux0_out
);


--memory
u_mem : entity work.memory_mips
generic map(
width => width) 
port map(
	clk => clk,     
	rst => rst,
	addr => mux0_out,          --9 downto 2 
	WrData  =>	regB_out,    
	switch_data => zero_out,
	inport0En => inport0,
	inport1en => inport1,
	Mem_write => MemWrite, 
	Mem_read => MemRead,
	Outport => led,
	RdData =>  mem_out			--memory data register     
	);

	
U_ze : entity work.zero_extend
generic map(
width => width)
port map(
    in1 => switches(9 downto 0),
    output => zero_out
);

--IR
U_IR : entity work.IR
generic map(
width => width)
port map(
	input  => mem_out,    --RdData
	enable => IRWrite,
	clk    => clk, 
	rst    => rst, 
	out25to0  => out25to0,
	out31to26 => IR_out,
	out25to21 => out25to21,
	out20to16 => out20to16,
	out15to11 => out15to11,
	out10to6  => out10to6,
	out5to0   => IR_out_2,
	out15to0  => out15to0
	);
	
--IR to mux_2x1(top)
U_mux1 : entity work.mux_2x1
	generic map(
	width => 5)
	port map(
	in1 => out20to16,
	in2 => out15to11,
	sel =>	RegDst,
	output => mux1_out
	);
	
--memory data register 
U_mdr : entity work.regist_fp
generic map(
width => width)
port map(
	in1 => mem_out,
	enable 	=> '1',
	clk => clk,
	rst => rst,
	output => mdr_out
	);


--IR to mux_2x1(bot)
U_mux2 : entity work.mux_2x1
	generic map(
	width => width)
	port map(
	in1 => mux6_out,   --mux3x1
	in2 =>  mdr_out,    --memory data register
	sel =>	MemToReg,
	output => mux2_out
	);

--regfile
U_regfile : entity work.reg_file
generic map(
	width => width)
	port map(
		clk	=> clk,
		rst => rst,
		
		rd_reg1 => out25to21,
		rd_reg2 => out20to16,
		
		JumpAndLink => JumpAndLink,
		wr_addr => mux1_out,
		wr_en => RegWrite,
		wr_data => mux2_out,
	
		rd_data1 => rd_data1,
		rd_data2 => rd_data2	
	);
	
--PC and regfile to mux_2x1(top)
U_mux3 : entity work.mux_2x1
	generic map(
	width => width)
	port map(
	in1 => pc_out,   
	in2 => regA_out,    
	sel =>	ALUSrcA,
	output => mux3_out
	);

--sign_extend
U_sx : entity work.sign_extend
generic map(
width => width)
port map (
    in1 => out15to0,
    en => IsSigned,
    output => sign_extend_out
    );

--sign_extend shift left2
U_sl0 : entity work.Shift_Left_2
generic map (
    width => width)
port map(
    in1 => sign_extend_out,
    output => shift_left_out
);

	
--PC and regfile to mux_4x1(bot)
U_mux4 : entity work.mux_4x1
	generic map(
	width => width)
	port map(
	in1 => regB_out,   
	in2 => std_logic_vector(to_unsigned(4, width)), 
	in3	=> sign_extend_out, --sign extend
	in4 =>	shift_left_out,  --sign extend shift left 2 
	sel =>	ALUSrcB,
	output => mux4_out
	);


--regA
U_regA : entity work.regist_fp
	generic map (
	width => width)
	port map (
	in1 => rd_data1,
	enable 	=> '1',
	clk => clk,
	rst => rst,
	output => regA_out
	);
	
--regB
U_regB : entity work.regist_fp
	generic map (
	width => width)
	port map(
	in1 => rd_data2,
	enable 	=> '1',
	clk => clk,
	rst => rst,
	output => regB_out
	);

--alu
U_alu : entity work.alu_mips
generic map(
width => width)
	port map( 
		input1 => mux3_out,	 	
		input2  => 	mux4_out, 
		IR => out10to6,
		OPSelect => OPSelect_out,    --alu_controller
		output_high => Result_HI,
		Branch => Branch,
		output => Result	
); 



--reg0 (alu)	
U_alu_out : entity work.regist_fp
	generic map (
	width => width)
	port map(
	in1 => Result,
	enable 	=> '1',
	clk => clk,
	rst => rst,
	output => alu_out
	); 


--reg1 (LO)	
U_reg1 : entity work.regist_fp
	generic map (
	width => width)
	port map(
	in1 => Result,    --result
	enable 	=> LO_en_out,
	clk => clk,
	rst => rst,
	output => result_low_out
	); 	
	
--reg2 (HI)	
U_reg2 : entity work.regist_fp
	generic map (
	width => width)
	port map(
	in1 => Result_HI,
	enable 	=> HI_en_out,
	clk => clk,
	rst => rst,
	output => result_hi_out
	); 

--shift_left from 25to0
U_sl1 : entity work.Shift_Left_25
generic map (
    width => 28)
port map(
    in1 => out25to0,
    output => shift_left_out_0
);


--concatentated
U_cat : entity work.concat
generic map(
    width => width)
port map(
    in1  => shift_left_out_0,
    in2  =>  pc_out(31 downto 28),  --pc[31to28]
    output => concat_out

);
--mux3x1 (top)	
U_mux5 : entity work.mux_3x1
generic map(
	width => width)
	port map(
	in1 => Result,   
	in2 => alu_out, 
	in3 =>	concat_out,  --from out25to0 shift left 2 and concatentated
	sel =>	PCSource,
	output => mux5_out
	);

--mux3x1(bot)
U_mux6 : entity work.mux_3x1
generic map(
	width => width)
	port map(
	in1 => alu_out,   
	in2 => result_low_out,           --result
	in3 =>	result_hi_out,
	sel =>	ALU_LO_HI_out,     --ALU_LO_HI from alu controller    (fillout)
	output => mux6_out
	);


U_lo_hi : entity work.regist_fp
generic map(
	width => 2)
port map(
	in1 => ALU_LO_HI,
	enable 	=> '1',
	clk => clk,
	rst => rst,
	output => ALU_LO_HI_out
);

U_alu_ctrl : entity work.alu_controller
generic map(
width => width)
port map(
ALUOp	=> ALUOp,
IR 	=> out15to0(5 downto 0),
HI_en => HI_en_out,
Lo_en => LO_en_out,
ALU_LO_HI => ALU_LO_HI,
OPSelect => OPSelect_out

);


	
end bhv;