library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Cross-clock Domain --
-- This is smart but also very dangerous --
-- Button signal changes at any time relative to the clock --
-- Ts means that timing cant be analyzed -- 
entity cross_clock is
    Port (
        -- Clock input (100MHz for ZedBoard)
        clk_100mhz : in STD_LOGIC;
        
        -- Button input (will be used as asynchronous clock)
        btn_clk : in STD_LOGIC;
        
        -- LED output
        led_out : out STD_LOGIC;
        
        -- Additional LED for monitoring (optional)
        status_led : out STD_LOGIC
    );
end cross_clock;

architecture Behavioral of cross_clock is
    
    -- Signal declarations
    signal button_clock : STD_LOGIC := '0';
    signal led_state : STD_LOGIC := '0';
    signal button_sync : STD_LOGIC := '0';
    signal button_prev : STD_LOGIC := '0';
    signal debounce_counter : unsigned(19 downto 0) := (others => '0'); -- ~10ms debounce at 100MHz
    
    -- Metastability prevention flip-flops
    signal meta1, meta2 : STD_LOGIC := '0';
    
begin

    -- Process to synchronize the button input to the main clock domain
    -- This helps reduce metastability when sampling the async button
    sync_process: process(clk_100mhz)
    begin
        if rising_edge(clk_100mhz) then
            meta1 <= btn_clk;      -- First stage
            meta2 <= meta1;        -- Second stage (synchronized)
            button_sync <= meta2;  -- Synchronized button signal
        end if;
    end process sync_process;

    -- Simple debounce process (optional but recommended for learning)
    debounce_process: process(clk_100mhz)
    begin
        if rising_edge(clk_100mhz) then
            button_prev <= button_sync;
            
            if button_sync /= button_prev then
                -- Button state changed, reset counter
                debounce_counter <= (others => '0');
            elsif debounce_counter < to_unsigned(1000000, 20) then -- 10ms at 100MHz
                -- Count while button is stable
                debounce_counter <= debounce_counter + 1;
            else
                -- Button is stable, use it as clock
                button_clock <= button_sync;
            end if;
        end if;
    end process debounce_process;

    -- CROSS-CLOCK DOMAIN PROCESS (THE "BAD PRACTICE" PART)
    -- Using button as a clock - this is what we're demonstrating as problematic
    button_clock_process: process(button_clock)
    begin
        if rising_edge(button_clock) then
            -- Toggle LED on button press (rising edge)
            led_state <= not led_state;
        end if;
    end process button_clock_process;

    -- Output assignment
    led_out <= led_state;
    
    -- Status LED blinks at 1Hz to show main clock is running
    status_led_process: process(clk_100mhz)
        variable counter : integer range 0 to 50000000 := 0;
    begin
        if rising_edge(clk_100mhz) then
            if counter < 25000000 then
                status_led <= '1';
                counter := counter + 1;
            elsif counter < 50000000 then
                status_led <= '0';
                counter := counter + 1;
            else
                counter := 0;
            end if;
        end if;
    end process status_led_process;

end Behavioral;
