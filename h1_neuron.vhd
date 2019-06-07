library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use ieee.fixed_pkg.all;

--4  inputs per neuron
--10 neurons in this layer

entity h1_neuron is
	generic (
		left				: positive := 7;
		right				: integer  := -24;
		num_inputs 	: positive := 4;
		num_neurons	: positive := 10);
	port (
		clk 		: in  std_logic;
		rst 		: in  std_logic;
		en  		: in  std_logic;
		input0	, 
		input1	, 
		input2	, 
		input3	: in  sfixed(left downto right);
		weight0	, 
		weight1	, 
		weight2	, 
		weight3	: in  sfixed(left downto right);
		output 	: out sfixed(left downto right));
end entity ; -- h1_neuron

architecture h1_n of h1_neuron is

	------------------------------------------------
	------signal declarations from components-------
	------------------------------------------------

	-- placing inputs in an array
	type input_reg_array is 
		array (0 to num_inputs-1) of sfixed(left downto right);
	signal input_regs_in : input_reg_array;

	-- placing weights in an array
	type weight_array is
		array (0 to num_inputs-1) of sfixed(left downto right);
	signal weights : weight_array;
	
	-- Input regs
	signal input_regs_out : input_reg_array;

	-- Weight regs
	signal weight_regs_out : weight_array;

	-- Multiply weights with inputs (and register output)
	type mult_reg_array is 
		array (0 to num_inputs-1) of sfixed(left downto right);
	signal mult_regs : mult_reg_array;

	-- add products round 1
	type add_reg_array0 is 
		array (0 to (num_inputs/2)-1) of sfixed(left downto right);
	signal add_regs0 : add_reg_array0;

	-- add sums round 2 (final for 4 input neurons)
	signal add_reg1 : sfixed(left downto right);


begin
	
	------------------------------------------------
	-- initialize arrays
	------------------------------------------------
	input_regs_in(0) <= input0;
	input_regs_in(1) <= input1;
	input_regs_in(2) <= input2;
	input_regs_in(3) <= input3;

	weights(0) <= weight0;
	weights(1) <= weight1;
	weights(2) <= weight2;
	weights(3) <= weight3;

	------------------------------------------------
	-- input registers
	------------------------------------------------
	U_INPUT_REGS : for i in 0 to num_inputs-1 generate
		U_REG_IN	: entity work.reg
		generic map(
			left  	=> left,
			right 	=> right)
		port map(
			clk			=> clk,
			rst			=> rst,
			en			=> en,
			input		=> input_regs_in(i),
			output	=> input_regs_out(i));
	end generate U_INPUT_REGS;

	------------------------------------------------
	-- weight registers
	------------------------------------------------
	U_WEIGHT_REGS : for i in 0 to num_inputs-1 generate
		U_REG_IN	: entity work.reg
		generic map(
			left  	=> left,
			right 	=> right)
		port map(
			clk			=> clk,
			rst			=> rst,
			en			=> en,
			input		=> weights(i),
			output	=> weight_regs_out(i));
	end generate U_WEIGHT_REGS;

	------------------------------------------------
	-- multiply registers
	------------------------------------------------
	U_MULT_REGS : for i in 0 to num_inputs-1 generate
		U_MULT 	: entity work.mult
			generic map(
				left	=> left,
				right	=> right)
			port map(
				clk 	=> clk,
				rst 	=> rst,
				in1  	=> input_regs_out(i),
				in2  	=> weight_regs_out(i),
				prod 	=> mult_regs(i));
	end generate U_MULT_REGS;

	------------------------------------------------
	-- sum component (2 clocks) -- may try to accomplish in 1 clock
	------------------------------------------------
	U_ADD_REGS : for i in 0 to (num_inputs/2)-1 generate
		U_ADD_0  : entity work.add(GOOD_ADD)
			generic map(
				left	=> left,
				right	=> right)
			port map(
				clk 	=> clk,
				rst 	=> rst,
				in1  	=> mult_regs(i),
				in2 	=> mult_regs(i+2),
				sum 	=> add_regs0(i));
	end generate U_ADD_REGS;

	--next clock
	U_ADD_1  : entity work.add(GOOD_ADD)
		generic map(
			left	=> left,
			right	=> right)
		port map(
			clk 	=> clk,
			rst 	=> rst,
			in1  	=> add_regs0(0),
			in2 	=> add_regs0(1),
			sum 	=> add_reg1);

	--sigmoid block
	U_SIG_APPROX : entity work.sigmoid_approx_top
		generic map(
			left	=> left,
			right	=> right)
		port map(
			clk 	=> clk,
			rst 	=> rst,
			x 		=> add_reg1,
			y 		=> output);


end h1_n;