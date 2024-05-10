library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity factorial is
  generic(
    WIDTH         :   positive := 32);
  port(
    clk     : in  std_logic;
    rst     : in  std_logic;
    n       : in  std_logic_vector(width-1 downto 0);
    go      : in  std_logic;
    done    : out std_logic;
    output  : out std_logic_vector(WIDTH-1 downto 0)

  );
end factorial;

architecture FSMD of factorial is

  -- Fill in with your code
  type STATE_TYPE is (S_START, S_FACTORIAL, S_DONE, S_RESTART);  
  signal state : STATE_TYPE;  
  signal tempFact : std_logic_vector(WIDTH-1 downto 0);
  signal regN : std_logic_vector(WIDTH-1 downto 0);

 

begin 
  
    process (clk, rst)  
    begin    
        if (rst = '1') then      
            state <= S_START;      
            done  <= '0';      
            tempFact <= std_logic_vector(to_unsigned(0, WIDTH));
            regN <= std_logic_vector(to_unsigned(0, WIDTH) mod 4);        
            
        elsif (clk = '1' and clk'event) then      
            case state is    
            
                when S_START =>          
                    done  <= '0';          
                    
                    --Load regN, tempfact
                    regN <= n ;
                    tempFact <= std_logic_vector(to_unsigned(1, WIDTH));
                    
                    --Advance to next state
                    if (go = '0') then            
                        state <= S_START;          
                    else            
                        state <= S_FACTORIAL;         
                    end if;        
                    
                when S_FACTORIAL =>          
                    done  <= '0';          
                    if(unsigned(regN) >= 1) then                    
                        tempFact <=  std_logic_vector(to_unsigned(to_integer(unsigned(tempFact)) * to_integer(unsigned(regN)),WIDTH)); 
                        regn <= std_logic_vector(to_unsigned(to_integer(unsigned(regn)) - 1 ,WIDTH)); 
                        state <= S_FACTORIAL; 
                    else
                        state <= S_DONE;
                    end if;
                
                        
                when S_DONE =>          
                    done  <= '1';          
                    state <= S_RESTART;    
                    output <= tempFact;

                when S_RESTART =>
					done  <= '0'; 
                    if (go = '1') then            
                        state <= S_RESTART;          
                    else            
                        state <= S_START;         
                    end if;        
                    
                
                when others => null;
                
            end case;    
        end if;  
    end process; 
end FSMD;

