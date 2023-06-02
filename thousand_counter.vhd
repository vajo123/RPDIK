--biblioteke potrebne za realizaciju
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity thousand_counter is
port(
	en: in std_logic; --sinhroni enable ulaz
	reset: in std_logic; --asinhroni reset ulaz
	clk: in std_logic; --taktni signal

	pulse: out std_logic; --signal koji obavestava da smo izbrojali do 1000
	q1: out std_logic_vector(3 downto 0); --izlazni signal koji predstavlja jedinice
	q10: out std_logic_vector(3 downto 0); --izlazni signal koji predstavlja desetice
	q100: out std_logic_vector(3 downto 0)  --izlazni signal koji predstavlja stotine
    );
end thousand_counter;

architecture beh of thousand_counter is

--deklaracija komponente ten_counter koja broji do 10
component ten_counter
port(
	en: in std_logic;
	reset: in std_logic;
	clk: in std_logic;

	pulse: out std_logic;
	q: out std_logic_vector(3 downto 0)
    );
end component;
signal pulse1_s, pulse2_s: std_logic;
begin

--brojac do 1000 sastoji se od tri brojaca do 10, jedan za jedinice, drugi za desetice, a treci za stotine
counter1:
ten_counter port map(
	en => en,
	reset => reset,	
	clk => clk,
	pulse => pulse1_s,
	q => q1);

counter2:
ten_counter port map(
	en => en,
	reset => reset,	
	clk => pulse1_s,
	pulse => pulse2_s,
	q => q10);

counter3:
ten_counter port map(
	en => en,
	reset => reset,	
	clk => pulse2_s,
	pulse => pulse,
	q => q100);

end beh;
