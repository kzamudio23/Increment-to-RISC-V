library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-- Binary Counter -- 
-- A simple counter that increments on every clock cycle --
-- Lowkey could've been done earlier but I had trouble outputing the registry of LEDS the way I wanted to --

entity binary_counter is
    Port (
        clk        : in  STD_LOGIC;     -- Clock input (100MHz)
        reset      : in  STD_LOGIC;     -- Active high reset (BTNC)
        enable     : in  STD_LOGIC;     -- Enable counting (SW0)
        count_out  : out STD_LOGIC_VECTOR(7 downto 0) -- Binary count on LEDs
    );
end binary_counter;

architecture Behavioral of binary_counter is
    signal counter_reg : unsigned(7 downto 0) := (others => '0');
    signal slow_clk    : STD_LOGIC := '0';
    signal clk_divider : unsigned(23 downto 0) := (others => '0');
    
    -- I should mention the use of signals instead of ports earlier on, but this is done to maintain states between executions from ports and internal decisions
    -- unsigned is basically just a number without a sign (obvious), but it isnt obvious as to why its generally used in signals as to oppose to ports
    -- Something from the Free Range VHDL open source book but I recalled how logic vectors are used when you want a "bag of bits" and using unsigned changes that to just a cetain bit
    
begin
    
    -- Clock divider: 100MHz -> ~3Hz (slow enough to see counting
    -- 100 MHz / 3 = 33 MHz -> 33.3 MHz / 2 (both edges) -> 16.6 MHz
    -- So use 16.6 MHz as indicator to toggle slow_clk every time target is reached creating the 3Hz clock (100MHz / 33MHz = 3Hz)
    process(clk)
    begin
        if rising_edge(clk) then
            if clk_divider = 16666667 then  -- ~0.167 seconds at 100MHz
                clk_divider <= (others => '0');
                slow_clk <= not slow_clk;
            else
                clk_divider <= clk_divider + 1;
            end if;
        end if;
    end process;
    
    -- Binary counter process
    process(slow_clk, reset)
    begin
        if reset = '1' then
            -- Reset: Clear the counter
            counter_reg <= (others => '0');
        elsif rising_edge(slow_clk) then
            if enable = '1' then
                -- Increment the counter on each clock edge
                counter_reg <= counter_reg + 1;
            end if;
        end if;
    end process;
    
    
    -- Output assignment - show binary count on LEDs
    count_out <= std_logic_vector(counter_reg);
    
end Behavioral;
