library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use ieee.fixed_pkg.all;

entity nn_top_tb is
end nn_top_tb;

architecture TB of nn_top_tb is

	signal clk 		 	: std_logic := '1';
	signal rst 		 	: std_logic := '0';
	signal en  		 	: std_logic := '1';
	signal feature0	,
				 feature1	,
				 feature2	,
				 feature3	: sfixed(7 downto -24);
	signal class0 	,
			   class1 	,
			   class2 	: sfixed(7 downto -24);
begin -- TB

	U_nn_top : entity work.nn_top(nn)
		generic map (
			left				=> 7,
			right				=> -24)
		port map (
			clk 			=> clk,
			rst 			=> rst,
			en  			=> en,
			feature0	=> feature0,
			feature1	=> feature1,
			feature2	=> feature2,
			feature3	=> feature3,
			class0		=> class0,
			class1		=> class1,
			class2		=> class2);

	clk <= not clk after 10 ns;

	process
	begin
		
		wait for 10 ns;

		feature0  <= to_sfixed(5.1, feature0);
		feature1  <= to_sfixed(3.5, feature0);
		feature2  <= to_sfixed(1.4, feature0);
		feature3  <= to_sfixed(0.2, feature0);
		wait until clk'event and clk = '1';

		feature0  <= to_sfixed(4.9, feature0);
		feature1  <= to_sfixed(3.0, feature0);
		feature2  <= to_sfixed(1.4, feature0);
		feature3  <= to_sfixed(0.2, feature0);
		wait until clk'event and clk = '1';

		feature0  <= to_sfixed(5.0, feature0);
		feature1  <= to_sfixed(2.0, feature0);
		feature2  <= to_sfixed(3.5, feature0);
		feature3  <= to_sfixed(1.0, feature0);
		wait until clk'event and clk = '1';

		feature0  <= to_sfixed(7.7, feature0);
		feature1  <= to_sfixed(3.0, feature0);
		feature2  <= to_sfixed(6.1, feature0);
		feature3  <= to_sfixed(2.3, feature0);
		wait until clk'event and clk = '1';

    wait;

	end process ; -- 

end architecture ; -- TB

---0.401552319526672, -0.588973939418792, 1.011970877647390, 0.913053274154663

--0.642535388469696, 1.329993724822990, 1.323449611663810, 0.612206459045410

---0.043198827654123, 0.115063503384590, 0.395491570234298, 0.767061829566955

--0.022126968950033, -0.975434124469757, 0.810699045658111, 0.401130080223083