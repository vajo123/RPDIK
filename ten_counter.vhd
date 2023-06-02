6--biblioteke potrebne za realizaciju
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity ten_counter is
port(
	en: in std_logic; --sinhroni enable ulaz
	reset: in std_logic; --asinhroni reset ulaz
	clk: in std_logic; --taktni signal

	pulse: out std_logic; --signal koji obavestava da smo izbrojali do 10
	--izlazni signal koji ima vrednost od 0000 do 1001
	q: out std_logic_vector(3 downto 0)
    );
end ten_counter;

architecture beh of ten_counter is

--pomocni signali za realizaciju brojaca
signal q_s: std_logic_vector(3 downto 0):= "0000"; --inicijalizujemo vrednost brojaca na 0
signal pulse_s: std_logic:= '0';

begin
	--realizacija brojaca koji broji od 0 do 9
	process(clk, reset) 
	begin
		if(reset = '1') then
			q_s <= (others => '0'); --ako je reset akrivan vrednost brojaca se resetuje na 0
		else
			if(rising_edge(clk) and en = '1') then --ako je rastuca ivica clk signala i ako je en aktivan brojac se uvecava za 1
				if(q_s = "0000") then
					q_s <= std_logic_vector(to_unsigned(to_integer(unsigned(q_s)) + 1, 4));
					pulse_s <= '0';
				elsif(q_s = "1001") then --ako je izlaz brojaca 9 tada pulse signal dobija vrednost 1 da obavestio da je brojac dosao do 10, a izlazni signal dobija vrednost 0
					q_s <= (others => '0');
					pulse_s <= '1';
				else
					q_s <= std_logic_vector(to_unsigned(to_integer(unsigned(q_s)) + 1, 4));
					pulse_s <= '0';								
				end if;
			end if;
		end if;
				
	end process;
	q <= q_s;
	pulse <= pulse_s;

end beh;
