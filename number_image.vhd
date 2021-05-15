-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.all;
-------------------------------------------------------------------------------
ENTITY number_image IS
	GENERIC	(DATA_WIDTH: INTEGER := 4;
				 ADDR_WIDTH: INTEGER := 3);
	PORT	(	limite_x, limite_y:	IN 	STD_LOGIC_VECTOR(9 DOWNTO 0);
				pos_x, pos_y		: 	IN 	STD_LOGIC_VECTOR(9 DOWNTO 0);
				R, G, B 				: 	OUT 	STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END ENTITY number_image;
ARCHITECTURE structural OF number_image IS
	
	TYPE mem_2d_type IS ARRAY (0 to 2**ADDR_WIDTH-1) OF STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
	SIGNAL array_reg_0	:	mem_2d_type;
	SIGNAL array_reg_1	:	mem_2d_type;
	SIGNAL array_reg_2	:	mem_2d_type;
	SIGNAL array_reg_3	:	mem_2d_type;
	SIGNAL array_reg_4	:	mem_2d_type;
	SIGNAL array_reg_5	:	mem_2d_type;
	SIGNAL array_reg_6	:	mem_2d_type;
	SIGNAL array_reg_7	:	mem_2d_type;
	SIGNAL array_reg_8	:	mem_2d_type;
	SIGNAL array_reg_9	:	mem_2d_type;
	
	SIGNAL digit_0	:	mem_2d_type;
	SIGNAL digit_1	:	mem_2d_type;
	SIGNAL digit_2	:	mem_2d_type;
	SIGNAL digit_3	:	mem_2d_type;
	SIGNAL digit_4	:	mem_2d_type;
	
	SIGNAL pos_y_divided	: 	STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL pos_x_divided	: 	STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL mem				: 	STD_LOGIC;
	
	SIGNAL R_color : STD_LOGIC_VECTOR(3 downto 0) := "1111";
	SIGNAL G_color : STD_LOGIC_VECTOR(3 downto 0) := "1111";
	SIGNAL B_color : STD_LOGIC_VECTOR(3 downto 0) := "1111";
	
	SIGNAL number_score	: 	STD_LOGIC_VECTOR(16 DOWNTO 0);
	
	SIGNAL unidades 		: STD_LOGIC_VECTOR(3 downto 0) := "0001";
	SIGNAL decenas 		: STD_LOGIC_VECTOR(3 downto 0) := "0110";
	SIGNAL centenas 		: STD_LOGIC_VECTOR(3 downto 0) := "0001";
	SIGNAL miles 			: STD_LOGIC_VECTOR(3 downto 0) := "0011";
	SIGNAL decenas_miles : STD_LOGIC_VECTOR(3 downto 0) := "0101";
	

 BEGIN 
	
	number_score <= "11000011010011111";
	-- 0
	array_reg_0(0) <= "0111";
	array_reg_0(1) <= "0101";
	array_reg_0(2) <= "0101";
	array_reg_0(3) <= "0101";
	array_reg_0(4) <= "0111";
	
	-- 1
	array_reg_1(0) <= "0010";
	array_reg_1(1) <= "0011";
	array_reg_1(2) <= "0010";
	array_reg_1(3) <= "0010";
	array_reg_1(4) <= "0111";
	
	-- 2
	array_reg_2(0) <= "0111";
	array_reg_2(1) <= "0100";
	array_reg_2(2) <= "0010";
	array_reg_2(3) <= "0001";
	array_reg_2(4) <= "0111";
	
	-- 3
	array_reg_3(0) <= "0111";
	array_reg_3(1) <= "0100";
	array_reg_3(2) <= "0010";
	array_reg_3(3) <= "0100";
	array_reg_3(4) <= "0111";
	
	-- 4
	array_reg_4(0) <= "0101";
	array_reg_4(1) <= "0101";
	array_reg_4(2) <= "0111";
	array_reg_4(3) <= "0100";
	array_reg_4(4) <= "0100";
	
	-- 5
	array_reg_5(0) <= "0111";
	array_reg_5(1) <= "0001";
	array_reg_5(2) <= "0111";
	array_reg_5(3) <= "0100";
	array_reg_5(4) <= "0111";
	
	-- 6
	array_reg_6(0) <= "0111";
	array_reg_6(1) <= "0001";
	array_reg_6(2) <= "0111";
	array_reg_6(3) <= "0101";
	array_reg_6(4) <= "0111";
	
	-- 7
	array_reg_7(0) <= "0111";
	array_reg_7(1) <= "0100";
	array_reg_7(2) <= "0100";
	array_reg_7(3) <= "0100";
	array_reg_7(4) <= "0100";
	
	-- 8
	array_reg_8(0) <= "0111";
	array_reg_8(1) <= "0101";
	array_reg_8(2) <= "0111";
	array_reg_8(3) <= "0101";
	array_reg_8(4) <= "0111";
	
	-- 9
	array_reg_9(0) <= "0111";
	array_reg_9(1) <= "0101";
	array_reg_9(2) <= "0111";
	array_reg_9(3) <= "0100";
	array_reg_9(4) <= "0111";
	
	digit_0 <= array_reg_0;
	digit_1 <= array_reg_1;
	digit_2 <= array_reg_2;
	digit_3 <= array_reg_3;
	digit_4 <= array_reg_4;
	
	PROCESS(pos_x, pos_y, number_score,decenas_miles)
	BEGIN
		
		pos_y_divided <= std_logic_vector((unsigned(pos_y)-unsigned(limite_y))/5);
		pos_x_divided <= std_logic_vector((unsigned(pos_x)-unsigned(limite_x))/5);
		-- Decenas de miles
		IF (unsigned(pos_x_divided)>=0 AND unsigned(pos_x_divided)<=3) THEN
			IF (decenas_miles = "0000") THEN 
				mem <= 	array_reg_0(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSIF (decenas_miles = "0001") THEN  
				mem <= 	array_reg_1(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSIF (decenas_miles = "0010") THEN 
				mem <= 	array_reg_2(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSIF (decenas_miles = "0011") THEN 
				mem <=	array_reg_3(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSIF (decenas_miles = "0100") THEN  
				mem <=	array_reg_4(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSIF (decenas_miles = "0101") THEN 
				mem <=	array_reg_5(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSIF (decenas_miles = "0110") THEN  
				mem <=	array_reg_6(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSIF (decenas_miles = "0111") THEN  
				mem <=	array_reg_7(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSIF (decenas_miles = "1000" ) THEN  
				mem <=	array_reg_8(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSIF (decenas_miles = "1001") THEN 
				mem <=	array_reg_9(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSE 
				mem <=	'0';
			END IF;
		-- Miles
		ELSIF (unsigned(pos_x_divided)>=4 AND unsigned(pos_x_divided)<=7) THEN
			IF (miles = "0000") THEN 
				mem <= 	array_reg_0(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSIF (miles = "0001") THEN  
				mem <= 	array_reg_1(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSIF (miles = "0010") THEN 
				mem <= 	array_reg_2(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSIF (miles = "0011") THEN 
				mem <=	array_reg_3(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSIF (miles = "0100") THEN  
				mem <=	array_reg_4(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSIF (miles = "0101") THEN 
				mem <=	array_reg_5(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSIF (miles = "0110") THEN  
				mem <=	array_reg_6(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSIF (miles = "0111") THEN  
				mem <=	array_reg_7(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSIF (miles = "1000" ) THEN  
				mem <=	array_reg_8(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSIF (miles = "1001") THEN 
				mem <=	array_reg_9(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSE 
				mem <=	'0';
			END IF;
		-- Centenas
		ELSIF (unsigned(pos_x_divided)>=8 AND unsigned(pos_x_divided)<=11) THEN
			IF (centenas = "0000") THEN 
				mem <= 	array_reg_0(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSIF (centenas = "0001") THEN  
				mem <= 	array_reg_1(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSIF (centenas = "0010") THEN 
				mem <= 	array_reg_2(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSIF (centenas = "0011") THEN 
				mem <=	array_reg_3(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSIF (centenas = "0100") THEN  
				mem <=	array_reg_4(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSIF (centenas = "0101") THEN 
				mem <=	array_reg_5(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSIF (centenas = "0110") THEN  
				mem <=	array_reg_6(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSIF (centenas = "0111") THEN  
				mem <=	array_reg_7(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSIF (centenas = "1000" ) THEN  
				mem <=	array_reg_8(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSIF (centenas = "1001") THEN 
				mem <=	array_reg_9(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSE 
				mem <=	'0';
			END IF;
		-- Decenas
		ELSIF (unsigned(pos_x_divided)>=12 AND unsigned(pos_x_divided)<=15) THEN
			IF (decenas = "0000") THEN 
				mem <= 	array_reg_0(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSIF (decenas = "0001") THEN  
				mem <= 	array_reg_1(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSIF (decenas = "0010") THEN 
				mem <= 	array_reg_2(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSIF (decenas = "0011") THEN 
				mem <=	array_reg_3(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSIF (decenas = "0100") THEN  
				mem <=	array_reg_4(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSIF (decenas = "0101") THEN 
				mem <=	array_reg_5(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSIF (decenas = "0110") THEN  
				mem <=	array_reg_6(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSIF (decenas = "0111") THEN  
				mem <=	array_reg_7(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSIF (decenas = "1000" ) THEN  
				mem <=	array_reg_8(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSIF (decenas = "1001") THEN 
				mem <=	array_reg_9(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSE 
				mem <=	'0';
			END IF;
		-- Unidades
		ELSIF (unsigned(pos_x_divided)>=16 AND unsigned(pos_x_divided)<=19) THEN
			IF (unidades = "0000") THEN 
				mem <= 	array_reg_0(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSIF (unidades = "0001") THEN  
				mem <= 	array_reg_1(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSIF (unidades = "0010") THEN 
				mem <= 	array_reg_2(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSIF (unidades = "0011") THEN 
				mem <=	array_reg_3(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSIF (unidades = "0100") THEN  
				mem <=	array_reg_4(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSIF (unidades = "0101") THEN 
				mem <=	array_reg_5(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSIF (unidades = "0110") THEN  
				mem <=	array_reg_6(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSIF (unidades = "0111") THEN  
				mem <=	array_reg_7(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSIF (unidades = "1000" ) THEN  
				mem <=	array_reg_8(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSIF (unidades = "1001") THEN 
				mem <=	array_reg_9(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
			ELSE 
				mem <=	'0';
			END IF;
		ELSE 
			mem <= '0';
		END IF;
		IF (mem = '1') THEN 
			R <= R_color;
			G <= G_color;
			B <= B_color;
		ELSE
			R <= "0000";
			G <= "0000";
			B <= "0000";
		END IF;
	END PROCESS;
	
END ARCHITECTURE structural;