

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

entity corrsymbole is
port(
 CLK : in std_logic;
 RSTn : in std_logic;
 In_re : in std_logic_vector(11 downto 0);
 Corr_symbole : out std_logic_vector(16 downto 0);
 Evalue : in std_logic;
 Corr_Tram : out std_logic_vector(18 downto 0));
end entity;

architecture arch of corrsymbole is
component shiftregister1 IS
	PORT
	(
		clock		: IN STD_LOGIC ;
		shiftin		: IN STD_LOGIC_VECTOR (11 DOWNTO 0);
		shiftout		: OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
		taps		: OUT STD_LOGIC_VECTOR (1535 DOWNTO 0)
	);
END component;


component shiftregister2 IS
	PORT
	(
		clock		: IN STD_LOGIC ;
		shiftin		: IN STD_LOGIC_VECTOR (16 DOWNTO 0);
		shiftout		: OUT STD_LOGIC_VECTOR (16 DOWNTO 0);
		taps		: OUT STD_LOGIC_VECTOR (16 DOWNTO 0)
	);
END component;



signal O1 , O2 , s_in_retard0 ,s_in_re , s_in_retard1 , s_int4 : std_logic_vector(11 downto 0) ;
signal s_add_0 , s_add_1 : std_logic_vector(11 downto 0);
signal s_int2 , s_int3  , s_int0 , s_int1 : std_logic_vector(16 downto 0);
signal s_int5 , s_int6 , s_int7 , s_int8 , s_int9    : std_logic_vector(18 downto 0);


begin


SR1 : shiftregister1 port map (  clock => CLK ,  shiftin => In_re , shiftout => O1 , taps => open);
SR2 : shiftregister1 port map (  clock => CLK ,  shiftin => O1 , shiftout => O2 , taps => open);
SR3 : shiftregister2 port map (  clock => CLK ,  shiftin => s_int0 , shiftout => s_int1 , taps => open);

 process(RSTn , CLK)
        begin
          if (RSTn = '0') then 
              s_in_re <= (others =>'0');
              s_in_retard0 <= (others => '0');
              s_int3 <= (others => '0');
          elsif rising_edge(CLK) then
              s_in_retard0 <= O2;
              s_in_re <= In_re;
              s_int3 <= s_int2;
          end if ;
        end process;
        
        
    
        
ADD1 :  s_add_0 <=  s_in_retard0 - s_in_re;

Op1 : process(RSTn , CLK)
        begin
          if (RSTn = '0') then 
              s_int0 <= (others =>'0');
          elsif rising_edge(CLK) then
              if(s_add_0(11) ='1') then
              s_int0<= -(s_add_0(11)&s_add_0(11)&s_add_0(11)&s_add_0(11)&s_add_0(11)&s_add_0);
              elsif (s_add_0(11) ='0') then
              s_int0 <= (s_add_0(11)&s_add_0(11)&s_add_0(11)&s_add_0(11)&s_add_0(11)&s_add_0);
            end if ;
          end if ;
        end process;
        
op3 :   process(RSTn , CLK)
        begin
          if (RSTn = '0') then 
               s_int4<= (others =>'0');
          elsif rising_edge(CLK) then
              if(s_add_1(11) ='1') then
              s_int4<= -s_add_1;
              elsif (s_add_1(11) ='0') then
              s_int4<= s_add_1;
            end if ;
          end if ;
        end process;

Op2 : s_int2 <= s_int3 + s_int0 - s_int1;

Corr_symbole <= s_int3;



 process(RSTn , CLK)
        begin
          if (RSTn = '0') then 
              s_int9 <= (others =>'0');
              s_in_retard1 <= (others => '0');
              s_int7 <= (others => '0');
          elsif rising_edge(CLK) then
              s_in_retard1 <= O1;
              s_int7 <= s_int6;
              s_int9 <= s_int8;
          end if ;
        end process;  



ADD2 :  s_add_1 <=  s_in_retard1 -s_in_re;
Op4 : s_int5 <= s_int4 + s_int7;


s_int8 <= s_int9 when Evalue ='0' else s_int7;
s_int6 <= s_int5 when Evalue ='0' else "0000000000000000000";
Corr_Tram <= s_int9;

end arch;

