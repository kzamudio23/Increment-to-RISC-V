library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- D Flip-Flop --
-- Captures an input on the rising clock edge --
-- Has an asynchronous reset (immediate reset regardless of clock) -- 
entity dff is
    Port (
        clk_100mhz   : in STD_LOGIC;   -- 100MHz clock
        btn_reset    : in STD_LOGIC;   -- Reset button
        btn_data     : in STD_LOGIC;   -- Data input button
        led_q        : out STD_LOGIC;  -- Output LED
        led_clk      : out STD_LOGIC   -- Clock monitor LED
    );
end dff;

architecture Behavioral of dff is

    signal clk_divider : integer range 0 to 50000000 := 0;
    signal slow_clk    : STD_LOGIC := '0';
    signal data_sync   : STD_LOGIC := '0';
    signal reset_sync  : STD_LOGIC := '0';

begin

    -- Clock divider: 100MHz -> 1Hz for visibility
    clock_divider: process(clk_100mhz)
    begin
        if rising_edge(clk_100mhz) then
            if clk_divider < 50000000 then
                clk_divider <= clk_divider + 1;
            else
                clk_divider <= 0;
                slow_clk <= not slow_clk;
            end if;
        end if;
    end process;

    -- Input synchronizers (important for button inputs)
    sync_inputs: process(clk_100mhz)
    begin
        if rising_edge(clk_100mhz) then
            reset_sync <= btn_reset;
            data_sync <= btn_data;
        end if;
    end process;

    -- D Flip-Flop instance
    dff_instance: process(slow_clk, reset_sync)
    begin
        if reset_sync = '1' then
            led_q <= '0';
        elsif rising_edge(slow_clk) then
            led_q <= data_sync;
        end if;
    end process;

    -- Clock monitor (blinks at 1Hz)
    led_clk <= slow_clk;

end Behavioral;
