library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Button Debouncer --
-- An a press is an a press. You can't say its only a half  --
-- Well TJ "Henry" Yoshi hear me out --
-- A button press has three parts, when a button is pressed, held and released --
-- More technical but this FSM has 6 states when including an untouched idle state --

entity button_debouncer is
    Port (
        clk_100mhz   : in  STD_LOGIC;
        reset        : in  STD_LOGIC;
        button_in    : in  STD_LOGIC; -- Button to press
        button_out   : out STD_LOGIC; -- Debounced output
        button_posedge : out STD_LOGIC; -- Rising edge of button
        button_negedge : out STD_LOGIC; -- Falling edge of button
        db_state     : out STD_LOGIC_VECTOR(5 downto 0)
    );
end button_debouncer;

architecture Behavioral of button_debouncer is
    
    type state_type is (
        IDLE, -- Button isn't pressed
        DETECT_PRESS, -- Debouncing
        CONFIRM_PRESS, -- Press is stablized
        PRESSED, -- Pressed
        DETECT_RELEASE, -- Release detected, debouncing occurs
        CONFIRM_RELEASE -- Released and then goes to IDLE
    );
    signal current_state, next_state : state_type := IDLE;
    
    -- Debounce time of 20ms at 100 MHz so 2,000,000 cycles
    constant DEBOUNCE_TIME : unsigned(23 downto 0) := to_unsigned(2000000, 24);
    signal debounce_counter : unsigned(23 downto 0) := (others => '0');
    signal debounce_done : STD_LOGIC := '0'; --  Flagged when debounce time finishes
    
    signal button_sync : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal button_stable : STD_LOGIC := '0'; -- synchronized with button
    
    signal button_out_int : STD_LOGIC := '0'; -- internal debounce
    signal button_prev    : STD_LOGIC := '0'; -- edge detections
    
begin

    button_out <= button_out_int;
    
    -- Synchronization
    process(clk_100mhz)
    begin
        if rising_edge(clk_100mhz) then
            if reset = '1' then
                button_sync <= (others => '0');
                button_stable <= '0';
            else
                -- Shift register
                button_sync <= button_sync(2 downto 0) & button_in;
                -- Most stable (last used) value
                button_stable <= button_sync(3);
            end if;
        end if;
    end process;
    
    -- Debounce counter and done flag
    process(clk_100mhz)
    begin
        if rising_edge(clk_100mhz) then
            if reset = '1' then
                debounce_counter <= (others => '0');
                debounce_done <= '0';
            else
                -- Reset debounce_done at start of debounce states based on order
                if (current_state = DETECT_PRESS and next_state = DETECT_PRESS) or
                   (current_state = CONFIRM_PRESS and next_state = CONFIRM_PRESS) or
                   (current_state = DETECT_RELEASE and next_state = DETECT_RELEASE) or
                   (current_state = CONFIRM_RELEASE and next_state = CONFIRM_RELEASE) then
                    
                    if debounce_counter = DEBOUNCE_TIME then
                        debounce_counter <= (others => '0');
                        debounce_done <= '1'; -- signals a complete debounce time
                    else
                        debounce_counter <= debounce_counter + 1;
                        debounce_done <= '0';
                    end if;
                else
                    -- reset of counter
                    debounce_counter <= (others => '0');
                    debounce_done <= '0';
                end if;
            end if;
        end if;
    end process;
    
    -- FSM State transition
    process(clk_100mhz)
    begin
        if rising_edge(clk_100mhz) then
            if reset = '1' then
                current_state <= IDLE;
                button_prev <= '0';
            else
                current_state <= next_state;
                button_prev <= button_out_int;
            end if;
        end if;
    end process;
    
    -- FSM Next state logic
    process(current_state, button_stable, debounce_done)
    begin
        case current_state is
            
            when IDLE =>
                if button_stable = '1' then
                    next_state <= DETECT_PRESS;
                else
                    next_state <= IDLE;
                end if;
                
            when DETECT_PRESS =>
                if button_stable = '0' then
                    next_state <= IDLE;
                elsif debounce_done = '1' then
                    next_state <= CONFIRM_PRESS;
                else
                    next_state <= DETECT_PRESS;
                end if;
                
            when CONFIRM_PRESS =>
                if button_stable = '0' then
                    next_state <= IDLE;
                elsif debounce_done = '1' then
                    next_state <= PRESSED;
                else
                    next_state <= CONFIRM_PRESS;
                end if;
                
            when PRESSED =>
                if button_stable = '0' then
                    next_state <= DETECT_RELEASE;
                else
                    next_state <= PRESSED;
                end if;
                
            when DETECT_RELEASE =>
                if button_stable = '1' then
                    next_state <= PRESSED;
                elsif debounce_done = '1' then
                    next_state <= CONFIRM_RELEASE;
                else
                    next_state <= DETECT_RELEASE;
                end if;
                
            when CONFIRM_RELEASE =>
                if button_stable = '1' then
                    next_state <= PRESSED;
                elsif debounce_done = '1' then
                    next_state <= IDLE;
                else
                    next_state <= CONFIRM_RELEASE;
                end if;
                -- I recommend the Free Range VHDL book. Literally the same FSM used in there first diagram of FSM but changed to represent these variables.
        end case;
    end process;
    
    -- FSM Output logic
    process(current_state)
    begin
        case current_state is
            when PRESSED | CONFIRM_PRESS =>
                button_out_int <= '1'; -- Pressed
            when others =>
                button_out_int <= '0'; -- Released
        end case;
    end process;
    
    -- Edge detection
    button_posedge <= '1' when button_out_int = '1' and button_prev = '0' else '0'; -- Half A press
    button_negedge <= '1' when button_out_int = '0' and button_prev = '1' else '0'; -- Second half A press
    
    -- Debug state output
    with current_state select db_state <=
        "000001" when IDLE,
        "000010" when DETECT_PRESS,
        "000100" when CONFIRM_PRESS,
        "001000" when PRESSED,
        "010000" when DETECT_RELEASE,
        "100000" when CONFIRM_RELEASE,
        "000000" when others;
    
end Behavioral;
