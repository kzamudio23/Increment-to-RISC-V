library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Shift Register (SISO): Serial In, Serial Out, register

entity siso_shift_register is
    Port (
        clk        : in  STD_LOGIC;     -- Clock input (100MHz)
        reset      : in  STD_LOGIC;     -- Active high reset (BTNC)
        shift_en   : in  STD_LOGIC;     -- Shift enable (SW0)
        serial_in  : in  STD_LOGIC;     -- Serial input (SW7)
        reg_state  : out STD_LOGIC_VECTOR(7 downto 0) -- Show data with movement fo LED
    );
end siso_shift_register;

architecture Behavioral of siso_shift_register is
    signal shift_reg : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal highlight_pos : integer range 0 to 7 := 0;
begin
    -- Shift register process
    process(clk, reset)
    begin
        if reset = '1' then
            shift_reg <= (others => '0');
            highlight_pos <= 0;
        elsif rising_edge(clk) then
            if shift_en = '1' then
                -- Shift operation
                shift_reg <= serial_in & shift_reg(7 downto 1);
                
                -- Move highlight position
                if highlight_pos = 7 then
                    highlight_pos <= 0;
                else
                    highlight_pos <= highlight_pos + 1;
                end if;
            end if;
        end if;
    end process;
    
    -- Make the moving bit brighter or use different pattern
    process(shift_reg, highlight_pos)
    begin
        for i in 0 to 7 loop -- scary foor loop
            if i = highlight_pos then
                reg_state(i) <= '1';  -- Bright for moving bit
            else
                reg_state(i) <= shift_reg(i);  -- Normal for other bits
            end if;
        end loop;
    end process;
    -- When trying on the board by switching SW0, the LED may look like it appears at a random position but it isnt. It is represented on the order of cycle the sequence is in.
    
    -- To visulaize this, put the SW0 switch in the middle where the led should turn on/off by the slightest movement, then you could see all the LEDS being turned on sequentially 

    -- SW0 and SW7 turns on all LED to represent serial input
end Behavioral;
