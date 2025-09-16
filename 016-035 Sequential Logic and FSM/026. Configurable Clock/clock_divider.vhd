library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Clock Divider --
-- The clock divider was already done in previous examples, however a configurable one hasn't so ts would be the focus --
-- First three LEDs show binary representation of frequency (1-8 Hz) --
-- 000 = no LEDs, 001 = 1 Hz (LED0), 010 = 2 Hz (LED1), 011 = 3 Hz (LED0+LED1), etc. --

entity clock_divider is
    Port (
        clk_100mhz   : in  STD_LOGIC;                    -- Main 100MHz clock
        reset        : in  STD_LOGIC;                    -- Active high reset (BTNC)
        div_ratio    : in  STD_LOGIC_VECTOR(2 downto 0); -- Division ratio (SW2-SW0)
        clk_enable   : out STD_LOGIC;                    -- Clock enable output
        clk_slow     : out STD_LOGIC;                    -- Slow clock output
        div_value    : out STD_LOGIC_VECTOR(5 downto 0)  -- Current divider value (LED5-LED0)
    );
end clock_divider;

architecture Behavioral of clock_divider is
    signal counter      : unsigned(31 downto 0) := (others => '0');
    signal div_threshold: unsigned(31 downto 0) := (others => '0');
    signal clk_en       : STD_LOGIC := '0';
    signal slow_clk     : STD_LOGIC := '0';
    signal ratio_reg    : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
    signal freq_value   : STD_LOGIC_VECTOR(2 downto 0) := (others => '0'); -- Binary frequency value
begin
    
    -- Division ratio selection
    process(clk_100mhz)
    begin
        if rising_edge(clk_100mhz) then
            ratio_reg <= div_ratio;
        end if;
    end process;
    
    -- Set division threshold based on input and capture frequency value
    -- Lazy approach and just assigned a value for the LEDs to show based on config of switches (3 switches)
    process(ratio_reg)
    begin
        case ratio_reg is
            when "000" => 
                div_threshold <= to_unsigned(49999999, 32);  -- 1 Hz
                freq_value <= "000";  -- No LEDs (binary 0)
            when "001" => 
                div_threshold <= to_unsigned(49999999, 32);  -- 1 Hz
                freq_value <= "001";  -- LED0 only (binary 1)
            when "010" => 
                div_threshold <= to_unsigned(24999999, 32);  -- 2 Hz
                freq_value <= "010";  -- LED1 only (binary 2)
            when "011" => 
                div_threshold <= to_unsigned(16666666, 32);  -- 3 Hz
                freq_value <= "011";  -- LED0+LED1 (binary 3)
            when "100" => 
                div_threshold <= to_unsigned(12499999, 32);  -- 4 Hz
                freq_value <= "100";  -- LED2 only (binary 4)
            when "101" => 
                div_threshold <= to_unsigned(9999999, 32);   -- 5 Hz
                freq_value <= "101";  -- LED0+LED2 (binary 5)
            when "110" => 
                div_threshold <= to_unsigned(8333333, 32);   -- 6 Hz
                freq_value <= "110";  -- LED1+LED2 (binary 6)
            when "111" => 
                div_threshold <= to_unsigned(7142857, 32);   -- 7 Hz
                freq_value <= "111";  -- LED0+LED1+LED2 (binary 7)
            when others => 
                div_threshold <= to_unsigned(49999999, 32);  -- Default 1 Hz
                freq_value <= "000";  -- No LEDs
        end case;
    end process;
    
    -- Clock divider counter
    process(clk_100mhz, reset)
    begin
        if reset = '1' then
            counter <= (others => '0');
            clk_en <= '0';
            slow_clk <= '0';
        elsif rising_edge(clk_100mhz) then
            if counter = div_threshold then
                counter <= (others => '0');
                clk_en <= '1';          -- Generate enable pulse
                slow_clk <= not slow_clk; -- Toggle slow clock
            else
                counter <= counter + 1;
                clk_en <= '0';
            end if;
        end if;
    end process;
    
    -- Output assignments
    clk_enable <= clk_en;
    clk_slow <= slow_clk;
    
    -- Show frequency value on first three LEDs (LED2-LED0) and keep others off
    -- div_value(0) = LED0, div_value(1) = LED1, div_value(2) = LED2
    div_value <= "000" & freq_value;  -- LED5-LED3 = 0, LED2-LED0 = frequency binary
    
end Behavioral;
