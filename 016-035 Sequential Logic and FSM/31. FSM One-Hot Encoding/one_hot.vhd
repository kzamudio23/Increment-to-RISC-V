library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- One-hot encoding FSM --
-- One-hot encoding is called this because one bit is "hot", meaning it is always set to 1 --
-- Everything else is 0 --
-- So instead of 2 bits for 4 states, you would need 4 bits for 4 states --
-- More readable and generally quicker in computation and just making --

entity onehot_fsm is
    Port (
        clk         : in  STD_LOGIC;
        reset       : in  STD_LOGIC;
        input_a     : in  STD_LOGIC;
        input_b     : in  STD_LOGIC;
        input_c     : in  STD_LOGIC;
        output_x    : out STD_LOGIC;
        output_y    : out STD_LOGIC;
        output_z    : out STD_LOGIC;
        state_debug : out STD_LOGIC_VECTOR(3 downto 0)
    );
end onehot_fsm;

architecture Behavioral of onehot_fsm is

    -- State definitions using one-hot encoding
    type state_type is (
        IDLE,       -- 0001
        START,      -- 0010  
        PROCESSING, -- 0100
        COMPLETE    -- 1000
    );
    
    -- One-hot encoded state signals
    signal current_state, next_state : STD_LOGIC_VECTOR(3 downto 0);
    
    -- State constants (one-hot encoding)
    constant STATE_IDLE        : STD_LOGIC_VECTOR(3 downto 0) := "0001";
    constant STATE_START       : STD_LOGIC_VECTOR(3 downto 0) := "0010";
    constant STATE_PROCESSING  : STD_LOGIC_VECTOR(3 downto 0) := "0100";
    constant STATE_COMPLETE    : STD_LOGIC_VECTOR(3 downto 0) := "1000";

begin

    -- State register process (synchronous)
    state_register: process(clk, reset)
    begin
        if reset = '1' then
            current_state <= STATE_IDLE;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process state_register;

    -- Next state logic (combinational)
    next_state_logic: process(current_state, input_a, input_b, input_c)
    begin
        case current_state is
            when STATE_IDLE =>
                if input_a = '1' then
                    next_state <= STATE_START;
                else
                    next_state <= STATE_IDLE;
                end if;
                
            when STATE_START =>
                if input_b = '1' then
                    next_state <= STATE_PROCESSING;
                else
                    next_state <= STATE_START;
                end if;
                
            when STATE_PROCESSING =>
                if input_c = '1' then
                    next_state <= STATE_COMPLETE;
                else
                    next_state <= STATE_PROCESSING;
                end if;
                
            when STATE_COMPLETE =>
                if input_a = '0' and input_b = '0' then
                    next_state <= STATE_IDLE;
                else
                    next_state <= STATE_COMPLETE;
                end if;
                
            when others =>
                next_state <= STATE_IDLE;
        end case;
    end process next_state_logic;

    -- Output logic (combinational)
    output_logic: process(current_state)
    begin
        -- Default outputs
        output_x <= '0';
        output_y <= '0';
        output_z <= '0';
        
        case current_state is
            when STATE_IDLE =>
                output_x <= '1';
                
            when STATE_START =>
                output_x <= '1';
                output_y <= '1';
                
            when STATE_PROCESSING =>
                output_y <= '1';
                output_z <= '1';
                
            when STATE_COMPLETE =>
                output_z <= '1';
                
            when others =>
                output_x <= '0';
                output_y <= '0';
                output_z <= '0';
        end case;
    end process output_logic;

    -- Debug output to monitor state
    state_debug <= current_state;

end Behavioral;
