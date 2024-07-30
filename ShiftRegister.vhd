library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ShiftRegister is
    Port (
        clk : in STD_LOGIC;
        shift : in STD_LOGIC;
        data_in : in STD_LOGIC_VECTOR(7 downto 0);
        data_out : out STD_LOGIC_VECTOR(47 downto 0)  -- Adjusted for multiple displays
    );
end ShiftRegister;

architecture Behavioral of ShiftRegister is
    signal internal_reg : STD_LOGIC_VECTOR(47 downto 0);  -- Adjusted for six 8-bit values

begin
    -- Process for handling data shifting
    shift_process : process(clk)
    begin
        if rising_edge(clk) then
            if shift = '1' then
                -- Shift entire register left by 8 bits and introduce new data on the right
                internal_reg <= internal_reg(39 downto 0) & data_in;
            end if;
        end if;
    end process;

    -- Output assignment
    data_out <= internal_reg; -- Output the current value of the internal register
end Behavioral;
