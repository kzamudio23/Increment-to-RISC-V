library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-- PISO register --
-- Parallel input and Serial output
-- LEDs are turned on at once depending on switches and btn config to present parallelism (look at the end of this vhdl code)
-- When SW0 is switched up, you can input the led config
-- SW1 is serial shift  to see shift in data theres the LED moving 


entity piso_shift_register is
    Port (
        clk         : in  STD_LOGIC;                    
        reset       : in  STD_LOGIC;                    
        load        : in  STD_LOGIC;                    
        shift_en    : in  STD_LOGIC;                    
        parallel_in : in  STD_LOGIC_VECTOR(7 downto 0); 
        serial_out  : out STD_LOGIC;                    
        reg_state   : out STD_LOGIC_VECTOR(7 downto 0)  
    );
end piso_shift_register;

architecture Behavioral of piso_shift_register is
    signal shift_reg : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal slow_clk  : STD_LOGIC := '0';
    signal counter   : unsigned(23 downto 0) := (others => '0');
begin
    
    -- Clock divider: 100MHz -> ~6Hz (slow enough to see)
    process(clk)
    begin
        if rising_edge(clk) then
            if counter = 8000000 then  -- Adjust for visible speed
                counter <= (others => '0');
                slow_clk <= not slow_clk;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;
    
    -- Shift register process using slow clock
    process(slow_clk, reset)
    begin
        if reset = '1' then
            shift_reg <= (others => '0');
        elsif rising_edge(slow_clk) then
            if load = '1' then
                shift_reg <= parallel_in;  -- Parallel load
            elsif shift_en = '1' then
                shift_reg <= '0' & shift_reg(7 downto 1);  -- Shift right
            end if;
        end if;
    end process;
    
    -- Output assignments
    serial_out <= shift_reg(0);
    reg_state <= shift_reg;
    -- Basically SW0 will "load" the information and SW1 will allow the informaiton to shift or stay still
    -- All other switches give the data that appears in the line of LEDS (BTNR [1] and BTNU [0] are made to allocate the switches, just hold them and dont release)
    
end Behavioral;
