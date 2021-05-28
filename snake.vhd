---------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.all;
-------------------------------------------------------------------------------
ENTITY snake IS
	GENERIC (N				      :	INTEGER	:=	9;
				DATA_WIDTH			: 	INTEGER	:=	119;
				ADDR_WIDTH			:  INTEGER	:=	7;
				DATA_WIDTH2			:	INTEGER	:=	14);
	PORT	(	clk					:  IN 	STD_LOGIC;
				rst					:  IN    STD_LOGIC;
				stop					: 	IN 	STD_LOGIC;
				pintar_x				:  OUT 	STD_LOGIC_VECTOR(5 DOWNTO 0);
				pintar_y				:  OUT  	STD_LOGIC_VECTOR(5 DOWNTO 0);
				we						:  OUT  	STD_LOGIC;
				pintar_despintar	: 	OUT	STD_LOGIC;
				buttonUp, buttonDown, buttonLeft, buttonRight : IN STD_LOGIC;
				food_x			  :	IN 	STD_LOGIC_VECTOR(5 DOWNTO 0);
				food_y			  :	IN 	STD_LOGIC_VECTOR(5 DOWNTO 0);
				comida			  :	OUT 	STD_LOGIC);
END ENTITY snake;
ARCHITECTURE structural OF snake IS

	--
	SIGNAL pintar_x_s				:  STD_LOGIC_VECTOR(5 DOWNTO 0);
	SIGNAL pintar_y_s				:  STD_LOGIC_VECTOR(5 DOWNTO 0);
	SIGNAL we_s						:	STD_LOGIC;
	SIGNAL pintar_despintar_s	:	STD_LOGIC;
	
	SIGNAL max_tick_s		:	STD_LOGIC;
	SIGNAL ena_tb			:	STD_LOGIC := '1';
	SIGNAL syn_tb			:	STD_LOGIC := '0';
	SIGNAL min_tickRY_s	:	STD_LOGIC;
	SIGNAL counterRY_s	:	STD_LOGIC_VECTOR(25 DOWNTO 0);
	--
	
	SIGNAL x_signal    : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL y_signal    : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL head_x      : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL head_y      : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL data_wr		 : STD_LOGIC_VECTOR(13 DOWNTO 0);
	SIGNAL data_rd		 : STD_LOGIC_VECTOR(13 DOWNTO 0);
	SIGNAL rd_signal   : STD_LOGIC;
	SIGNAL wr_signal   : STD_LOGIC;
	SIGNAL ef			 : STD_LOGIC;
	SIGNAL comida_sig	 : STD_LOGIC;
	

 BEGIN 
 
	fsm : ENTITY work.snake_controller
	PORT MAP(clk		    	=>	clk,	
				rst			 	=>	rst,
				stop				=> stop,
				max_tick		 	=>	max_tick_s,
				pintar_x	 		=>	pintar_x,		
				pintar_y 		=>	pintar_y,
				we		 			=>	we,
				pintar_despintar => pintar_despintar,
				ena_timer		=> ena_tb,
				syn_clr_timer	=> syn_tb,
				buttonUp     =>   buttonUp,
				buttonDown   =>   buttonDown,
				buttonLeft   =>   buttonLeft,
				buttonRight  =>   buttonRight,
				food_x		=> food_x,
				food_y		=> food_y,
				comida		=> comida);
				
	TMR: 		ENTITY work.timer_mov
			PORT MAP(  	clk	=> clk,
							rst	=> rst,
							ena	=> ena_tb, 
							syn_clr	=> syn_tb,
							max_tick	=> max_tick_s,
							min_tick	=> min_tickRY_s,
							counter	=> counterRY_s);
	
END ARCHITECTURE structural;