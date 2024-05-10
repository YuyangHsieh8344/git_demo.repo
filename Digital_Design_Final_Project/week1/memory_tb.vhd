library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory_tb is 
end memory_tb;

architecture tb of memory_tb is 

constant width : positive := 32;

signal clkEn 		: std_logic := '1';
signal clk 	 		: std_logic := '0';
signal rst 	 		: std_logic := '1';
signal addr  		: std_logic_vector(width-1 downto 0);
signal WrData 		: std_logic_vector(width-1 downto 0);
signal switch_data 	: std_logic_vector(width-1 downto 0);
signal inport0En	: std_logic;
signal inport1En	: std_logic;
signal Mem_write	: std_logic;
signal Mem_read		: std_logic;
signal Outport		: std_logic_vector(width-1 downto 0);
signal RdData		: std_logic_vector(width-1 downto 0);

begin 

U_memory0 : entity work.memory_mips
generic map(
width => width)
port map(
clk => clk,
rst => rst,
addr => addr,
WrData => WrData,
switch_data => switch_data,
inport0En => inport0En,
inport1En => inport1En,
Mem_write => Mem_write,
Mem_read => Mem_read,
Outport => Outport,
RdData => RdData
);

clk <= not clk and clkEn after 20 ns;
	

	process
	  
	begin
	  
	  rst <= '1';
	  inport0En <= '0';
	  inport1En <= '0';
	  switch_data <= "00000000000000000000000000000000";
	  wait for 40 ns;
	  
	  rst <= '0';
	  addr   <= "00000000000000000000000000000000";
	  WrData <= "00001010000010100000101000001010";
	  Mem_write <= '1';
	  Mem_read <= '0';
	  
	  wait for 40 ns;
	  
	  addr   <= "00000000000000000000000000000100";
	  WrData <= "11110000111100001111000011110000";
	  Mem_write <= '1';
	  Mem_read <= '0';
	  
	  wait for 40 ns;
	  
	  addr   <= "00000000000000000000000000000000";
	  WrData <= "00001010000010100000101000001010";
	  Mem_write <= '0';
	  Mem_read <= '1';
	  
	  wait for 40 ns;
	  
	  addr   <= "00000000000000000000000000000001";
	  WrData <= "00001010000010100000101000001010";
	  Mem_write <= '0';
	  Mem_read <= '1';
	  
	  wait for 40 ns;
	  
	  addr   <= "00000000000000000000000000000100";
	  WrData <= "00001010000010100000101000001010";
	  Mem_write <= '0';
	  Mem_read <= '1';
	  
	  
	  wait for 40 ns;
	  
	  addr   <= "00000000000000000000000000000101";
	  WrData <= "00001010000010100000101000001010";
	  Mem_write <= '0';
	  Mem_read <= '1';
	  
	  wait for 40 ns;
	  
	  addr   <= "00000000000000000000001111111100";
	  WrData <= "00000000000000000001000100010001";
	  Mem_write <= '1';
	  Mem_read <= '0';
	  
	  wait for 40 ns;
	  
	  addr   <= "00000000000000000000001111111100";
	  switch_data <= "00000000000000010000000000000000";
	  Mem_write <= '1';
	  Mem_read <= '0';
	  inport0En <= '1';
	  inport1En <= '0';
	  
	  wait for 40 ns;
	  
	  addr   <= "00000000000000000000001111111100";
	  switch_data <= "00000000000000000000000000000001";
	  Mem_write <= '1';
	  Mem_read <= '0';
	  inport0En <= '0';
	  inport1En <= '1';
	  
	  wait for 40 ns;
	  
	  addr   <= "00000000000000000000001111111100";
	  switch_data <= "00000000000000000000000000000000";
	  Mem_write <= '0';
	  Mem_read <= '1';
	  inport0En <= '0';
	  inport1En <= '0';
	  
	  wait for 40 ns;
	  
	  addr   <= "00000000000000000000001111111100";
	  switch_data <= "00000000000000000000001000000000";
	  Mem_write <= '0';
	  Mem_read <= '1';
	  
	  wait for 40 ns;
	  
	  clkEn <= '0';
	  
	  wait;
	  
	end process;
  
  end TB;
  
  
  
  
  
  
	



