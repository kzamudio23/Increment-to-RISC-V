
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity led_test is
    Port ( switch : in STD_LOGIC;
           led : out STD_LOGIC);
end led_test;

architecture Behavioral of led_test is

begin
    led <= switch;
end Behavioral;
