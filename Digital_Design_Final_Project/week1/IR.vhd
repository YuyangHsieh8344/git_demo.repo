library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity IR is 
    generic(
    width : positive := 32
    );
    
    port (
    input  : in std_logic_vector(width-1 downto 0);
    enable : in std_logic;
    clk    : in std_logic;
    rst    : in std_logic;
    out25to0  : out std_logic_vector(25 downto 0);
    out31to26 : out std_logic_vector(31 downto 26);
    out25to21 : out std_logic_vector(25 downto 21);
    out20to16 : out std_logic_vector(20 downto 16);
    out15to11 : out std_logic_vector(15 downto 11);
    out10to6  : out std_logic_vector(10 downto 6);
    out5to0   : out std_logic_vector(5 downto 0);
    out15to0  : out std_logic_vector(15 downto 0)
    );

end IR;


architecture bhv of IR is 

component regist_fp is 
    generic(
        width : positive := 32
        );
    port(
        in1     : in std_logic_vector(width-1 downto 0);
        enable  : in std_logic;
        clk     : in std_logic;
        rst        : in std_logic;
        output  : out std_logic_vector(width-1 downto 0)
        );
        
end component regist_fp;


begin 

out0 : regist_fp
generic map(
    width => 26
    )
    port map(
    in1 => input(25 downto 0),
    enable => enable,
    clk => clk,
    rst => rst,
    output => out25to0
    );
    
out1 : regist_fp
generic map(
    width => 6
    )
    port map(
    in1 => input(31 downto 26),
    enable => enable,
    clk => clk,
    rst => rst,
    output => out31to26
    );    
    
out2 : regist_fp
generic map(
    width => 5
    )
    port map(
    in1 => input(25 downto 21),
    enable => enable,
    clk => clk,
    rst => rst,
    output => out25to21
    );    
    
out3 : regist_fp
generic map(
    width => 5
    )
    port map(
    in1 => input(20 downto 16),
    enable => enable,
    clk => clk,
    rst => rst,
    output => out20to16
    );    
    
    
out4 : regist_fp
generic map(
    width => 5
    )
    port map(
    in1 => input(15 downto 11),
    enable => enable,
    clk => clk,
    rst => rst,
    output => out15to11
    );    
    
out5 : regist_fp
generic map(
    width => 5
    )
    port map(
    in1 => input(10 downto 6),
    enable => enable,
    clk => clk,
    rst => rst,
    output => out10to6
    );    
    
out6 : regist_fp
generic map(
    width => 6
    )
    port map(
    in1 => input(5 downto 0),
    enable => enable,
    clk => clk,
    rst => rst,
    output => out5to0
    );    
    
out7 : regist_fp
generic map(
    width => 16
    )
    port map(
    in1 => input(15 downto 0),
    enable => enable,
    clk => clk,
    rst => rst,
    output => out15to0
    );    
    
end bhv;