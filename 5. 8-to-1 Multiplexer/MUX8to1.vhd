library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MUX8to1 is
    Port (
        D       : in STD_LOGIC_VECTOR(7 downto 0); -- BUS
        SEL     : in STD_LOGIC_VECTOR(2 downto 0);
        MX_OUT  : out STD_LOGIC);
end MUX8to1;

architecture Behavioral of MUX8to1 is
begin
    process(D, SEL)
    begin
        case SEL is
            when "000" => MX_OUT <= D(0); -- The Left side (3 bit binary) and Right side (Order of Switch) must both agree with conditions to activate LED  
            when "001" => MX_OUT <= D(1);
            when "010" => MX_OUT <= D(2);
            when "011" => MX_OUT <= D(3);
            when "100" => MX_OUT <= D(4);
            when "101" => MX_OUT <= D(5);
            when "110" => MX_OUT <= D(6);
            when "111" => MX_OUT <= D(7);
            when others => MX_OUT <= '0'; -- OFF
        end case;
    end process;
end Behavioral;
