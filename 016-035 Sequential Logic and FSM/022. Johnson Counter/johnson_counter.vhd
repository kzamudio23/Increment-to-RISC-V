library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Johnson Counter --
-- Not a LSB feeds back to MSB --
-- In this instance, other bits shift right --
-- Has 16 states instead of 8 states in ring counter -- 
-- SW0 activates while BTNC clears clock as usual --

entity johnson_counter is
    Port (
        clk        : in  STD_LOGIC;     -- Clock input (100MHz)
        reset      : in  STD_LOGIC;     -- Active high reset (BTNC)
        enable     : in  STD_LOGIC;     -- Enable counting (SW0)
        count_out  : out STD_LOGIC_VECTOR(7 downto 0) -- Johnson pattern on LEDs
    );
end johnson_counter;

architecture Behavioral of johnson_counter is
    signal johnson_reg : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal slow_counter : unsigned(25 downto 0) := (others => '0');
begin
    
    -- Johnson counter process with built-in slow timing
    process(clk, reset)
    begin
        if reset = '1' then
            -- Reset: Clear all bits
            johnson_reg <= (others => '0');
            slow_counter <= (others => '0');
        elsif rising_edge(clk) then
            if enable = '1' then
                -- Count up to create visible delay (~1Hz)
                if slow_counter = 50000000 then  -- ~0.5 seconds at 100MHz
                    slow_counter <= (others => '0');
                    -- Johnson shift: NOT of LSB goes to MSB, others shift right
                    johnson_reg <= not johnson_reg(0) & johnson_reg(7 downto 1);
                else
                    slow_counter <= slow_counter + 1;
                end if;
            end if;
        end if;
    end process;
    
    -- Output assignment
    count_out <= johnson_reg;
    
end Behavioral;
