library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
    
entity seven_seg_dec is
    Port (
        inp     : in  STD_LOGIC_VECTOR(3 downto 0);
        seg     : out  STD_LOGIC_VECTOR(6 downto 0));
end seven_seg_dec;

architecture Behavioral of seven_seg_dec is
begin
    process(inp)
    begin
        case inp is
            when "0000" => seg <= "0000001"; -- 0 -- 4 bit to hexadecimal
            when "0001" => seg <= "1001111"; -- 1
            when "0010" => seg <= "0010010"; -- 2
            when "0011" => seg <= "0000110"; -- 3
            when "0100" => seg <= "1001100"; -- 4
            when "0101" => seg <= "0100100"; -- 5
            when "0110" => seg <= "0100000"; -- 6
            when "0111" => seg <= "0001111"; -- 7
            when "1000" => seg <= "0000000"; -- 8
            when "1001" => seg <= "0000100"; -- 9
            when "1010" => seg <= "0001000"; -- A
            when "1011" => seg <= "1100000"; -- b
            when "1100" => seg <= "0110001"; -- C
            when "1101" => seg <= "1000010"; -- d
            when "1110" => seg <= "0110000"; -- E
            when "1111" => seg <= "0111000"; -- F
            when others => seg <= "1111111"; -- blank
        end case;
    end process;
end Behavioral;
