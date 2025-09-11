library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-------------------------------
-- A > B --  A == B -- A < B -- (I like this diagram that I made)
------------------------------- 
-- Should be concurrent signal assignments 
entity bincomp4bit is
    Port (
        A           : in STD_LOGIC_VECTOR(3 downto 0);                 -- Dont use a Button for this (Active-low)
        B           : in STD_LOGIC_VECTOR(3 downto 0);                 -- This is really simple honestly
        A_gt_B      : out STD_LOGIC;
        A_eq_B      : out STD_LOGIC;
        A_lt_B      :out STD_LOGIC);
end bincomp4bit;

architecture Behavioral of bincomp4bit is
begin
        A_gt_B <= '1' when A > B else '0';
        A_eq_B <= '1' when A = B else '0';
        A_lt_B <= '1' when A < B else '0';
end Behavioral;
