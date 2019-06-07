library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use ieee.fixed_pkg.all;

--10 inputs per neuron
--8  neurons in this layer

entity h2_layer is
	generic (
		left				: positive := 7;
		right				: integer  := -24;
		num_inputs 	: positive := 10;
		num_neurons	: positive := 8);
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
		input7	,
		input8	,
		input9	: in  sfixed(left downto right);
		h2_out0	, 
		h2_out1	, 
		h2_out2	, 
		h2_out3	, 
		h2_out4	, 
		h2_out5	, 
		h2_out6	, 
		h2_out7	: out sfixed(left downto right));
end entity ; -- h2_layer

architecture h2_l of h2_layer is

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
	signal h2_outputs : output_array;

begin
	
	------------------------------------------------
	-- initialize weights
	------------------------------------------------

	-- weight_neuron_input
	weight(0)(0) <= to_sfixed(-0.4483084976673120,input0);
	weight(0)(1) <= to_sfixed(0.2220767438411710,input0);
	weight(0)(2) <= to_sfixed(-0.1095948293805120,input0);
	weight(0)(3) <= to_sfixed(-0.2433978766202920,input0);
	weight(0)(4) <= to_sfixed(1.0310206413269000,input0);
	weight(0)(5) <= to_sfixed(0.5708655118942260,input0);
	weight(0)(6) <= to_sfixed(-1.2616425752639700,input0);
	weight(0)(7) <= to_sfixed(1.2941567897796600,input0);
	weight(0)(8) <= to_sfixed(-0.7053633928298950,input0);
	weight(0)(9) <= to_sfixed(-0.0420025028288364,input0);
	weight(1)(0) <= to_sfixed(0.9365497231483450,input0);
	weight(1)(1) <= to_sfixed(-0.1441999226808540,input0);
	weight(1)(2) <= to_sfixed(0.2871440351009360,input0);
	weight(1)(3) <= to_sfixed(0.8439503908157340,input0);
	weight(1)(4) <= to_sfixed(-1.0433568954467700,input0);
	weight(1)(5) <= to_sfixed(-1.1910307407379100,input0);
	weight(1)(6) <= to_sfixed(0.3737527132034300,input0);
	weight(1)(7) <= to_sfixed(-1.1721686124801600,input0);
	weight(1)(8) <= to_sfixed(0.5652856230735770,input0);
	weight(1)(9) <= to_sfixed(0.0368612073361873,input0);
	weight(2)(0) <= to_sfixed(0.4977403283119200,input0);
	weight(2)(1) <= to_sfixed(-0.3016139864921560,input0);
	weight(2)(2) <= to_sfixed(-0.0395996421575546,input0);
	weight(2)(3) <= to_sfixed(0.8600522875785820,input0);
	weight(2)(4) <= to_sfixed(-0.1136049181222910,input0);
	weight(2)(5) <= to_sfixed(-0.2507859170436850,input0);
	weight(2)(6) <= to_sfixed(0.6603319644927970,input0);
	weight(2)(7) <= to_sfixed(-1.1425879001617400,input0);
	weight(2)(8) <= to_sfixed(0.4599123299121850,input0);
	weight(2)(9) <= to_sfixed(-0.3751863539218900,input0);
	weight(3)(0) <= to_sfixed(-0.4902647733688350,input0);
	weight(3)(1) <= to_sfixed(0.3925968706607810,input0);
	weight(3)(2) <= to_sfixed(0.2631387710571280,input0);
	weight(3)(3) <= to_sfixed(-0.4058147966861720,input0);
	weight(3)(4) <= to_sfixed(0.8877899646759030,input0);
	weight(3)(5) <= to_sfixed(0.6305421590805050,input0);
	weight(3)(6) <= to_sfixed(0.4271792471408840,input0);
	weight(3)(7) <= to_sfixed(0.6249455213546750,input0);
	weight(3)(8) <= to_sfixed(-0.2347116619348520,input0);
	weight(3)(9) <= to_sfixed(0.4278423190116880,input0);
	weight(4)(0) <= to_sfixed(-0.2399447709321970,input0);
	weight(4)(1) <= to_sfixed(0.5480451583862300,input0);
	weight(4)(2) <= to_sfixed(-0.1527913659811010,input0);
	weight(4)(3) <= to_sfixed(0.1432173848152160,input0);
	weight(4)(4) <= to_sfixed(1.1164220571517900,input0);
	weight(4)(5) <= to_sfixed(0.3622194230556480,input0);
	weight(4)(6) <= to_sfixed(-0.9827332496643060,input0);
	weight(4)(7) <= to_sfixed(0.9302722215652460,input0);
	weight(4)(8) <= to_sfixed(-0.6148117184638970,input0);
	weight(4)(9) <= to_sfixed(0.6336559653282160,input0);
	weight(5)(0) <= to_sfixed(0.4377337396144860,input0);
	weight(5)(1) <= to_sfixed(0.4669008255004880,input0);
	weight(5)(2) <= to_sfixed(-0.0881828963756561,input0);
	weight(5)(3) <= to_sfixed(0.8893885612487790,input0);
	weight(5)(4) <= to_sfixed(0.0950784459710121,input0);
	weight(5)(5) <= to_sfixed(-0.0893080905079841,input0);
	weight(5)(6) <= to_sfixed(0.3881981372833250,input0);
	weight(5)(7) <= to_sfixed(-0.3335326313972470,input0);
	weight(5)(8) <= to_sfixed(0.0120839271694421,input0);
	weight(5)(9) <= to_sfixed(0.6417931914329520,input0);
	weight(6)(0) <= to_sfixed(0.8043910861015310,input0);
	weight(6)(1) <= to_sfixed(0.0116184120997786,input0);
	weight(6)(2) <= to_sfixed(0.1416215598583220,input0);
	weight(6)(3) <= to_sfixed(0.7640833258628840,input0);
	weight(6)(4) <= to_sfixed(-0.7700471282005310,input0);
	weight(6)(5) <= to_sfixed(-0.5187344551086420,input0);
	weight(6)(6) <= to_sfixed(0.8416125178337090,input0);
	weight(6)(7) <= to_sfixed(-0.5670269727706900,input0);
	weight(6)(8) <= to_sfixed(0.6992158889770500,input0);
	weight(6)(9) <= to_sfixed(-0.5066489577293390,input0);
	weight(7)(0) <= to_sfixed(1.1327784061431800,input0);
	weight(7)(1) <= to_sfixed(-0.7644956111907950,input0);
	weight(7)(2) <= to_sfixed(-0.1856636106967920,input0);
	weight(7)(3) <= to_sfixed(1.1016606092453000,input0);
	weight(7)(4) <= to_sfixed(-0.2151071280241010,input0);
	weight(7)(5) <= to_sfixed(-1.2052222490310600,input0);
	weight(7)(6) <= to_sfixed(0.9718060493469230,input0);
	weight(7)(7) <= to_sfixed(-1.0208063125610300,input0);
	weight(7)(8) <= to_sfixed(0.7889882922172540,input0);
	weight(7)(9) <= to_sfixed(-0.0367438718676567,input0);

	------------------------------------------------
	-- instantiate neurons
	------------------------------------------------
	U_H2_NEURONS : for i in 0 to num_neurons-1 generate
		U_H2_NEURON : entity work.h2_neuron(h2_n)
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
			input8	=> input8,
			input9	=> input9,
			weight0	=> weight(i)(0),
			weight1	=> weight(i)(1),
			weight2	=> weight(i)(2),
			weight3	=> weight(i)(3),
			weight4	=> weight(i)(4),
			weight5	=> weight(i)(5),
			weight6	=> weight(i)(6),
			weight7	=> weight(i)(7),
			weight8	=> weight(i)(8),
			weight9	=> weight(i)(9),
			output 	=> h2_outputs(i));
	end generate U_H2_NEURONS;

	h2_out0 <= h2_outputs(0);
	h2_out1 <= h2_outputs(1);
	h2_out2 <= h2_outputs(2);
	h2_out3 <= h2_outputs(3);
	h2_out4 <= h2_outputs(4);
	h2_out5 <= h2_outputs(5);
	h2_out6 <= h2_outputs(6);
	h2_out7 <= h2_outputs(7);

end h2_l;










-- weights
-- -0.4483084976673120
-- 0.2220767438411710
-- -0.1095948293805120
-- -0.2433978766202920
-- 1.0310206413269000
-- 0.5708655118942260
-- -1.2616425752639700
-- 1.2941567897796600
-- -0.7053633928298950
-- -0.0420025028288364
-- 0.9365497231483450
-- -0.1441999226808540
-- 0.2871440351009360
-- 0.8439503908157340
-- -1.0433568954467700
-- -1.1910307407379100
-- 0.3737527132034300
-- -1.1721686124801600
-- 0.5652856230735770
-- 0.0368612073361873
-- 0.4977403283119200
-- -0.3016139864921560
-- -0.0395996421575546
-- 0.8600522875785820
-- -0.1136049181222910
-- -0.2507859170436850
-- 0.6603319644927970
-- -1.1425879001617400
-- 0.4599123299121850
-- -0.3751863539218900
-- -0.4902647733688350
-- 0.3925968706607810
-- 0.2631387710571280
-- -0.4058147966861720
-- 0.8877899646759030
-- 0.6305421590805050
-- 0.4271792471408840
-- 0.6249455213546750
-- -0.2347116619348520
-- 0.4278423190116880
-- -0.2399447709321970
-- 0.5480451583862300
-- -0.1527913659811010
-- 0.1432173848152160
-- 1.1164220571517900
-- 0.3622194230556480
-- -0.9827332496643060
-- 0.9302722215652460
-- -0.6148117184638970
-- 0.6336559653282160
-- 0.4377337396144860
-- 0.4669008255004880
-- -0.0881828963756561
-- 0.8893885612487790
-- 0.0950784459710121
-- -0.0893080905079841
-- 0.3881981372833250
-- -0.3335326313972470
-- 0.0120839271694421
-- 0.6417931914329520
-- 0.8043910861015310
-- 0.0116184120997786
-- 0.1416215598583220
-- 0.7640833258628840
-- -0.7700471282005310
-- -0.5187344551086420
-- 0.8416125178337090
-- -0.5670269727706900
-- 0.6992158889770500
-- -0.5066489577293390
-- 1.1327784061431800
-- -0.7644956111907950
-- -0.1856636106967920
-- 1.1016606092453000
-- -0.2151071280241010
-- -1.2052222490310600
-- 0.9718060493469230
-- -1.0208063125610300
-- 0.7889882922172540
-- -0.0367438718676567

