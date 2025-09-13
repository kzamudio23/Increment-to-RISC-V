library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- SIPO Serial Input, Parallel-Output
-- One input by SW7, all 8 bits available in parallel
-- Same vain as SISO but instead of chained bits, the bits are paralleled. 
-- LED will all be on when SW0 is switched on but dimmed (Really fast movement)

entity sipo_shift_register is
    Port (
        clk        : in  STD_LOGIC;     -- Clock input (100MHz)
        reset      : in  STD_LOGIC;     -- Active high reset (BTNC)
        shift_en   : in  STD_LOGIC;     -- Shift enable (SW0)
        serial_in  : in  STD_LOGIC;     -- Serial input (SW7)
        parallel_out : out STD_LOGIC_VECTOR(7 downto 0) -- Parallel output on LEDs
    );
end sipo_shift_register;

architecture Behavioral of sipo_shift_register is
    signal shift_reg : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal bit_tracker : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal shift_counter : integer range 0 to 7 := 0;
begin
    -- Shift register process (synchronous)
    process(clk, reset)
    begin
        if reset = '1' then
            -- Asynchronous reset - clear everything
            shift_reg <= (others => '0');
            bit_tracker <= (others => '0');
            shift_counter <= 0;
        elsif rising_edge(clk) then
            -- Shift operation when enabled
            if shift_en = '1' then
                -- Shift right: MSB gets serial_in, others shift right
                shift_reg <= serial_in & shift_reg(7 downto 1);
                
                -- Update bit tracker for visual movement
                if shift_counter = 7 then
                    shift_counter <= 0;
                    bit_tracker <= (others => '0'); -- Reset tracker
                else
                    shift_counter <= shift_counter + 1;
                    -- Create a moving "wave" effect
                    bit_tracker <= std_logic_vector(shift_left(to_unsigned(1, 8), shift_counter));
                end if;
            end if;
        end if;
    end process;
    
    -- Combine data and movement for visual output
    process(shift_reg, bit_tracker)
    begin
        -- Show data bits OR'd with movement indicator
        -- This makes the moving bit brighter while showing all data
        for i in 0 to 7 loop
            parallel_out(i) <= shift_reg(i) or bit_tracker(i);
        end loop;
    end process;
    
end Behavioral;
