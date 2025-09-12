
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity input_AND is
    Port ( switch1 : in STD_LOGIC;
           switch2 : in STD_LOGIC;
           led : out STD_LOGIC);
end input_AND;

architecture Behavioral of input_AND is

begin
    led <= switch1 AND switch2;
end Behavioral;
