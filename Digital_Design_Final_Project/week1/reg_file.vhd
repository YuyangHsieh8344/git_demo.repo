library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_file is 
	generic(WIDTH :   positive := 32);

	port(
		clk	: in std_logic;
		rst : in std_logic;
		
		rd_reg1 : in std_logic_vector(25 downto 21);
		rd_reg2 : in std_logic_vector(20 downto 16);
		
		wr_addr : in std_logic_vector(4 downto 0);
		wr_en : in std_logic;
		wr_data : in std_logic_vector(31 downto 0);
		
		JumpAndLink : in std_logic;
		rd_data1 : out std_logic_vector(31 downto 0);
		rd_data2 : out std_logic_vector(31 downto 0)
		
	);
	
end reg_file;


--The 32 registers in the MIPS processor 
architecture async_read of reg_file is

    type reg_array is array (0 to 31) of std_logic_vector(31 downto 0);
    signal regFile : reg_array;
    signal rd_addr1_r : std_logic_vector(4 downto 0);
    signal rd_addr2_r : std_logic_vector(4 downto 0);

begin
    process(clk, rst) is
    begin

        if(rst = '1') then
            for i in regFile'range loop
                regFile(i) <= (others => '0');
            end loop;
        elsif (rising_edge(clk)) then
            if(wr_en = '1') then
                regFile(to_integer(unsigned(wr_addr))) <= wr_data;
            end if;
			
		if (JumpAndLink ='1') then 
			regFile(31) <= wr_data;
		end if;

        end if;
    end process;

    rd_data1 <= regFile(to_integer(unsigned(rd_reg1)));
    rd_data2 <= regFile(to_integer(unsigned(rd_reg2)));
	
end async_read;