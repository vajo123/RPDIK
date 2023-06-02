--biblioteke potrebne za realizaciju
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity thousand_counter_tb is
	--empty
end thousand_counter_tb;

architecture beh of thousand_counter_tb is

--deklaracija komponente ciji rad simuliramo
component thousand_counter
port(
	en: in std_logic;
	reset: in std_logic;
	clk: in std_logic;

	pulse: out std_logic;
	q1: out std_logic_vector(3 downto 0);
	q10: out std_logic_vector(3 downto 0);
	q100: out std_logic_vector(3 downto 0)
    );
end component;

--deklaracija pomocnih signala koji ce biti povezani sa portovima komponente
signal en_s, reset_s, clk_s, pulse_s: std_logic;
signal q1_s, q10_s, q100_s: std_logic_vector(3 downto 0);

begin

--povezivanje komponente sa signalima
uut:
thousand_counter port map(
	en => en_s,
	reset => reset_s,	
	clk => clk_s,
	pulse => pulse_s,
	q1 => q1_s,
	q10 => q10_s,
	q100 => q100_s);

--generisanje clk signala za sinhronizaciju sistema
clk_gen:process
begin
	clk_s <= '0','1' after 1 us;
	wait for 2 us;
end process;

--definisanje vrednosti ulaznih signala sistema radi simulacije razlicitih dogadjaja u sistemu
reset_s <= '0', '1' after 10 us, '0' after 12 us, '1' after 22 us, '0' after 23 us;
en_s <= '0', '1' after 3 us, '0' after 50 us, '1' after 55 us;

end beh;
