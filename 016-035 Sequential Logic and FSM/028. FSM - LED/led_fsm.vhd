library IEEE;
use IEEE.std_logic_1164.all;

-- LED FSM --
-- 2 State FSM that shows an error on the LED --
-- When going from ST0 to ST1 with a switch (enable), the led will turn on half dimmed --
-- But as the switch is turned off, theres a chance the led turns off or becomes brighter while Z1 remains a singular output mode (std_logic) --
-- This is probably do to the waveform that I defined in previous code that I used and no clock divider so this bug is dependnent of the clk itself --
-- create_clock -period 10.000 -name clk -waveform {0.000 5.000} [get_ports clk] --
-- I won't change this to show why its important to look at your clk signals since this is a simple FSM --

entity led_fsm is 
    port(enable   : in std_logic;
         clk, clr : in std_logic;
         Z1       : out std_logic);
end led_fsm;

architecture fsm of led_fsm is
    type state_type is (ST0, ST1); -- Represents 0 or 1
    signal PS,NS : state_type;
begin
    sync_proc: process(clk, ns, clr)
    begin
    -- asynchronous input
        if clr = '1' then
        PS <= ST0;
        elsif (rising_edge(clk)) then
            PS <= NS;
        end if;
    end process sync_proc;

comb_proc: process(PS, enable) 
begin
   -- Z1 <= '0';  -- Pre-assigned output
     case PS is
        when ST0 =>
            Z1 <= '0';
            if enable = '1' then NS <= ST1;
            else NS <= ST0;
            end if;
        when ST1 =>
            Z1 <= '1';                        
            if enable = '1' then NS <= ST0;
            else NS <= ST1;   
            end if;
        when others =>
            Z1 <= '0';
            NS <= ST0;
     end case;           
    end process comb_proc;
end fsm;
