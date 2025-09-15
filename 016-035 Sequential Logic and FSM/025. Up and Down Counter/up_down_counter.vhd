library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Up and Down Counter --
-- Basically the OG binary counter, but there's an implementation of the counter starting at max or min registry (6 bits) --
-- SW0 Starts from max to min (assuming SW1 is down), min_flag will light up --
-- SW1 Up will do the opposite --
-- Could be useful like volume configuration or a menu/position UI -- 

entity up_down_counter is
    Port (
        clk        : in  STD_LOGIC;                    -- Clock input (100MHz)
        reset      : in  STD_LOGIC;                    -- Active high reset (BTNC)
        enable     : in  STD_LOGIC;                    -- Enable counting (SW0)
        up_down    : in  STD_LOGIC;                    -- Direction control (SW1: 1=Up, 0=Down)
        count_out  : out STD_LOGIC_VECTOR(5 downto 0); -- Count value on LEDs
        max_flag   : out STD_LOGIC;                    -- Max value flag (LD8)
        min_flag   : out STD_LOGIC                     -- Min value flag (LD9)
    );
end up_down_counter;

architecture Behavioral of up_down_counter is
    signal counter_reg   : unsigned(5 downto 0) := (others => '0');
    signal slow_clk      : STD_LOGIC := '0';
    signal clk_divider   : unsigned(23 downto 0) := (others => '0');
    signal max_reached   : STD_LOGIC := '0';
    signal min_reached   : STD_LOGIC := '0';
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
    
    -- Up/Down counter process
    process(slow_clk, reset)
    begin
        if reset = '1' then
            counter_reg <= (others => '0');
            max_reached <= '0';
            min_reached <= '0';
        elsif rising_edge(slow_clk) then
            if enable = '1' then
                if up_down = '1' then  -- Count UP
                    if counter_reg = 63 then
                        counter_reg <= (others => '0');  -- Wrap around
                        max_reached <= '1';
                    else
                        counter_reg <= counter_reg + 1;
                        max_reached <= '0';
                    end if;
                    min_reached <= '0';
                else  -- Count DOWN
                    if counter_reg = 0 then
                        counter_reg <= to_unsigned(63, 6);  -- Wrap around
                        min_reached <= '1';
                    else
                        counter_reg <= counter_reg - 1;
                        min_reached <= '0';
                    end if;
                    max_reached <= '0';
                end if;
            end if;
        end if;
    end process;
    
    -- Output assignments
    count_out <= std_logic_vector(counter_reg);
    max_flag <= max_reached;
    min_flag <= min_reached;
    
end Behavioral;
