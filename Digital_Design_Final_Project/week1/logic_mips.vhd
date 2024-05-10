
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity logic_mips is 
    generic(
    WIDTH : positive := 32);
    port(
    Mem_write       : in std_logic;
    addr            : in std_logic_vector(width-1 downto 0);
    port_select   : in std_logic;
    
    OutportWrEn   : out std_logic;
    WrEn          : out std_logic;
    GoWrEn        : out std_logic;
    NWrEn         : out std_logic;
	delay_en      : out std_logic;
    RdData_select : out std_logic_vector(2 downto 0)
	
    );
    
end logic_mips;


architecture bhv of logic_mips is 
begin 

process (addr, Mem_write)

begin 

OutportWrEn  <= '0';
WrEn <= '0';
GoWrEn <= '0';
NWrEn <= '0';
RdData_select <= "000";
delay_en <= '0';


--go 0xFFE8
if (addr = x"0000FFE8") then
    if (Mem_write = '1') then
        GoWrEn <= '1';
		delay_en <= '0';
		--RdData_select <= "000";
    else
		GoWrEn <= '0';
		RdData_select <= "000";
		delay_en <= '1';
    end if;
	
--n 0xFFEC
elsif (addr = x"0000FFEC") then 
      if (Mem_write = '1') then
        NWrEn <= '1';
		delay_en <= '0';
		--RdData_select <= "001";
    else
		NWrEn <= '0';
		RdData_select <= "001";
		delay_en <= '1';
    end if;
    
--result (read only) 0xFFF0
elsif (addr = x"0000FFF0") then 

        RdData_select <= "010";
		delay_en <= '1';
 
--done    (read only) 0xFFF4
elsif (addr = x"0000FFF4") then 
   
        RdData_select <= "011";
		delay_en <= '1';
    
    
--check if we are accessing the RAM
elsif ((addr >= x"0000") and addr <= x"000003FC")  then 
     if (Mem_write = '1') then
        WrEn <= '1';
		delay_en <= '0';
		RdData_select <= "100";
    else
		WrEn <= '0';
		RdData_select <= "100";
		delay_en <= '1';
    end if;

--inport0 
--elsif(addr = x"0000FFF8") then 

       -- RdData_select <= "101";

        --OutportWrEn <= '1';

 
    
--inport1
   --elsif(addr = x"0000FFFC") then 
		
	
       -- RdData_select <= "110";
	
--inport0 
elsif(unsigned(addr) = "1111111111111000") then 

        RdData_select <= "101";




--inport1
    elsif(unsigned(addr) = "1111111111111100") then 

        RdData_select <= "110";
        OutportWrEn <= '1';
		
		

    end if;
     
    
    
    
end process;

end bhv;