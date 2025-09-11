library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- Half Adder --
-------------------------------
--  A   B   Sum     Carry     -
--  0	0	0	      0       -
--  0	1	1	      0       -
--  1	0	1	      0       -
--  1	1	0	      1       -
------------------------------- 
 
entity half_adder is
    Port (
        A     : in  STD_LOGIC;
        B     : in  STD_LOGIC;
        Sum   : out STD_LOGIC;
        Carry : out STD_LOGIC
    );
end half_adder;

architecture Behavioral of Half_Adder is
begin
    Sum   <= A XOR B; -- XOR implementation (one or the other but not none or both).
    Carry <= A AND B;
end Behavioral;
