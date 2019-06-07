library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use ieee.fixed_pkg.all;

--8 inputs per neuron
--3 neurons in this layer

entity out_layer is
	generic (
		left				: positive := 7;
		right				: integer  := -24;
		num_inputs 	: positive := 8;
		num_neurons	: positive := 3);
	port (
		clk 		: in  std_logic;
		rst 		: in  std_logic;
		en  		: in  std_logic;
		input0	, 
		input1	, 
		input2	, 
		input3	,
		input4	,
		input5	,
		input6	,
		input7	: in  sfixed(left downto right);
		out_out0	, 
		out_out1	, 
		out_out2	: out sfixed(left downto right));
end entity ; -- out_layer

architecture out_l of out_layer is

	-----------------------------------------------
	--------------signal declaration---------------
	-----------------------------------------------
	type weight_array is
		array (0 to num_inputs-1) of sfixed(left downto right);
	type neuron_array is
		array (0 to num_neurons-1) of weight_array;
	signal weight : neuron_array;

	type output_array is 
		array (0 to num_neurons-1) of sfixed(left downto right);
	signal out_outputs : output_array;

begin
	
	------------------------------------------------
	-- initialize weights
	------------------------------------------------

	-- weight_neuron_input
	weight(0)(0) <= to_sfixed(1.3713392019271800,input0);
	weight(0)(1) <= to_sfixed(-0.9655234813690180,input0);
	weight(0)(2) <= to_sfixed(-1.0410802364349300,input0);
	weight(0)(3) <= to_sfixed(-0.6855754852294920,input0);
	weight(0)(4) <= to_sfixed(0.5592085123062130,input0);
	weight(0)(5) <= to_sfixed(0.5090879797935480,input0);
	weight(0)(6) <= to_sfixed(-1.2028673887252800,input0);
	weight(0)(7) <= to_sfixed(-0.6790493726730340,input0);
	weight(1)(0) <= to_sfixed(0.2547280788421630,input0);
	weight(1)(1) <= to_sfixed(-0.0610295087099075,input0);
	weight(1)(2) <= to_sfixed(-0.3029798865318290,input0);
	weight(1)(3) <= to_sfixed(-0.8802636265754690,input0);
	weight(1)(4) <= to_sfixed(0.2388054579496380,input0);
	weight(1)(5) <= to_sfixed(-0.5593675971031180,input0);
	weight(1)(6) <= to_sfixed(-1.3319803476333600,input0);
	weight(1)(7) <= to_sfixed(-0.7124512791633600,input0);
	weight(2)(0) <= to_sfixed(-0.5903463959693900,input0);
	weight(2)(1) <= to_sfixed(-0.0786345452070236,input0);
	weight(2)(2) <= to_sfixed(-0.7484022974967950,input0);
	weight(2)(3) <= to_sfixed(0.3647100925445550,input0);
	weight(2)(4) <= to_sfixed(-0.0294764786958694,input0);
	weight(2)(5) <= to_sfixed(-0.8266664743423460,input0);
	weight(2)(6) <= to_sfixed(0.6619225144386290,input0);
	weight(2)(7) <= to_sfixed(0.6431452035903930,input0);

	------------------------------------------------
	-- instantiate neurons
	------------------------------------------------
	U_out_NEURONS : for i in 0 to num_neurons-1 generate
		U_out_NEURON : entity work.out_neuron(out_n)
		generic map(
			left				=> left,
			right				=> right,
			num_inputs 	=> num_inputs,
			num_neurons	=> num_neurons)
		port map(
			clk 		=> clk,
			rst 		=> rst,
			en  		=> en,
			input0	=> input0,
			input1	=> input1,
			input2	=> input2,
			input3	=> input3,
			input4	=> input4,
			input5	=> input5,
			input6	=> input6,
			input7	=> input7,
			weight0	=> weight(i)(0),
			weight1	=> weight(i)(1),
			weight2	=> weight(i)(2),
			weight3	=> weight(i)(3),
			weight4	=> weight(i)(4),
			weight5	=> weight(i)(5),
			weight6	=> weight(i)(6),
			weight7	=> weight(i)(7),
			output 	=> out_outputs(i));
	end generate U_out_NEURONS;

	out_out0 <= out_outputs(0);
	out_out1 <= out_outputs(1);
	out_out2 <= out_outputs(2);

end out_l;







-- weights
-- 1.3713392019271800
-- -0.9655234813690180
-- -1.0410802364349300
-- -0.6855754852294920
-- 0.5592085123062130
-- 0.5090879797935480
-- -1.2028673887252800
-- -0.6790493726730340
-- 0.2547280788421630
-- -0.0610295087099075
-- -0.3029798865318290
-- -0.8802636265754690
-- 0.2388054579496380
-- -0.5593675971031180
-- -1.3319803476333600
-- -0.7124512791633600
-- -0.5903463959693900
-- -0.0786345452070236
-- -0.7484022974967950
-- 0.3647100925445550
-- -0.0294764786958694
-- -0.8266664743423460
-- 0.6619225144386290
-- 0.6431452035903930


