
LIBRARY ieee  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.std_logic_arith.all  ; 
USE ieee.STD_LOGIC_SIGNED.all  ; 

library std;
use std.textio.ALL;

ENTITY corrsymbole_tb  IS 
END ; 
 
ARCHITECTURE corrsymbole_tb_arch OF corrsymbole_tb IS
  SIGNAL Corr_symbole   :  std_logic_vector (16 downto 0)  ; 
  SIGNAL Corr_Tram   :  std_logic_vector (18 downto 0)  ; 
  SIGNAL In_re   :  std_logic_vector (11 downto 0)  ; 
  SIGNAL Evalue   :  STD_LOGIC  ; 
  SIGNAL CLK   :  STD_LOGIC  ; 
  SIGNAL RSTn   :  STD_LOGIC  ; 
  COMPONENT corrsymbole  
    PORT ( 
      Corr_symbole  : out std_logic_vector (16 downto 0) ; 
      Corr_Tram  : out std_logic_vector (18 downto 0) ; 
      In_re  : in std_logic_vector (11 downto 0) ; 
      Evalue  : in STD_LOGIC ; 
      CLK  : in STD_LOGIC ; 
      RSTn  : in STD_LOGIC ); 
  END COMPONENT ; 
  
  component timer is
port (RSTn : in std_logic;
      CLK  : in std_logic;
      Evalue : out std_logic);
end component;

BEGIN
  DUT  : corrsymbole
    PORT MAP ( 
      Corr_symbole   => Corr_symbole  ,
      Corr_Tram   => Corr_Tram  ,
      In_re   => In_re  ,
      Evalue   => Evalue  ,
      CLK   => CLK  ,
      RSTn   => RSTn   ) ;
      
   timer_0 : timer
   port map ( Evalue   => Evalue  ,
      CLK   => CLK  ,
      RSTn   => RSTn   ) ;   
      
    process
    begin
      CLK <= '0';
      wait for 10 ns;
      CLK <= '1';
      wait for 10 ns;
end process;  
   RSTn <= '0', '1' after 5 ns;
      
      
LECTURE_data : process
  variable L	: LINE;
  file ENTREE	: TEXT is in	"in_re5_chan2.txt";
  variable A	: integer;
  begin
    WAIT UNTIL CLK'EVENT AND CLK='0';
    LOOP 
        WAIT UNTIL CLK'EVENT AND CLK='0';
	         READLINE(ENTREE, L);
	         READ(L,A);
	         In_re	<= conv_std_logic_vector(A,12); 
    END LOOP;
end process LECTURE_data;
END ; 

