library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use ieee.fixed_pkg.all;

entity nn_top is
	generic (
		left				: positive := 7;
		right				: integer  := -24);
	port (
		clk 			: in  std_logic;
		rst 			: in  std_logic;
		en  			: in  std_logic;
		feature0	, 
		feature1	, 
		feature2	, 
		feature3	: in  sfixed(left downto right);
		class0		, 
		class1		, 
		class2		: out sfixed(left downto right));
end entity ; -- nn_top

architecture nn of nn_top is

	-----------------------------------------------
	--------------signal declaration---------------
	-----------------------------------------------
	
	-- hidden layer 1 signals
	signal 	h1_out0_sig	,
					h1_out1_sig	,
					h1_out2_sig	,
					h1_out3_sig	,
					h1_out4_sig	,
					h1_out5_sig	,
					h1_out6_sig	,
					h1_out7_sig	,
					h1_out8_sig	,
					h1_out9_sig	: sfixed(left downto right);

	-- hidden layer 2 signals
	signal 	h2_out0_sig	,
					h2_out1_sig	,
					h2_out2_sig	,
					h2_out3_sig	,
					h2_out4_sig	,
					h2_out5_sig	,
					h2_out6_sig	,
					h2_out7_sig	: sfixed(left downto right);

begin
	------------------------------------------------
	-- instantiate layers
	------------------------------------------------
	
	-- hidden layer 1
	U_H1_LAYER : entity work.h1_layer(h1_l)
	generic map(
		left				=> left,
		right				=> right,
		num_inputs 	=> 4,
		num_neurons	=> 10)
	port map(
		clk 		=> clk,
		rst 		=> rst,
		en  		=> en,
		input0	=> feature0,
		input1	=> feature1,
		input2	=> feature2,
		input3	=> feature3,
		h1_out0	=> h1_out0_sig,
		h1_out1	=> h1_out1_sig,
		h1_out2	=> h1_out2_sig,
		h1_out3	=> h1_out3_sig,
		h1_out4	=> h1_out4_sig,
		h1_out5	=> h1_out5_sig,
		h1_out6	=> h1_out6_sig,
		h1_out7	=> h1_out7_sig,
		h1_out8	=> h1_out8_sig,
		h1_out9	=> h1_out9_sig);

	-- hidden layer 2
	U_H2_LAYER : entity work.h2_layer(h2_l)
	generic map(
		left				=> left,
		right				=> right,
		num_inputs 	=> 10,
		num_neurons	=> 8)
	port map(
		clk 		=> clk,
		rst 		=> rst,
		en  		=> en,
		input0	=> h1_out0_sig,
		input1	=> h1_out1_sig,
		input2	=> h1_out2_sig,
		input3	=> h1_out3_sig,
		input4	=> h1_out4_sig,
		input5	=> h1_out5_sig,
		input6	=> h1_out6_sig,
		input7	=> h1_out7_sig,
		input8	=> h1_out8_sig,
		input9	=> h1_out9_sig,
		h2_out0	=> h2_out0_sig,
		h2_out1	=> h2_out1_sig,
		h2_out2	=> h2_out2_sig,
		h2_out3	=> h2_out3_sig,
		h2_out4	=> h2_out4_sig,
		h2_out5	=> h2_out5_sig,
		h2_out6	=> h2_out6_sig,
		h2_out7	=> h2_out7_sig);

	-- output layer
	U_OUT_LAYER : entity work.out_layer(out_l)
	generic map(
		left				=> left,
		right				=> right,
		num_inputs 	=> 8,
		num_neurons	=> 3)
	port map(
		clk 			=> clk,
		rst 			=> rst,
		en  			=> en,
		input0		=> h2_out0_sig,
		input1		=> h2_out1_sig,
		input2		=> h2_out2_sig,
		input3		=> h2_out3_sig,
		input4		=> h2_out4_sig,
		input5		=> h2_out5_sig,
		input6		=> h2_out6_sig,
		input7		=> h2_out7_sig,
		out_out0	=> class0,
		out_out1	=> class1,
		out_out2	=> class2);

end nn;







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


