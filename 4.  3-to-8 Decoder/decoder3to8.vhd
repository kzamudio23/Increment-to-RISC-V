library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity decoder3to8 is
    Port (
        SW : in STD_LOGIC_VECTOR(3 downto 0); -- BUS
        LED : out STD_LOGIC_VECTOR(2 downto 0) -- BUS
    );
end decoder3to8;

architecture Behavioral of Decoder3to8 is
    signal output_line : STD_LOGIC_VECTOR(7 downto 0);
begin
    process(SW)
    begin
        if SW(3) = '1' then -- This switch enables everything 
            case SW(2 downto 0) is
                when "000" => output_line <= "00000001";
                when "001" => output_line <= "00000010";
                when "010" => output_line <= "00000100";
                when "011" => output_line <= "00001000";
                when "100" => output_line <= "00010000";
                when "101" => output_line <= "00100000";
                when "110" => output_line <= "01000000";
                when "111" => output_line <= "10000000";
                when others => output_line <= "00000000";
            end case;
        else
            output_line <= "00000000"; -- Decoder disabled
        end if;

        -- Binary conversion (8 bit to 3 bit value)
        case output_line is
            when "00000001" => LED <= "000";
            when "00000010" => LED <= "001";
            when "00000100" => LED <= "010";
            when "00001000" => LED <= "011";
            when "00010000" => LED <= "100";
            when "00100000" => LED <= "101";
            when "01000000" => LED <= "110";
            when "10000000" => LED <= "111";
            when others => LED <= "000"; -- OFF 
        end case;
    end process;
end Behavioral;
