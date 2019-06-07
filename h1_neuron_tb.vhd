library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use ieee.fixed_pkg.all;

--4  inputs per neuron
--10 neurons in this layer

entity h1_neuron_tb is
end h1_neuron_tb;

architecture TB of h1_neuron_tb is

	signal clk 		 : std_logic := '1';
	signal rst 		 : std_logic := '0';
	signal en  		 : std_logic := '1';
	signal input0	 ,
				 input1	 ,
				 input2	 ,
				 input3	 : sfixed(7 downto -24);
	signal weight0 ,
			   weight1 ,
			   weight2 ,
			   weight3 : sfixed(7 downto -24);
	signal output_sig : sfixed(7 downto -24);
begin -- TB

	U_H1_NEURON : entity work.h1_neuron(h1_n)
		generic map (
			left				=> 7,
			right				=> -24,
			num_inputs 	=> 4,
			num_neurons => 10)
		port map (
			clk 		=> clk,
			rst 		=> rst,
			en  		=> en,
			input0	=> input0,
			input1	=> input1,
			input2	=> input2,
			input3	=> input3,
			weight0	=> weight0,
			weight1	=> weight1,
			weight2	=> weight2,
			weight3	=> weight3,
			output 	=> output_sig);

	clk <= not clk after 10 ns;

	process
	begin
		
		wait for 10 ns;

		input0  <= to_sfixed(5.1, input0);
		input1  <= to_sfixed(3.5, input0);
		input2  <= to_sfixed(1.4, input0);
		input3  <= to_sfixed(0.2, input0);
		weight0 <= to_sfixed(-0.401552319526672, input0);
		weight1 <= to_sfixed(-0.588973939418792, input0);
		weight2 <= to_sfixed(1.011970877647390, input0);
		weight3 <= to_sfixed(0.913053274154663, input0);
    wait until clk'event and clk = '1';

		input0  <= to_sfixed(5.1, input0);
		input1  <= to_sfixed(3.5, input0);
		input2  <= to_sfixed(1.4, input0);
		input3  <= to_sfixed(0.2, input0);
		weight0 <= to_sfixed(0.642535388469696, input0);
		weight1 <= to_sfixed(1.329993724822990, input0);
		weight2 <= to_sfixed(1.323449611663810, input0);
		weight3 <= to_sfixed(0.612206459045410, input0);
    wait until clk'event and clk = '1';

		input0  <= to_sfixed(5.1, input0);
		input1  <= to_sfixed(3.5, input0);
		input2  <= to_sfixed(1.4, input0);
		input3  <= to_sfixed(0.2, input0);
		weight0 <= to_sfixed(-0.043198827654123, input0);
		weight1 <= to_sfixed(0.115063503384590, input0);
		weight2 <= to_sfixed(0.395491570234298, input0);
		weight3 <= to_sfixed(0.767061829566955, input0);
    wait until clk'event and clk = '1';

		input0  <= to_sfixed(5.1, input0);
		input1  <= to_sfixed(3.5, input0);
		input2  <= to_sfixed(1.4, input0);
		input3  <= to_sfixed(0.2, input0);
		weight0 <= to_sfixed(0.022126968950033, input0);
		weight1 <= to_sfixed(-0.975434124469757, input0);
		weight2 <= to_sfixed(0.810699045658111, input0);
		weight3 <= to_sfixed(0.401130080223083, input0);    
		wait until clk'event and clk = '1';

    wait;

	end process ; -- 

end architecture ; -- TB

---0.401552319526672, -0.588973939418792, 1.011970877647390, 0.913053274154663

--0.642535388469696, 1.329993724822990, 1.323449611663810, 0.612206459045410

---0.043198827654123, 0.115063503384590, 0.395491570234298, 0.767061829566955

--0.022126968950033, -0.975434124469757, 0.810699045658111, 0.401130080223083