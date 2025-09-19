library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity my_fsm4_tb is
end my_fsm4_tb;

architecture testbench of my_fsm4_tb is

  component hybrid_fsm
    port ( X, CLK, RESET : in  std_logic;
           Y : out std_logic_vector(1 downto 0);
           Z1, Z2 : out std_logic);
  end component;

  signal X, CLK, RESET : std_logic;
  signal Y : std_logic_vector(1 downto 0);
  signal Z1, Z2 : std_logic;

  constant clock_period : time := 10 ns;
  signal stop_the_clock : boolean := false;  -- Signal declaration

begin

  uut: hybrid_fsm
    port map ( X     => X,
               CLK   => CLK,
               RESET => RESET,
               Y     => Y,
               Z1    => Z1,
               Z2    => Z2 );

  -- Clock generation process
  clock_process: process
  begin
    while not stop_the_clock loop
      CLK <= '0';
      wait for clock_period / 2;
      CLK <= '1';
      wait for clock_period / 2;
    end loop;
    wait;
  end process;

  -- Stimulus process
  stimulus: process
  begin
    -- Initialize inputs
    RESET <= '1';
    X <= '0';
    wait for clock_period;
    
    -- Release reset
    RESET <= '0';
    wait for clock_period;
    
    -- Test case 1: Input pattern '0'
    report "Test 1: Input X = '0'";
    X <= '0';
    wait for clock_period;
    
    -- Test case 2: Input pattern '0' again (ST1 -> ST2)
    report "Test 2: Input X = '0' again";
    X <= '0';
    wait for clock_period;
    
    -- Test case 3: Input pattern '0' again (ST2 -> ST3)
    report "Test 3: Input X = '0' again";
    X <= '0';
    wait for clock_period;
    
    -- Test case 4: Input pattern '0' again (ST3 -> ST0)
    report "Test 4: Input X = '0' again";
    X <= '0';
    wait for clock_period;
    
    -- Test case 5: Input pattern '1' in ST0
    report "Test 5: Input X = '1' in ST0";
    X <= '1';
    wait for clock_period;
    
    -- End simulation after a while
    wait for 5 * clock_period;
    
    -- THIS IS THE CRITICAL LINE TO STOP THE INFINITE LOOP
    stop_the_clock <= true;
    
    report "Simulation completed";
    wait;
  end process;

end testbench;
