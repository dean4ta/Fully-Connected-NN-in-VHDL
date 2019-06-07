library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use ieee.fixed_pkg.all;

--4  inputs per neuron
--10 neurons in this layer

entity h2_neuron_tb is
end h2_neuron_tb;

architecture TB of h2_neuron_tb is

	signal clk 		 : std_logic := '1';
	signal rst 		 : std_logic := '0';
	signal en  		 : std_logic := '1';
	signal input0	 ,
				 input1	 ,
				 input2	 ,
				 input3	 ,
				 input4	 ,
				 input5	 ,
				 input6	 ,
				 input7	 ,
				 input8	 ,
				 input9	 : sfixed(7 downto -24);
	signal weight0 ,
			   weight1 ,
			   weight2 ,
			   weight3 ,
			   weight4 ,
			   weight5 ,
			   weight6 ,
			   weight7 ,
			   weight8 ,
			   weight9 : sfixed(7 downto -24);
	signal output_sig : sfixed(7 downto -24);
begin -- TB

	U_H2_NEURON : entity work.h2_neuron(h2_n)
		generic map (
			left				=> 7,
			right				=> -24,
			num_inputs 	=> 10,
			num_neurons => 8)
		port map (
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

			weight0	=> weight0,
			weight1	=> weight1,
			weight2	=> weight2,
			weight3	=> weight3,
			weight4	=> weight4,
			weight5	=> weight5,
			weight6	=> weight6,
			weight7	=> weight7,
			weight8	=> weight8,
			weight9	=> weight9,

			output 	=> output_sig);

	clk <= not clk after 10 ns;

	process
	begin
		
		wait for 10 ns;

		input0  <= to_sfixed(0.48470279, input0);
		input1  <= to_sfixed(0.45116137, input0);
		input2  <= to_sfixed(0.3828968, input0);
		input3  <= to_sfixed(0.94940604, input0);
		input4  <= to_sfixed(0.92649203, input0);
		input5  <= to_sfixed(0.48871497, input0);
		input6  <= to_sfixed(0.57768278, input0);
		input7  <= to_sfixed(0.1833152, input0);
		input8  <= to_sfixed(0.13141357, input0);
		input9  <= to_sfixed(0.35583433, input0);
		weight0 <= to_sfixed(-0.4483084976673120, input0);
		weight1 <= to_sfixed(0.2220767438411710, input0);
		weight2 <= to_sfixed(-0.1095948293805120, input0);
		weight3 <= to_sfixed(-0.2433978766202920, input0);
		weight4 <= to_sfixed(1.0310206413269000, input0);
		weight5 <= to_sfixed(0.5708655118942260, input0);
		weight6 <= to_sfixed(-1.2616425752639700, input0);
		weight7 <= to_sfixed(1.2941567897796600, input0);
		weight8 <= to_sfixed(-0.7053633928298950, input0);
		weight9 <= to_sfixed(-0.0420025028288364, input0);
    wait until clk'event and clk = '1';

		input0  <= to_sfixed(0.51974845, input0);
		input1  <= to_sfixed(0.24579329, input0);
		input2  <= to_sfixed(0.31382243, input0);
		input3  <= to_sfixed(0.65691999, input0);
		input4  <= to_sfixed(0.00125483, input0);
		input5  <= to_sfixed(0.67726953, input0);
		input6  <= to_sfixed(0.16450027, input0);
		input7  <= to_sfixed(0.1072618 , input0);
		input8  <= to_sfixed(0.32217755, input0);
		input9  <= to_sfixed(0.51022581, input0);
		weight0 <= to_sfixed(0.9365497231483450, input0);
		weight1 <= to_sfixed(-0.1441999226808540, input0);
		weight2 <= to_sfixed(0.2871440351009360, input0);
		weight3 <= to_sfixed(0.8439503908157340, input0);
		weight4 <= to_sfixed(-1.0433568954467700, input0);
		weight5 <= to_sfixed(-1.1910307407379100, input0);
		weight6 <= to_sfixed(0.3737527132034300, input0);
		weight7 <= to_sfixed(-1.1721686124801600, input0);
		weight8 <= to_sfixed(0.5652856230735770, input0);
		weight9 <= to_sfixed(0.0368612073361873, input0);
    wait until clk'event and clk = '1';

		input0  <= to_sfixed(0.00276121, input0);
		input1  <= to_sfixed(0.01595584, input0);
		input2  <= to_sfixed(0.22600088, input0);
		input3  <= to_sfixed(0.89931814, input0);
		input4  <= to_sfixed(0.81399839, input0);
		input5  <= to_sfixed(0.2078836 , input0);
		input6  <= to_sfixed(0.39378108, input0);
		input7  <= to_sfixed(0.72227274, input0);
		input8  <= to_sfixed(0.6444774 , input0);
		input9  <= to_sfixed(0.67560366, input0);
		weight0 <= to_sfixed(0.4977403283119200, input0);
		weight1 <= to_sfixed(-0.3016139864921560, input0);
		weight2 <= to_sfixed(-0.0395996421575546, input0);
		weight3 <= to_sfixed(0.8600522875785820, input0);
		weight4 <= to_sfixed(-0.1136049181222910, input0);
		weight5 <= to_sfixed(-0.2507859170436850, input0);
		weight6 <= to_sfixed(0.6603319644927970, input0);
		weight7 <= to_sfixed(-1.1425879001617400, input0);
		weight8 <= to_sfixed(0.4599123299121850, input0);
		weight9 <= to_sfixed(-0.375186353921890, input0);
    wait until clk'event and clk = '1';

		input0  <= to_sfixed(0.36189262, input0);
		input1  <= to_sfixed(0.49599398, input0);
		input2  <= to_sfixed(0.96240507, input0);
		input3  <= to_sfixed(0.94333486, input0);
		input4  <= to_sfixed(0.89477358, input0);
		input5  <= to_sfixed(0.2061689 , input0);
		input6  <= to_sfixed(0.2067406 , input0);
		input7  <= to_sfixed(0.25556826, input0);
		input8  <= to_sfixed(0.39187348, input0);
		input9  <= to_sfixed(0.75361784, input0);
		weight0 <= to_sfixed(-0.4902647733688350, input0);
		weight1 <= to_sfixed(0.3925968706607810, input0);
		weight2 <= to_sfixed(0.2631387710571280, input0);
		weight3 <= to_sfixed(-0.4058147966861720, input0);
		weight4 <= to_sfixed(0.8877899646759030, input0);
		weight5 <= to_sfixed(0.6305421590805050, input0);
		weight6 <= to_sfixed(0.4271792471408840, input0);
		weight7 <= to_sfixed(0.6249455213546750, input0);
		weight8 <= to_sfixed(-0.2347116619348520, input0);
		weight9 <= to_sfixed(0.4278423190116880, input0);  
		wait until clk'event and clk = '1';

    wait;

	end process ; -- 

end architecture ; -- TB

-- h1 weights (4in x 10n)
-- (-0.401552319526672, -0.588973939418792, 1.011970877647390, 0.913053274154663)
-- (0.642535388469696, 1.329993724822990, 1.323449611663810, 0.612206459045410)
-- (-0.043198827654123, 0.115063503384590, 0.395491570234298, 0.767061829566955)
-- (0.022126968950033, -0.975434124469757, 0.810699045658111, 0.401130080223083)
-- (0.090278275310993, 0.090278275310993, 0.090278275310993, 0.090278275310993)
-- (-0.005671619437635, 0.822614848613739, -0.467894285917282, -1.210180878639220)
-- (-0.271065056324005, -1.106544017791740, 1.332951784133910, 0.636383116245269)
-- (0.029566150158644, 1.048734664916990, -0.727931618690490, -0.762929260730743)
-- (-0.122225403785705, -0.878108024597167, 0.715409100055694, 1.042201399803160)
-- (0.926824212074279, 1.130396962165830, 1.027786731719970, 0.770504236221313)


-- h2 weights (10in x 8n)
-- (-0.4483084976673120	0.2220767438411710	-0.1095948293805120	-0.2433978766202920	1.0310206413269000	0.5708655118942260	-1.2616425752639700	1.2941567897796600	-0.7053633928298950	-0.0420025028288364)
-- (0.9365497231483450	-0.1441999226808540	0.2871440351009360	0.8439503908157340	-1.0433568954467700	-1.1910307407379100	0.3737527132034300	-1.1721686124801600	0.5652856230735770	0.0368612073361873)
-- (0.4977403283119200	-0.3016139864921560	-0.0395996421575546	0.8600522875785820	-0.1136049181222910	-0.2507859170436850	0.6603319644927970	-1.1425879001617400	0.4599123299121850	-0.3751863539218900)
-- (-0.4902647733688350	0.3925968706607810	0.2631387710571280	-0.4058147966861720	0.8877899646759030	0.6305421590805050	0.4271792471408840	0.6249455213546750	-0.2347116619348520	0.4278423190116880)
-- (-0.2399447709321970	0.5480451583862300	-0.1527913659811010	0.1432173848152160	1.1164220571517900	0.3622194230556480	-0.9827332496643060	0.9302722215652460	-0.6148117184638970	0.6336559653282160)
-- (0.4377337396144860	0.4669008255004880	-0.0881828963756561	0.8893885612487790	0.0950784459710121	-0.0893080905079841	0.3881981372833250	-0.3335326313972470	0.0120839271694421	0.6417931914329520)
-- (0.8043910861015310	0.0116184120997786	0.1416215598583220	0.7640833258628840	-0.7700471282005310	-0.5187344551086420	0.8416125178337090	-0.5670269727706900	0.6992158889770500	-0.5066489577293390)
-- (1.1327784061431800	-0.7644956111907950	-0.1856636106967920	1.1016606092453000	-0.2151071280241010	-1.2052222490310600	0.9718060493469230	-1.0208063125610300	0.7889882922172540	-0.0367438718676567)
--
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
-- 
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
-- 
-- 0.4977403283119200
-- -0.3016139864921560
-- -0.0395996421575546
-- 0.8600522875785820
-- -0.1136049181222910
-- -0.2507859170436850
-- 0.6603319644927970
-- -1.1425879001617400
-- 0.4599123299121850
-- -0.375186353921890
-- 
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


--random numbers * weights
-- 0.48470279 * -0.4483084976673120 +
-- 0.45116137 * 0.2220767438411710 +
-- 0.3828968 * -0.1095948293805120 +
-- 0.94940604 * -0.2433978766202920 +
-- 0.92649203 * 1.0310206413269000 +
-- 0.48871497 * 0.5708655118942260 +
-- 0.57768278 * -1.2616425752639700 +
-- 0.1833152 * 1.2941567897796600 +
-- 0.13141357 * -0.7053633928298950 +
-- 0.35583433 * -0.0420025028288364
-- = 0.24484123967
-- = sig() -> 0.560906349555071
-- 
-- 0.51974845 * 0.9365497231483450 +
-- 0.24579329 * -0.1441999226808540 +
-- 0.31382243 * 0.2871440351009360 +
-- 0.65691999 * 0.8439503908157340 +
-- 0.00125483 * -1.0433568954467700 +
-- 0.67726953 * -1.1910307407379100 +
-- 0.16450027 * 0.3737527132034300 +
-- 0.1072618 * -1.1721686124801600 +
-- 0.32217755 * 0.5652856230735770 +
-- 0.51022581 * 0.0368612073361873
-- = 0.42457233258
-- = sig() -> 0.6045768495396172
-- 
-- 0.00276121 * 0.4977403283119200 +
-- 0.01595584 * -0.3016139864921560 +
-- 0.22600088 * -0.0395996421575546 +
-- 0.89931814 * 0.8600522875785820 +
-- 0.81399839 * -0.1136049181222910 +
-- 0.2078836 * -0.2507859170436850  +
-- 0.39378108 * 0.6603319644927970 +
-- 0.72227274 * -1.1425879001617400 +
-- 0.6444774 * 0.4599123299121850  +
-- 0.67560366 * -0.375186353921890
-- = 0.09415640045
-- = sig() -> 0.5235217251666996
-- 
-- 0.36189262 * -0.4902647733688350 +
-- 0.49599398 * 0.3925968706607810 +
-- 0.96240507 * 0.2631387710571280 +
-- 0.94333486 * -0.4058147966861720 +
-- 0.89477358 * 0.8877899646759030 +
-- 0.2061689 * 0.6305421590805050  +
-- 0.2067406 * 0.4271792471408840  +
-- 0.25556826 * 0.6249455213546750 +
-- 0.39187348 * -0.2347116619348520 +
-- 0.75361784 * 0.4278423190116880
-- = 1.29058237427
-- = sig() -> 0.7842457457528187