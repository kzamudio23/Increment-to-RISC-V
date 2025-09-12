library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- Full Adder --
-------------------------------
--                          -- Same thing as last one but more FULLER
--  A	B	Cin	Sum	Cout    --
--  0	0	0	0	0       --
--  0	0	1	1	0       --
--  0	1	0	1	0       --
--  0	1	1	0	1       --
--  1	0	0	1	0       --
--  1	0	1	0	1       --
--  1	1	0	0	1       --
--  1	1	1	1	1       -- ODD PARITY
------------------------------- 
 
entity full_adder is
    Port (
        A     : in  STD_LOGIC;
        B     : in  STD_LOGIC;
        Cin   : in STD_LOGIC;
        Sum   : out STD_LOGIC;
        Carry : out STD_LOGIC
    );
end full_adder;

architecture Behavioral of full_adder is
begin
    Sum   <= A XOR B XOR Cin; -- XOR implementation (ODD PARITY).
    Carry <= (A AND B) OR (B and Cin) OR (A AND Cin);
end Behavioral;
