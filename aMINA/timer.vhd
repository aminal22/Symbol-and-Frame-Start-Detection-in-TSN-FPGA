
Library ieee;
USE ieee.std_logic_1164.all  ; 
USE ieee.std_logic_arith.all ;
USE ieee.std_logic_unsigned.all ;

entity timer is
port (RSTn : in std_logic;
      CLK  : in std_logic;
      Evalue : out std_logic);
end timer;

architecture archi of timer is
  SIGNAL COUNT    :  STD_LOGIC_VECTOR (6 downto 0);  
begin
  
process_count: process (RSTn, CLK)
begin
  if (RSTn = '0') then
			count <= (others => '0');
			Evalue <= '0';
	elsif (CLK'event and CLK = '1') then
			count <= count + 1;
			Evalue <= '0';
			if (count=72) then
			  Evalue <= '1';
			  count <= (others => '0');
			end if;  
	end if;
end process;

end archi;
