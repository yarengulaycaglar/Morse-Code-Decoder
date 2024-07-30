library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ClockDivider is
    Port (
        clk_in : in STD_LOGIC;              -- Input clock (50 MHz)
        clk_out : out STD_LOGIC             -- Output clock (2 Hz)
    );
end ClockDivider;

architecture Behavioral of ClockDivider is
    constant COUNTER_MAX : natural := 25000000;  -- Divide by 25 million for 2 Hz from 50 MHz
    signal counter : natural := 0;
    signal tmp_clk : STD_LOGIC := '0';
begin
    process (clk_in)
    begin
        if rising_edge(clk_in) then
            if counter < COUNTER_MAX then
                counter <= counter + 1;
            else
                counter <= 0;
                tmp_clk <= NOT tmp_clk;  -- Toggle the clock output
            end if;
        end if;
    end process;
    clk_out <= tmp_clk;  -- Output the toggled clock
end Behavioral;
