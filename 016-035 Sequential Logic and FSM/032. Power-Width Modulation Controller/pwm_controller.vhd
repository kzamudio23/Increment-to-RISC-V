library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Pulse-Width Modulation (PWM) controller --
-- Controlls the LED brightness --
-- Plan is to showcase variety of brightness by using all switches and leds --
-- So instead of 2 bits for 4 states, you would need 4 bits for 4 states --
-- More readable and generally quicker in computation and just making --
-- Point of this is to scale cycles correc

entity pwm_controller is
    Port (
        clk         : in  STD_LOGIC;
        reset       : in  STD_LOGIC;
        sw          : in  STD_LOGIC_VECTOR(7 downto 0);
        leds        : out STD_LOGIC_VECTOR(7 downto 0)
    );
end pwm_controller;

architecture behavioral of pwm_controller is
    
    -- PWM counter (12-bit for 4096 levels of brightness)
    signal pwm_counter : unsigned(11 downto 0) := (others => '0');
    
    -- Duty cycle registers for each LED (8-bit for 256 levels)
    signal duty_cycles : unsigned(63 downto 0) := (others => '0');
    
    -- Scaled duty cycles for different brightness ranges
    signal scaled_duty_0 : unsigned(11 downto 0); -- Full range (0-255 → 0-4095)
    signal scaled_duty_1 : unsigned(11 downto 0); -- 3/4 range (0-255 → 0-3071)
    signal scaled_duty_2 : unsigned(11 downto 0); -- 2/3 range (0-255 → 0-2730)
    signal scaled_duty_3 : unsigned(11 downto 0); -- 1/2 range (0-255 → 0-2047)
    signal scaled_duty_4 : unsigned(11 downto 0); -- 1/3 range (0-255 → 0-1365)
    signal scaled_duty_5 : unsigned(11 downto 0); -- 1/4 range (0-255 → 0-1023)
    signal scaled_duty_6 : unsigned(11 downto 0); -- 1/8 range (0-255 → 0-511)
    signal scaled_duty_7 : unsigned(11 downto 0); -- 1/16 range (0-255 → 0-255)
    
begin

    -- Process to update duty cycles from switches
    process(clk, reset)
    begin
        if reset = '1' then
            duty_cycles <= (others => '0');
        elsif rising_edge(clk) then
            -- Update duty cycles from switches
            duty_cycles(7 downto 0)   <= unsigned(sw);   -- LED0: Full range
            duty_cycles(15 downto 8)  <= unsigned(sw);   -- LED1: 3/4 range
            duty_cycles(23 downto 16) <= unsigned(sw);   -- LED2: 2/3 range
            duty_cycles(31 downto 24) <= unsigned(sw);   -- LED3: 1/2 range
            duty_cycles(39 downto 32) <= unsigned(sw);   -- LED4: 1/3 range
            duty_cycles(47 downto 40) <= unsigned(sw);   -- LED5: 1/4 range
            duty_cycles(55 downto 48) <= unsigned(sw);   -- LED6: 1/8 range
            duty_cycles(63 downto 56) <= unsigned(sw);   -- LED7: 1/16 range
        end if;
    end process;

--    -- Scale duty cycles to different ranges
--    scaled_duty_0 <= resize(duty_cycles(7 downto 0) & "0000", 12);    -- ×16 (0-4080)
--    scaled_duty_1 <= resize(duty_cycles(15 downto 8) * 12, 12);       -- ×12 (0-3060)
--    scaled_duty_2 <= resize(duty_cycles(23 downto 16) * 11, 12);      -- ×11 (0-2805)
--    scaled_duty_3 <= resize(duty_cycles(31 downto 24) & "00", 12);    -- ×4 (0-1020)
--    scaled_duty_4 <= resize(duty_cycles(39 downto 32) * 5, 12);       -- ×5 (0-1275)
--    scaled_duty_5 <= resize(duty_cycles(47 downto 40) & "0", 12);     -- ×2 (0-510)
--    scaled_duty_6 <= duty_cycles(55 downto 48) & "000";               -- ×8 (0-2040)
--    scaled_duty_7 <= "0000" & duty_cycles(63 downto 56);              -- ×1 (0-255)

--     Alternative method using bit shifting (more efficient)
     scaled_duty_0 <= (others => sw(0));  -- Full brightness when switch is on
     scaled_duty_1 <= "0" & (10 downto 0 => sw(1));  -- 1/2 brightness
     scaled_duty_2 <= "00" & (9 downto 0 => sw(2));  -- 1/4 brightness
     scaled_duty_3 <= "000" & (8 downto 0 => sw(3));  -- 1/8 brightness
     scaled_duty_4 <= "0000" & (7 downto 0 => sw(4));  -- 1/16 brightness
     scaled_duty_5 <= "00000" & (6 downto 0 => sw(5));  -- 1/32 brightness
     scaled_duty_6 <= "000000" & (5 downto 0 => sw(6));  -- 1/64 brightness
     scaled_duty_7 <= "0000000" & (4 downto 0 => sw(7));  -- 1/128 brightness

    -- PWM counter process
    process(clk, reset)
    begin
        if reset = '1' then
            pwm_counter <= (others => '0');
        elsif rising_edge(clk) then
            pwm_counter <= pwm_counter + 1;  -- Count from 0 to 4095
        end if;
    end process;

    -- PWM output generation
    process(pwm_counter, scaled_duty_0, scaled_duty_1, scaled_duty_2, scaled_duty_3,
            scaled_duty_4, scaled_duty_5, scaled_duty_6, scaled_duty_7)
    begin
        -- Each LED has different brightness range
        if pwm_counter < scaled_duty_0 then
            leds(0) <= '1';  -- LED0: Full brightness range
        else
            leds(0) <= '0';
        end if;
        
        if pwm_counter < scaled_duty_1 then
            leds(1) <= '1';  -- LED1: 3/4 brightness range
        else
            leds(1) <= '0';
        end if;
        
        if pwm_counter < scaled_duty_2 then
            leds(2) <= '1';  -- LED2: 2/3 brightness range
        else
            leds(2) <= '0';
        end if;
        
        if pwm_counter < scaled_duty_3 then
            leds(3) <= '1';  -- LED3: 1/2 brightness range
        else
            leds(3) <= '0';
        end if;
        
        if pwm_counter < scaled_duty_4 then
            leds(4) <= '1';  -- LED4: 1/3 brightness range
        else
            leds(4) <= '0';
        end if;
        
        if pwm_counter < scaled_duty_5 then
            leds(5) <= '1';  -- LED5: 1/4 brightness range
        else
            leds(5) <= '0';
        end if;
        
        if pwm_counter < scaled_duty_6 then
            leds(6) <= '1';  -- LED6: 1/8 brightness range
        else
            leds(6) <= '0';
        end if;
        
        if pwm_counter < scaled_duty_7 then
            leds(7) <= '1';  -- LED7: 1/16 brightness range
        else
            leds(7) <= '0';
        end if;
    end process;

end Behavioral;
