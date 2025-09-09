
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity multi_gate is
    Port ( A : in STD_LOGIC; --Switched (Changed for simplicity
           B : in STD_LOGIC;
           C : in STD_LOGIC;
           D : in STD_LOGIC;
           led1 : out STD_LOGIC;
           led2 : out STD_LOGIC;
           led3 : out STD_LOGIC);
end multi_gate;

architecture Behavioral of multi_gate is

begin
    led1 <= A AND B;
    led2 <= C AND NOT D;
    led3 <= (A AND B)OR (C AND NOT D);
end Behavioral;
