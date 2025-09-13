library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- 8 bit register --
-- Must store 8 bit storage --
-- Must have 8 bit input and output --
-- Updates on clock edges -- 

entity register_8bit is
    Port (
        clk        : in  STD_LOGIC;                    -- Clock input (100MHz)
        reset      : in  STD_LOGIC;                    -- Active high reset (BTNC)
        enable     : in  STD_LOGIC;                    -- Enable signal (SW0)
        data_in    : in  STD_LOGIC_VECTOR(7 downto 0); -- 8-bit input (SW6-SW0) Last option is pinned to a button since I want to convey the clk using a spare LED
        data_out   : out STD_LOGIC_VECTOR(7 downto 0); -- 8-bit output (LD7-LD0)
        debug_led  : out STD_LOGIC                     -- Debug LED SW7
    );
end register_8bit;

architecture Behavioral of register_8bit is
    signal reg_data      : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal clock_counter : unsigned(26 downto 0) := (others => '0'); -- Increased to 27 bits
    signal debug_pulse   : STD_LOGIC := '0';
    
    -- Blinking rate control
    constant BLINK_DIVIDER : integer := 2500000; -- 2.5 million cycles = 20Hz toggle = 10Hz blink (very duper fast)
begin
    -- Register process (synchronous)
    process(clk, reset)
    begin
        if reset = '1' then
            -- Asynchronous reset
            reg_data <= (others => '0');
            clock_counter <= (others => '0');
            debug_pulse <= '0';
        elsif rising_edge(clk) then
            -- Clock counter for debug purposes
            if clock_counter = BLINK_DIVIDER - 1 then
                clock_counter <= (others => '0');
                debug_pulse <= not debug_pulse;
            else
                clock_counter <= clock_counter + 1;
            end if;
            
            -- On rising clock edge, store data when enabled
            if enable = '1' then
                reg_data <= data_in;
            end if;
        end if;
    end process;
    
    -- Continuous assignment of register output
    data_out <= reg_data;
    
    -- Debug output
    debug_led <= debug_pulse;
    
end Behavioral; -- You can alter this VHDL by removing the blinking LED feature and implement the last LED/SWITCH back for the "true" (:0 Wowwo) 8 bit  functionality
