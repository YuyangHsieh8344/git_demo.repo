library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory_mips is 
	generic(
	width : positive := 32
	);
port(
	clk         : in std_logic;
	rst         : in std_logic;
	addr        : in std_logic_vector(width-1 downto 0);
	WrData      : in std_logic_vector(width-1 downto 0);
	switch_data : in std_logic_vector(width-1 downto 0);
	inport0En   : in std_logic;
	inport1en   : in std_logic;
	Mem_write   : in std_logic;
	Mem_read    : in std_logic;
	Outport     : out std_logic_vector(width-1 downto 0);
	RdData      : out std_logic_vector(width-1 downto 0)
	
	);
	
end memory_mips;

architecture bhv of memory_mips is 

signal inport0_out, inport1_out, go_reg_out, n_reg_out, result_reg_out, done_reg_out : std_logic_vector(width-1 downto 0);
signal result_reg_in, done_reg_in, ram_data : std_logic_vector(width-1 downto 0);
signal outport_en, write_en, go_en, n_en, delay_en : std_logic;
signal data_select, data_delayed : std_logic_vector(2 downto 0);
signal delete  : std_logic_vector(width -1 downto 0);
signal holder_delete : std_logic_vector(width-1 downto 0);


begin 

delete <= "11111111111111111111110111111111";
holder_delete <= delete and switch_data;

U_ram0 : entity work.gcd    
port map(
	address => addr(9 downto 2),
	clock => clk,
	data => WrData,
	wren => write_en,
	q => ram_data
	);

U_fact0 : entity work.factorial
generic map(
	width => width)
port map(
clk => clk,
rst => rst,
n => n_reg_out,
go => go_reg_out(0),
done => done_reg_in(0),
output => result_reg_in
);

U_import0 : entity work.regist_fp
generic map(
	width => width)
port map(
in1 => holder_delete,
enable => inport0En,
clk => clk,
rst => '0',
output => inport0_out
);

U_import1 : entity work.regist_fp
generic map(
	width => width)
port map(
in1 => holder_delete,
enable => inport1en,
clk => clk,
rst => '0',
output => inport1_out
);

U_outport0 : entity work.regist_fp
generic map(
	width => width)
port map(
in1 => WrData,
enable => outport_en,
clk => clk,
rst => rst,
output => Outport
);

U_go0 : entity work.regist_fp
generic map(
	width => width)
port map(
in1 => WrData,
enable => go_en,
clk => clk,
rst => rst,
output => go_reg_out
);

U_n0 : entity work.regist_fp
generic map(
	width => width)
port map(
in1 => WrData,
enable => n_en,
clk => clk,
rst => rst,
output => n_reg_out
);

U_result0 : entity work.regist_fp
generic map(
	width => width)
port map(
in1 => result_reg_in,
enable => '1',
clk => clk,
rst => rst,
output => result_reg_out
);

U_done0 : entity work.regist_fp
generic map(
	width => width)
port map(
in1 => done_reg_in,
enable => '1',
clk => clk,
rst => rst,
output => done_reg_out
);

U_data0 : entity work.regist_fp
generic map(
	width => 3)
port map(
in1 => data_select,
enable => '1',
--enable => delay_en,
clk => clk,
rst => rst,
output => data_delayed
);

U_logic0 : entity work.logic_mips
generic map(
	width => width)
port map(
delay_en => delay_en,
Mem_write => Mem_write,
addr => addr,
port_select => switch_data(8),
OutportWrEn => outport_en,
WrEn => write_en,
GoWrEn => go_en,
NWrEn => n_en,
RdData_select => data_select
);

U_data_select_mux : entity work.mux_7x1
generic map(
	width => width)
port map(
in1 => go_reg_out,   --000
in2 => n_reg_out,	--001
in3 => result_reg_out,  --010
in4 => done_reg_out, --011
in5 => ram_data,     --100
in6 => inport0_out,   --101
in7 => inport1_out,   --110
sel => data_delayed,  
output => RdData
);




end bhv;