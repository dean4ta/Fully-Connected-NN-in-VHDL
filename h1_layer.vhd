library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use ieee.fixed_pkg.all;

--4  inputs per neuron
--10 neurons in this layer

entity h1_layer is
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
		h1_out0	, 
		h1_out1	, 
		h1_out2	, 
		h1_out3	, 
		h1_out4	, 
		h1_out5	, 
		h1_out6	, 
		h1_out7	, 
		h1_out8	, 
		h1_out9	: out sfixed(left downto right));
end entity ; -- h1_layer

architecture h1_l of h1_layer is

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
	signal h1_outputs : output_array;

begin
	
	------------------------------------------------
	-- initialize weights
	------------------------------------------------
	--input_regs_in(0) <= input0;
	--input_regs_in(1) <= input1;
	--input_regs_in(2) <= input2;
	--input_regs_in(3) <= input3;

	--weights(0) <= weight0;
	--weights(1) <= weight1;
	--weights(2) <= weight2;
	--weights(3) <= weight3;

	-- weight_neuron_input
	weight(0)(0) <= to_sfixed(-0.401552319526672,input0);
	weight(0)(1) <= to_sfixed(-0.588973939418792,input0);
	weight(0)(2) <= to_sfixed(1.011970877647390,input0);
	weight(0)(3) <= to_sfixed(0.913053274154663,input0);
	weight(1)(0) <= to_sfixed(0.642535388469696,input0);
	weight(1)(1) <= to_sfixed(1.329993724822990,input0);
	weight(1)(2) <= to_sfixed(1.323449611663810,input0);
	weight(1)(3) <= to_sfixed(0.612206459045410,input0);
	weight(2)(0) <= to_sfixed(-0.043198827654123,input0);
	weight(2)(1) <= to_sfixed(0.115063503384590,input0);
	weight(2)(2) <= to_sfixed(0.395491570234298,input0);
	weight(2)(3) <= to_sfixed(0.767061829566955,input0);
	weight(3)(0) <= to_sfixed(0.022126968950033,input0);
	weight(3)(1) <= to_sfixed(-0.975434124469757,input0);
	weight(3)(2) <= to_sfixed(0.810699045658111,input0);
	weight(3)(3) <= to_sfixed(0.401130080223083,input0);
	weight(4)(0) <= to_sfixed(0.090278275310993,input0);
	weight(4)(1) <= to_sfixed(0.770248174667358,input0);
	weight(4)(2) <= to_sfixed(-0.731987595558166,input0);
	weight(4)(3) <= to_sfixed(-0.444974660873413,input0);
	weight(5)(0) <= to_sfixed(-0.005671619437635,input0);
	weight(5)(1) <= to_sfixed(0.822614848613739,input0);
	weight(5)(2) <= to_sfixed(-0.467894285917282,input0);
	weight(5)(3) <= to_sfixed(-1.210180878639220,input0);
	weight(6)(0) <= to_sfixed(-0.271065056324005,input0);
	weight(6)(1) <= to_sfixed(-1.106544017791740,input0);
	weight(6)(2) <= to_sfixed(1.332951784133910,input0);
	weight(6)(3) <= to_sfixed(0.636383116245269,input0);
	weight(7)(0) <= to_sfixed(0.029566150158644,input0);
	weight(7)(1) <= to_sfixed(1.048734664916990,input0);
	weight(7)(2) <= to_sfixed(-0.727931618690490,input0);
	weight(7)(3) <= to_sfixed(-0.762929260730743,input0);
	weight(8)(0) <= to_sfixed(-0.122225403785705,input0);
	weight(8)(1) <= to_sfixed(-0.878108024597167,input0);
	weight(8)(2) <= to_sfixed(0.715409100055694,input0);
	weight(8)(3) <= to_sfixed(1.042201399803160,input0);
	weight(9)(0) <= to_sfixed(0.926824212074279,input0);
	weight(9)(1) <= to_sfixed(1.130396962165830,input0);
	weight(9)(2) <= to_sfixed(1.027786731719970,input0);
	weight(9)(3) <= to_sfixed(0.770504236221313,input0);


	------------------------------------------------
	-- instantiate neurons
	------------------------------------------------
	U_H1_NEURONS : for i in 0 to num_neurons-1 generate
		U_H1_NEURON : entity work.h1_neuron(h1_n)
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
			weight0	=> weight(i)(0),
			weight1	=> weight(i)(1),
			weight2	=> weight(i)(2),
			weight3	=> weight(i)(3),
			output 	=> h1_outputs(i));
	end generate U_H1_NEURONS;

	h1_out0 <= h1_outputs(0);
	h1_out1 <= h1_outputs(1);
	h1_out2 <= h1_outputs(2);
	h1_out3 <= h1_outputs(3);
	h1_out4 <= h1_outputs(4);
	h1_out5 <= h1_outputs(5);
	h1_out6 <= h1_outputs(6);
	h1_out7 <= h1_outputs(7);
	h1_out8 <= h1_outputs(8);
	h1_out9 <= h1_outputs(9);

end h1_l;


-- weights
-- -0.401552319526672
-- -0.588973939418792
-- 1.011970877647390
-- 0.913053274154663
-- 0.642535388469696
-- 1.329993724822990
-- 1.323449611663810
-- 0.612206459045410
-- -0.043198827654123
-- 0.115063503384590
-- 0.395491570234298
-- 0.767061829566955
-- 0.022126968950033
-- -0.975434124469757
-- 0.810699045658111
-- 0.401130080223083
-- 0.090278275310993
-- 0.770248174667358
-- -0.731987595558166
-- -0.444974660873413
-- -0.005671619437635
-- 0.822614848613739
-- -0.467894285917282
-- -1.210180878639220
-- -0.271065056324005
-- -1.106544017791740
-- 1.332951784133910
-- 0.636383116245269
-- 0.029566150158644
-- 1.048734664916990
-- -0.727931618690490
-- -0.762929260730743
-- -0.122225403785705
-- -0.878108024597167
-- 0.715409100055694
-- 1.042201399803160
-- 0.926824212074279
-- 1.130396962165830
-- 1.027786731719970
-- 0.770504236221313
