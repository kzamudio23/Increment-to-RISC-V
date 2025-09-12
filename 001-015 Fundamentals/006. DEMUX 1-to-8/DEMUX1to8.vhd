library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DEMUX1to8 is
    Port (
        D       : in STD_LOGIC;                 -- Dont use a Button for this (Active-low)
        SEL     : in STD_LOGIC_VECTOR(2 downto 0);
        DEMUX_OUT  : out STD_LOGIC_VECTOR(7 downto 0));
end DEMUX1to8;

architecture Behavioral of DEMUX1to8 is
begin
    process(D, SEL)
    begin
        -- Default casess
        DEMUX_OUT <= (others => '0');
        
        -- Routing inputs to output
        case SEL is
            when "000" =>  DEMUX_OUT(0) <= D; -- The Left side (3 bit binary) and D switch must both agree with conditions to activate LED where combo shows order of LED  
            when "001" =>  DEMUX_OUT(1) <= D;
            when "010" =>  DEMUX_OUT(2) <= D;
            when "011" =>  DEMUX_OUT(3) <= D;
            when "100" =>  DEMUX_OUT(4) <= D;
            when "101" =>  DEMUX_OUT(5) <= D;
            when "110" =>  DEMUX_OUT(6) <= D;
            when "111" =>  DEMUX_OUT(7) <= D;
            when others =>  DEMUX_OUT <= (others => '0'); -- OFF
        end case;
    end process;
end Behavioral;
