library	ieee;
use	ieee.std_logic_1164.all;
use	ieee.numeric_std.all;
package	mips_pkg	is
	-- Declaracao	de	componentes
	component	ula	is
	generic	(	WSIZE	:	natural	:=	32);
	port	(	
		ulop :	in	std_logic_vector(3	downto	0);
		A,	B :	in	std_logic_vector(WSIZE-1	downto	0);	
		aluout:	out	std_logic_vector(WSIZE-1	downto	0);	
		zero :	out	std_logic	
	);
	end	component;
	
	component	c_ula	is
	port	(
		func	 :	in	std_logic_vector(5	downto	0);
		opUla :	in	std_logic_vector(3	downto	0);
		ctrula	 :	out	std_logic_vector(3	downto	0)
	);
	end	component;
	
	component	breg	is
	generic	(	WSIZE		:	natural	:=	32;
					ISIZE		:	natural	:=	5;
					BREGSIZE	:	natural	:=	32	);
	port	(
		clk 	:	in		std_logic;
		we 	:	in		std_logic;
		rs 	:	in		std_logic_vector(ISIZE-1	downto	0);
		rt 	:	in		std_logic_vector(ISIZE-1	downto	0);
		rd 	:	in		std_logic_vector(ISIZE-1	downto	0);
		d_in 	:	in		std_logic_vector(WSIZE-1	downto	0);
		regA	:	out	std_logic_vector(WSIZE-1	downto	0);
		regB	:	out	std_logic_vector(WSIZE-1	downto	0)
	);
	end component;
	
	component	mux_two_to_one is
	generic	(	WSIZE		: 	natural	:= 32	);
		port(
			sel	:	in std_logic;
			A		:	in std_logic_vector(WSIZE-1 downto 0);
			B		:	in std_logic_vector(WSIZE-1 downto 0);
			X		:	out std_logic_vector(WSIZE-1 downto 0)
		);
	end	component;
	
	component mux_four_to_one is

		port(
			sel	:	in std_logic_vector(1 downto 0);
			A		:	in std_logic_vector(31 downto 0);
			B		:	in std_logic_vector(31 downto 0);
			C		:	in std_logic_vector(31 downto 0);
			D		:	in std_logic_vector(31 downto 0);
			X		:	out std_logic_vector(31 downto 0)
		);
	end component;
	
	component	mux_two_to_one_5 is
	generic	(	WSIZE		: 	natural	:= 5	);
		port(
			sel	:	in std_logic;
			A		:	in std_logic_vector(WSIZE-1 downto 0);
			B		:	in std_logic_vector(WSIZE-1 downto 0);
			X		:	out std_logic_vector(WSIZE-1 downto 0)
		);
	end	component;
	
	component 	pc is
		port(
			din	:	in std_logic_vector(31 downto 0);
			clock	:	in std_logic;
			
			dout	:	out std_logic_vector(31 downto 0)
		);
	end component;
	
	component 	memoria_instrucoes is
		port(
			address		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			clock			: IN STD_LOGIC  := '1';
			q				: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
	end component;
	
	component memoria_dados is
		PORT
		(
			address		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			clock		: IN STD_LOGIC  := '1';
			data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			wren		: IN STD_LOGIC ;
			q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
	end component;
	
	component somador is
		port(
			a	   : in unsigned  (31 downto 0);
			b	   : in unsigned  (31 downto 0);
			result : out unsigned (31 downto 0)
		);
	end component;
	
	component fetch is
		port(
			pc_mais_4	:	in std_logic_vector(31 downto 0);
			reg_dst		: 	in std_logic;
			clock			:	in std_logic;
			clock_mem	:	in std_logic;
			
			opcode		:	out std_logic_vector(5 downto 0);
			r1,r2,r_out	:	out std_logic_vector(4 downto 0);
			pc_out		: 	out std_logic_vector(31 downto 0);
			imed_16		: 	out std_logic_vector(15 downto 0);
			jump_out		:	out std_logic_vector(25 downto 0)
		);
	end component;
	
	component bregula is
	
		port (
			din				:	in std_logic_vector(31 downto 0);
			we, clk			:	in std_logic;
			rs, rt, rd		:	in std_logic_vector(4 downto 0);
			funct				: 	in std_logic_vector(5 downto 0);
			opula				:	in std_logic_vector(3 downto 0);
			ctr_ula_op			:	in std_logic;
			imm_16			:	in std_logic_vector(15 downto 0);
			ctr_ula_lui		:	in	std_logic;
			zero				:	out std_logic;
			ovfl				:	out std_logic;
			dout				:	out std_logic_vector(31 downto 0);
			imm_32			:	out std_logic_vector(31 downto 0);
			mem_data_write	:	out std_logic_vector(31 downto 0);
			ctrjr				:	out std_logic
		);
	
	end component;
	
	component mem_final is
		port(
			address_in		:	in	std_logic_vector(31 downto 0);
			data_to_mux		:	in std_logic_vector(31 downto 0);
			mem_data_write	:	in std_logic_vector(31 downto 0);
			escreve_mem		:	in std_logic;
			le_mem			:	in std_logic;
			mem_para_reg	:	in std_logic;
			clock_mem		: 	in std_logic;
			
			data_wb			:	out std_logic_vector(31 downto 0)
		);
	end component;
	
	component 	epc is
		port(
			din	:	in std_logic_vector(31 downto 0);
			clock	:	in std_logic;
			enable:	in std_logic;
			dout	:	out std_logic_vector(31 downto 0)
		);
	end component;
	
	component controle is
		port(
			op					:	in std_logic_vector(5 downto 0);
			
			op_ula			:	out std_logic_vector(3 downto 0); -- 4 bits da OpUla
			reg_dst,			-- Se o registrador de escrita rt ou rd
			orig_alu,		-- Se a segunda entrada na ula vira do imediato ou nao
			mem_para_reg,	--	O valor para ser escrito no endereco do breg
			escreve_reg,	-- Permite escrever num endereco do breg
			le_mem,			-- Permite a leitura da memoria
			escreve_mem,	-- Permite a escrita na memoria
			branch,			--	Ligado caso haja uma instrucao de branch equal
			branchn,			-- Ligado caso haja uma instrucao de branch not equal
			jump,
			jal,
			luictr,
			jerror
			:	out std_logic
		);
	end component;
	
	-- Controle	ULA_mips
	constant	ULA_AND 		: std_logic_vector(3	downto 0) := "0000";	--  0
	constant	ULA_OR  		: std_logic_vector(3	downto 0) := "0001";	--  1
	constant	ULA_ADD 		: std_logic_vector(3	downto 0) := "0010";	--  2
	constant	ULA_XOR 		: std_logic_vector(3	downto 0) := "0011";	--  3
	constant	ULA_SLL 		: std_logic_vector(3	downto 0) := "0100"; --  4
	constant	ULA_SRL		: std_logic_vector(3	downto 0) := "0101";	--  5
	constant	ULA_SUB 		: std_logic_vector(3	downto 0) := "0110";	--  6
	constant	ULA_SLT 		: std_logic_vector(3	downto 0) := "0111";	--  7
	constant	ULA_SRA		: std_logic_vector(3	downto 0) := "1000";	--  8
	constant	ULA_ADDU 	: std_logic_vector(3	downto 0) := "1001";	--  9
	constant	ULA_SLTU 	: std_logic_vector(3	downto 0) := "1010";	-- 10
	constant	ULA_SUBU 	: std_logic_vector(3	downto 0) := "1011";	-- 11
	constant	ULA_NOR 		: std_logic_vector(3	downto 0) := "1100";	-- 12
	constant ULA_ADDIU 	: std_logic_vector(3 downto 0) := "1101"; -- 13
	constant	ULA_UKW 		: std_logic_vector(3	downto 0) := "XXXX";

end	mips_pkg;