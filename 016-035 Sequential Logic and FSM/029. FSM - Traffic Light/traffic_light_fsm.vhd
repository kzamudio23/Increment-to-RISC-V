library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Traffic Light FSM --
-- FSM that is controlled with different timing constraints for each color --
-- Should function as a regular traffic light, red to green to yello to red --
-- Outputs could be done by creating a 3 bit bus of 001, 010, 100 or by indication of states (which both are done) --

entity traffic_light_fsm is
    Port (
        clk      : in  STD_LOGIC;   -- System clock
        reset    : in  STD_LOGIC;   -- System reset
        red      : out STD_LOGIC;   -- Red light output
        yellow   : out STD_LOGIC;   -- Yellow light output
        green    : out STD_LOGIC;   -- Green light output
        state_debug : out STD_LOGIC_VECTOR(2 downto 0) -- State debug output
    );
end traffic_light_fsm;

architecture Behavioral of traffic_light_fsm is
    
    -- FSM States
    type state_type is (
        RED_STATE,
        GREEN_STATE,
        YELLOW_STATE
    );
    signal current_state, next_state : state_type := RED_STATE;
    
    -- Timing constants (for 100MHz clock)
    constant RED_TIME    : unsigned(27 downto 0) := to_unsigned(100000000, 28); -- 1 second
    constant GREEN_TIME  : unsigned(27 downto 0) := to_unsigned(150000000, 28); -- 1.5 seconds
    constant YELLOW_TIME : unsigned(27 downto 0) := to_unsigned(50000000, 28);  -- 0.5 seconds
    
    signal timer_counter : unsigned(27 downto 0) := (others => '0');
    signal timer_expired : STD_LOGIC := '0';
    
begin

    -- Timer process
    timer_process: process(clk, reset)
    begin
        if reset = '1' then
            timer_counter <= (others => '0');
            timer_expired <= '0';
        elsif rising_edge(clk) then
            if current_state /= next_state then
                timer_counter <= (others => '0'); -- Reset timer on state change
                timer_expired <= '0';
            else
                case current_state is
                    when RED_STATE =>
                        if timer_counter = RED_TIME then
                            timer_expired <= '1';
                        else
                            timer_counter <= timer_counter + 1;
                            timer_expired <= '0';
                        end if;
                    
                    when GREEN_STATE =>
                        if timer_counter = GREEN_TIME then
                            timer_expired <= '1';
                        else
                            timer_counter <= timer_counter + 1;
                            timer_expired <= '0';
                        end if;
                    
                    when YELLOW_STATE =>
                        if timer_counter = YELLOW_TIME then
                            timer_expired <= '1';
                        else
                            timer_counter <= timer_counter + 1;
                            timer_expired <= '0';
                        end if;
                end case;
            end if;
        end if;
    end process timer_process;

    -- State register process
    state_register: process(clk, reset)
    begin
        if reset = '1' then
            current_state <= RED_STATE;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process state_register;

    -- Next state logic process
    next_state_logic: process(current_state, timer_expired)
    begin
        case current_state is
            when RED_STATE =>
                if timer_expired = '1' then
                    next_state <= GREEN_STATE;
                else
                    next_state <= RED_STATE;
                end if;
                
            when GREEN_STATE =>
                if timer_expired = '1' then
                    next_state <= YELLOW_STATE;
                else
                    next_state <= GREEN_STATE;
                end if;
                
            when YELLOW_STATE =>
                if timer_expired = '1' then
                    next_state <= RED_STATE;
                else
                    next_state <= YELLOW_STATE;
                end if;
                
            when others =>
                next_state <= RED_STATE;
        end case;
    end process next_state_logic;

    -- Output logic process
    output_logic: process(current_state)
    begin
        case current_state is
            when RED_STATE =>
                red <= '1';
                yellow <= '0';
                green <= '0';
                
            when GREEN_STATE =>
                red <= '0';
                yellow <= '0';
                green <= '1';
                
            when YELLOW_STATE =>
                red <= '0';
                yellow <= '1';
                green <= '0';
                
            when others =>
                red <= '1';
                yellow <= '0';
                green <= '0';
        end case;
    end process output_logic;

    -- Debug output for state monitoring (I could just use this instead of all the other output logic processes but that'll dismiss the purpose of ts being an FSM
    with current_state select state_debug <=
        "001" when RED_STATE,     -- Red
        "010" when YELLOW_STATE,  -- Yellow
        "100" when GREEN_STATE,   -- Green
        "001" when others;        -- Default to Red

end Behavioral;
