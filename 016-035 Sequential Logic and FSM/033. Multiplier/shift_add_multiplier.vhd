library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- 4 x 4 Multiplier --
-- Nothing too fancy, just done to get a little less rusty --
-- Multiplying without multiplying operator using the (SUM/WRITE/CARRY) rule when multiplying by binary --
-- I tried seeing if I could do this with pure gates to emulate how the SWC procedure worked but its toooooo much --
-- Instead of making a whole pure implementation that carries a value, I just made everything shift to the left --
-- I highly recommend multiplying 14x15 in binary and seeing what I mean --

entity shift_add_multiplier is
    Port ( 
        a : in STD_LOGIC_VECTOR(3 downto 0);
        b : in STD_LOGIC_VECTOR(3 downto 0);
        product : out STD_LOGIC_VECTOR(7 downto 0)
    );
end shift_add_multiplier;

architecture behavioral of shift_add_multiplier is
begin
    process(a, b)
        variable acc : unsigned(7 downto 0);
        variable multiplicand : unsigned(3 downto 0);
        variable multiplier : unsigned(3 downto 0);
    begin
        acc := (others => '0');
        multiplicand := unsigned(a);
        multiplier := unsigned(b);
        
        for i in 0 to 3 loop
            if multiplier(i) = '1' then
                acc := acc + shift_left(resize(multiplicand, 8), i);
            end if;
        end loop;
        
        product <= std_logic_vector(acc);
    end process;
end behavioral;
