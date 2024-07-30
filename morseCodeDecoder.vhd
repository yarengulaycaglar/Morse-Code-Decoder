library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MorseCodeDecoder is
    Port (
        clk : in STD_LOGIC;                             -- Main clock input (50 MHz)
        morse_in : in STD_LOGIC;                        -- Morse code input from a button (KEY0)
        segments : out STD_LOGIC_VECTOR(41 downto 0);   -- To handle 6 separate displays
        displays : out STD_LOGIC_VECTOR(5 downto 0);    -- Display enable signals
        inputConverter_output : out STD_LOGIC_VECTOR(1 downto 0); -- Output from Input Converter
		  clk_div : out STD_LOGIC
    );
end MorseCodeDecoder;

architecture Structural of MorseCodeDecoder is
	type segments_array is array (0 to 5) of STD_LOGIC_VECTOR(6 downto 0);
	
    -- Internal signals
    signal slow_clk : STD_LOGIC;
    signal input_signal : STD_LOGIC_VECTOR(1 downto 0);
    signal ascii_out : STD_LOGIC_VECTOR(7 downto 0);
    signal detect : STD_LOGIC;
    signal shift_signal : STD_LOGIC;
    signal shift_register_out : STD_LOGIC_VECTOR(47 downto 0);
	 signal individual_segments : segments_array;  -- Individual segment arrays for displays


begin
    -- Instance of the Clock Divider
    clkDivider: entity work.ClockDivider
        port map (
            clk_in => clk,
            clk_out => slow_clk
        );

    -- Instance of the Input Converter Device
    inputConverter: entity work.InputConverter
        port map (
            clk => slow_clk,        -- Use the slow clock for Morse code detection
            morse_in => morse_in,
            output_signal => input_signal
        );

    -- Instance of the mcdecoder
    mcdecoder: entity work.mcdecoder
        port map (
            clk => slow_clk,
            mcdecoder_input => input_signal,
            ascii_out => ascii_out,
            detect => detect
        );

    -- Instance of the Shift Register
    shiftRegister: entity work.ShiftRegister
        port map (
            clk => slow_clk,
            shift => shift_signal,
            data_in => ascii_out,
            data_out => shift_register_out
        );

    -- Instances of the ASCII to Seven Segment Decoder for each display
    gen_sevenSegmentDecoders: for i in 0 to 5 generate
        sevenSegmentDecoder: entity work.ascii2led
            port map (
                ASCII => shift_register_out(8*(i+1)-1 downto 8*i),
                LED => individual_segments(i)
            );
    end generate;

    -- Combine individual segment outputs into a single vector
    segments <= individual_segments(0) & individual_segments(1) & individual_segments(2) & 
                individual_segments(3) & individual_segments(4) & individual_segments(5);

    -- Logic to generate the shift signal for the shift register
    shiftLogic: process(clk)
    begin
	 clk_div <=  slow_clk;
        if rising_edge(clk) then
            if detect = '1' then
                shift_signal <= '1';
            else
                shift_signal <= '0';
            end if;
        end if;
    end process;

    -- Logic to control the display enable signals
    display_control: process(clk)
    begin 
        if rising_edge(clk) then
            displays <= (others => '1');  -- Example: enable all displays
        end if;
    end process;

end Structural;
