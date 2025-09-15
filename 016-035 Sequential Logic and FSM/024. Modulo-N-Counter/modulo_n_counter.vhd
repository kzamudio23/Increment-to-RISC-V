library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Modulo-N-Counter --
-- Can count to any value of N (but is configured to 1- 255) --
-- A finite state machine (FSM) that counts and resets to zero --
-- Resets count at N --
-- You can use this for multiple scenarios like a traffic light or a calendar instead of being locked by 8 bits by ordinary counter --


entity modulo_n_counter is
    Port (
        clk        : in  STD_LOGIC;                    -- Clock input (100MHz)
        reset      : in  STD_LOGIC;                         -- Active high reset (BTNC)
        enable     : in  STD_LOGIC;                    -- Enable counting (SW0)
        modulus    : in  STD_LOGIC_VECTOR(7 downto 0); -- Modulus value (SW7-SW0) (Represents N)
        count_out  : out STD_LOGIC_VECTOR(7 downto 0); -- Count value on LEDs
        carry_out  : out STD_LOGIC                     -- Carry signal (LD8)
    );
end modulo_n_counter;

architecture Behavioral of modulo_n_counter is
    signal counter_reg   : unsigned(7 downto 0) := (others => '0');
    signal modulus_reg   : unsigned(7 downto 0) := to_unsigned(10, 8); -- Default mod-10
    signal slow_clk      : STD_LOGIC := '0';
    signal clk_divider   : unsigned(23 downto 0) := (others => '0');
    signal carry_flag    : STD_LOGIC := '0';
begin
    
    -- Clock divider: 100MHz -> ~3Hz
    process(clk)
    begin
        if rising_edge(clk) then
            if clk_divider = 16666667 then
                clk_divider <= (others => '0');
                slow_clk <= not slow_clk;
            else
                clk_divider <= clk_divider + 1;
            end if;
        end if;
    end process;
    
    -- Store modulus value
    process(slow_clk)
    begin
        if rising_edge(slow_clk) then
            modulus_reg <= unsigned(modulus);
        end if;
    end process;
    
    -- Modulo-N counter process
    process(slow_clk, reset)
    begin
        if reset = '1' then
            counter_reg <= (others => '0');
            carry_flag <= '0';
        elsif rising_edge(slow_clk) then
            if enable = '1' then
                if counter_reg = modulus_reg - 1 then
                    counter_reg <= (others => '0');  -- Reset at modulus
                    carry_flag <= '1';               -- Generate carry
                else
                    counter_reg <= counter_reg + 1;  -- Normal increment
                    carry_flag <= '0';
                end if;
            end if;
        end if;
    end process;
    
    -- Output assignments
    count_out <= std_logic_vector(counter_reg);
    carry_out <= carry_flag;
    
end Behavioral;
