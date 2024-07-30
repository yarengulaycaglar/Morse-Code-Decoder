library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity InputConverter is
    Port (
        clk : in STD_LOGIC;                   -- Clock input (2 Hz)
        morse_in : in STD_LOGIC;              -- Morse code input
        output_signal : out STD_LOGIC_VECTOR(1 downto 0)  -- "01" for Dot, "10" for Dash, "11" for Gap
    );
end InputConverter;

architecture Behavioral of InputConverter is
    -- Since each clock cycle is 0.5 seconds with a 2 Hz clock
    constant DOT_THRESHOLD : natural := 1;        -- 0.1 seconds would be less than one cycle, rounded to 1 for practical reasons
    constant DASH_THRESHOLD : natural := 1;       -- 0.3 seconds rounds to less than one cycle, adjusted to 1
    constant GAP_THRESHOLD : natural := 2;        -- 0.7 seconds needs more than one cycle

    signal timer : natural := 0;                  -- Timer to measure duration of signals
    signal last_input : STD_LOGIC := '0';         -- Store the last input to detect edges

begin
    process(clk)
    begin
        if rising_edge(clk) then
            if morse_in = '1' and last_input = '0' then
                timer <= 0; -- Start timing the pulse
            elsif morse_in = '1' then
                timer <= timer + 1;
            elsif last_input = '1' then
                if timer <= DOT_THRESHOLD then
                    output_signal <= "01"; -- Dot
                elsif timer <= DASH_THRESHOLD then
                    output_signal <= "10"; -- Dash
                else
                    output_signal <= "11"; -- Gap
                end if;
                timer <= 0; -- Reset timer
            end if;
            if morse_in = '0' and timer >= GAP_THRESHOLD then
                output_signal <= "11"; -- Gap
                timer <= 0;
            end if;
            last_input <= morse_in;
        end if;
    end process;
end Behavioral;
