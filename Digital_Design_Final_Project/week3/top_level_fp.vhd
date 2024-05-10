library ieee;
use ieee.std_logic_1164.all;

entity top_level_fp is
    port (
        clk50MHz : in  std_logic;
        switch   : in  std_logic_vector(9 downto 0);
        button   : in  std_logic_vector(1 downto 0);
        led0     : out std_logic_vector(6 downto 0);
        led0_dp  : out std_logic;
        led1     : out std_logic_vector(6 downto 0);
        led1_dp  : out std_logic;
        led2     : out std_logic_vector(6 downto 0);
        led2_dp  : out std_logic;
        led3     : out std_logic_vector(6 downto 0);
        led3_dp  : out std_logic;
        led4     : out std_logic_vector(6 downto 0);
        led4_dp  : out std_logic;
        led5     : out std_logic_vector(6 downto 0);
        led5_dp  : out std_logic;
        ledR0     : out std_logic
        );
end top_level_fp;


architecture STR of top_level_fp is 

constant c0 : std_logic_vector(3 downto 0) := (others => '0');
constant z0 : std_logic_vector(15 downto 0) := (others => '0');
constant width : positive := 32;


signal Outport : std_logic_vector(31 downto 0);


 component decoder7seg
    port (
            input  : in  std_logic_vector(3 downto 0);
            output : out std_logic_vector(6 downto 0));
    end component;



component mips_processor 
	port(
	clk : in std_logic;
	rst : in std_logic;
	button_processor  : in std_logic;
	switches : in std_logic_vector(9 downto 0);
	--portsel_switch : in std_logic;
	--top level/interface outputs
	led 	 : out std_logic_vector(31 downto 0)
	
	);

end component;

begin 

u_processor : mips_processor
port map(
	clk => clk50MHz,
	rst => not button(1), 
	button_processor  => not button(0),
	switches => switch,
	--portsel_switch : in std_logic;
	--top level/interface outputs
	led => Outport
	);

		
	
U_LED0 : decoder7seg port map (
        input  => Outport(3 downto 0),
        output => led0);

U_LED1 : decoder7seg port map (
        input  => Outport(7 downto 4),
        output => led1);
		  
U_LED2 : decoder7seg port map (
        input  => Outport(11 downto 8),
        output => led2);

U_LED3 : decoder7seg port map (
        input  => Outport(15 downto 12),
        output => led3);
		  
U_LED4 : decoder7seg port map (
        input  => Outport(19 downto 16),
        output => led4);

U_LED5 : decoder7seg port map (
        input  => Outport(23 downto 20),
        output => led5);

    led5_dp <= '1';
    led4_dp <= '1';
    led3_dp <= '1';
    led2_dp <= '1';
    led1_dp <= '1';
    led0_dp <= '1';
    
    --ledR0 <= done_out;

end STR;
	 