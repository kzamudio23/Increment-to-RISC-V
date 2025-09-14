library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Ring Counter --
-- LSB feeds back to MSB --
-- Has continous pattern --
-- Synchronous -- 

entity ring_counter is
    Port (
        clk        : in  STD_LOGIC;     -- Clock input (100MHz)
        reset      : in  STD_LOGIC;     -- Active high reset (BTNC)
        enable     : in  STD_LOGIC;     -- Enable counting (SW0)
        count_out  : out STD_LOGIC_VECTOR(7 downto 0) -- Ring pattern on LEDs
    );
end ring_counter;

architecture Behavioral of ring_counter is
    signal ring_reg : STD_LOGIC_VECTOR(7 downto 0) := "00000001"; -- Start with single '1' then goes to a riung pattern
    signal slow_counter : unsigned(25 downto 0) := (others => '0'); -- Clock division
begin
    
    -- Ring counter process with built-in slow timing
    process(clk, reset)
    begin
        if reset = '1' then
            -- Reset: Set single '1' at position 0 for BTNC
            ring_reg <= "00000001";
            slow_counter <= (others => '0');
        elsif rising_edge(clk) then
            if enable = '1' then
                -- Count up to create visible delay (~1.5Hz)
                if slow_counter = 33333333 then  -- ~0.33 seconds at 100MHz
                    slow_counter <= (others => '0');
                    -- Circular shift right: LSB goes to MSB (Least to most significant bit)
                    ring_reg <= ring_reg(0) & ring_reg(7 downto 1);
                else
                    slow_counter <= slow_counter + 1;
                end if;
            end if;
        end if;
    end process;
    
    -- Output assignment
    count_out <= ring_reg;
    
end Behavioral;
