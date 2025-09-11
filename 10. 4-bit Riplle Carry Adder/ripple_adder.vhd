library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
    ----------------------- SAMPLE -----------------------------
    ------------------------------------------------------------
    --A	    B	   Cin	Deci A+B+Cin	Sum (S[3:0])	  Cout -
    --0000	0000	0	0	            0000	           0   -
    --0001	0010	0	3	            0011	           0   -
    --0111	0001	1	9	            1001	           0   -
    --1111	0001	0	16	            0000	           1   -
    --1111	1111	1	31	            1111	           1   -
    ------------------------------------------------------------
    -- 4^2 * 4^2 * 2 = 512 Combinations !!!
    
-- First instance of a Hierarchal Design (Ports need to be defined fully)
entity ripple_adder is
    Port (
        A     : in  STD_LOGIC_VECTOR(3 downto 0);
        B     : in  STD_LOGIC_VECTOR(3 downto 0);
        Cin   : in  STD_LOGIC;
        S     : out STD_LOGIC_VECTOR(3 downto 0);
        Cout  : out STD_LOGIC
    );
end ripple_adder;

-- Connecting two 4 bit inputs, one Carry-in (Cin), 4-sum outputs (S), and one Carry-out (Cout)

--  Full Adder	Inputs	                  Outputs
--  FA0	        A(0), B(0), Cin	            S(0), C1
--  FA1     	A(1), B(1), C1	            S(1), C2
--  FA2	        A(2), B(2), C2	            S(2), C3
--  FA3	        A(3), B(3), C3	            S(3), Cout

architecture Behavioral of ripple_adder is
    component full_adder
        Port (
            A     : in  STD_LOGIC;
            B     : in  STD_LOGIC;
            Cin   : in  STD_LOGIC;
            Sum   : out STD_LOGIC;
            Cout  : out STD_LOGIC
        );
    end component;

    signal C1, C2, C3 : STD_LOGIC;
begin
    FA0: full_adder port map (
        A     => A(0),
        B     => B(0),
        Cin   => Cin,
        Sum   => S(0),
        Cout  => C1
    );

    FA1: full_adder port map (
        A     => A(1),
        B     => B(1),
        Cin   => C1,
        Sum   => S(1),
        Cout  => C2
    );

    FA2: full_adder port map (
        A     => A(2),
        B     => B(2),
        Cin   => C2,
        Sum   => S(2),
        Cout  => C3
    );

    FA3: full_adder port map (
        A     => A(3),
        B     => B(3),
        Cin   => C3,
        Sum   => S(3),
        Cout  => Cout
    );
end Behavioral;
