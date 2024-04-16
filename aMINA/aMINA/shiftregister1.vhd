LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY altera_mf;
USE altera_mf.all;

ENTITY shiftregister1 IS
	PORT
	(
		clock		: IN STD_LOGIC ;
		shiftin		: IN STD_LOGIC_VECTOR (11 DOWNTO 0);
		shiftout		: OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
		taps		: OUT STD_LOGIC_VECTOR (11 DOWNTO 0)
		
	);
END shiftregister1;


ARCHITECTURE SYN OF shiftregister1 IS

	SIGNAL sub_wire0	: STD_LOGIC_VECTOR (11 DOWNTO 0);
	SIGNAL sub_wire1	: STD_LOGIC_VECTOR (11 DOWNTO 0);



	COMPONENT altshift_taps
	GENERIC (
		intended_device_family		: STRING;
		lpm_hint		: STRING;
		lpm_type		: STRING;
		tap_distance		: NATURAL;
		width		: NATURAL;
		number_of_taps		: NATURAL
	);
	PORT (
			clock	: IN STD_LOGIC ;
			shiftin	: IN STD_LOGIC_VECTOR (11 DOWNTO 0);
			shiftout	: OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
			taps	: OUT STD_LOGIC_VECTOR (11 DOWNTO 0)
	);
	END COMPONENT;

BEGIN
	shiftout    <= sub_wire0(11 DOWNTO 0);
	taps    <= sub_wire1(11 DOWNTO 0);
	ALTSHIFT_TAPS_component : ALTSHIFT_TAPS

	GENERIC MAP(
		intended_device_family => "Cyclone IV GX",
		lpm_hint => "RAM_BLOCK_TYPE=AUTO",
		lpm_type => "altshift_taps",
		number_of_taps =>1 ,
		tap_distance => 128,
		width => 12
	)
	PORT MAP (
		clock => clock,
		shiftin => shiftin,
		shiftout => sub_wire0,
		taps => sub_wire1
	);



END SYN;