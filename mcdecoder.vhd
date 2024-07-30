library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mcdecoder is
    Port (
        clk : in STD_LOGIC;                               -- Clock signal
        mcdecoder_input : in STD_LOGIC_VECTOR(1 downto 0);      -- "01" for Dot, "10" for Dash, "11" for Gap
        ascii_out : out STD_LOGIC_VECTOR(7 downto 0);          -- ASCII output
        detect : out STD_LOGIC                            -- Detection indicator
    );
end mcdecoder;

architecture Behavioral of mcdecoder is
    -- Define a state for each Morse code character
    type state_type is (
    idle,
    state_A, state_B, state_C, state_D, state_E, state_F, state_G,
    state_H, state_I, state_J, state_K, state_L, state_M, state_N,
    state_O, state_O_Dot, state_O_Dash,state_P, state_Q, state_R, state_S, state_T, state_U, state_U_Dash,
    state_V, state_W, state_X, state_Y, state_Z,
    state_0, state_1, state_2, state_3, state_4,
    state_5, state_6, state_7, state_8, state_9,
    reset_state
);

    signal current_state, next_state : state_type := idle;
    
begin
    process(clk)
    begin
        if rising_edge(clk) then
            current_state <= next_state;  -- State transition on clock edge
        end if;
    end process;

    -- Next state logic
    process(current_state, mcdecoder_input)
    begin
        detect <= '0';  -- Default to no valid character detected
        ascii_out <= (others => '0');  -- Default to no output

        case current_state is
            when idle =>
                case mcdecoder_input is
                    when "01" => next_state <= state_E;  -- Dot moves to E
                    when "10" => next_state <= state_T;  -- Dash moves to T
                    when "11" => next_state <= idle;     -- Stay idle on Gap
                    when others => next_state <= idle;    -- Stay idle for safety
                end case;
					 
				when state_A =>
                if mcdecoder_input = "11" then  -- If Gap detected
                    ascii_out <= "01000001";  -- ASCII 
                    detect <= '1';       -- Signal valid character detected
                    next_state <= reset_state;
                else
                    case mcdecoder_input is
                        when "01" => next_state <= state_R;  
                        when "10" => next_state <= state_W;  
                        when others => next_state <= idle; 
                    end case;
                end if;
					 
				when state_B =>
                if mcdecoder_input = "11" then  
                    ascii_out <= "01000010";  
                    detect <= '1';      
                    next_state <= reset_state;
                else
                    case mcdecoder_input is
                        when "01" => next_state <= state_6; 
                        when "10" => next_state <= reset_state;  
                        when others => next_state <= idle; 
                    end case;
                end if;
					 
					 
				when state_C =>
                if mcdecoder_input = "11" then  
                    ascii_out <= "01000011";  
                    detect <= '1';      
                    next_state <= reset_state;
                else
                    case mcdecoder_input is
                        when "01" => next_state <= reset_state; 
                        when "10" => next_state <= reset_state;  
                        when others => next_state <= idle; 
                    end case;
                end if;
				
				when state_D =>
                if mcdecoder_input = "11" then  
                    ascii_out <= "01000100";  
                    detect <= '1';      
                    next_state <= reset_state;
                else
                    case mcdecoder_input is
                        when "01" => next_state <= state_B; 
                        when "10" => next_state <= state_X;  
                        when others => next_state <= idle; 
                    end case;
                end if;
					 
					 
            when state_E =>
                if mcdecoder_input = "11" then  
                    ascii_out <= "01000101"; 
                    detect <= '1';      
                    next_state <= reset_state;
                else
                    case mcdecoder_input is
                        when "01" => next_state <= state_I;  
                        when "10" => next_state <= state_A; 
                        when others => next_state <= idle;
                    end case;
                end if;
					 
				
				when state_F =>
                if mcdecoder_input = "11" then  
                    ascii_out <= "01000110";  
                    detect <= '1';      
                    next_state <= reset_state;
                else
                    case mcdecoder_input is
                        when "01" => next_state <= reset_state; 
                        when "10" => next_state <= reset_state;  
                        when others => next_state <= idle; 
                    end case;
                end if;
				
				
				when state_G =>
                if mcdecoder_input = "11" then  
                    ascii_out <= "01000111";  
                    detect <= '1';      
                    next_state <= reset_state;
                else
                    case mcdecoder_input is
                        when "01" => next_state <= state_Z; 
                        when "10" => next_state <= reset_state;  
                        when others => next_state <= idle; 
                    end case;
                end if;	
					 
				when state_H =>
                if mcdecoder_input = "11" then  
                    ascii_out <= "01001000";  
                    detect <= '1';      
                    next_state <= reset_state;
                else
                    case mcdecoder_input is
                        when "01" => next_state <= state_5; 
                        when "10" => next_state <= state_4;  
                        when others => next_state <= idle; 
                    end case;
                end if;
					 
				when state_I =>
                if mcdecoder_input = "11" then  
                    ascii_out <= "01001001";  
                    detect <= '1';      
                    next_state <= reset_state;
                else
                    case mcdecoder_input is
                        when "01" => next_state <= state_S; 
                        when "10" => next_state <= state_U;  
                        when others => next_state <= idle; 
                    end case;
                end if;
					 
					 
				when state_J =>
                if mcdecoder_input = "11" then  
                    ascii_out <= "01001010";  
                    detect <= '1';      
                    next_state <= reset_state;
                else
                    case mcdecoder_input is
                        when "01" => next_state <= reset_state; 
                        when "10" => next_state <= state_1;  
                        when others => next_state <= idle; 
                    end case;
                end if;
					 
					 
				when state_K =>
                if mcdecoder_input = "11" then  
                    ascii_out <= "01001011";  
                    detect <= '1';      
                    next_state <= reset_state;
                else
                    case mcdecoder_input is
                        when "01" => next_state <= state_C; 
                        when "10" => next_state <= state_Y;  
                        when others => next_state <= idle; 
                    end case;
                end if;
					 
					 
				when state_L =>
                if mcdecoder_input = "11" then  
                    ascii_out <= "01001100";  
                    detect <= '1';      
                    next_state <= reset_state;
                else
                    case mcdecoder_input is
                        when "01" => next_state <= reset_state; 
                        when "10" => next_state <= reset_state;  
                        when others => next_state <= idle; 
                    end case;
                end if;
					 
					 
				when state_M =>
                if mcdecoder_input = "11" then  
                    ascii_out <= "01001101";  
                    detect <= '1';      
                    next_state <= reset_state;
                else
                    case mcdecoder_input is
                        when "01" => next_state <= state_G; 
                        when "10" => next_state <= state_O;  
                        when others => next_state <= idle; 
                    end case;
                end if;
					 
					 
				when state_N =>
                if mcdecoder_input = "11" then  
                    ascii_out <= "01001110";  
                    detect <= '1';      
                    next_state <= reset_state;
                else
                    case mcdecoder_input is
                        when "01" => next_state <= state_D; 
                        when "10" => next_state <= state_K;  
                        when others => next_state <= idle; 
                    end case;
                end if;
					 
					 
				when state_O =>
                if mcdecoder_input = "11" then  
                    ascii_out <= "01001111";  
                    detect <= '1';      
                    next_state <= reset_state;
                else
                    case mcdecoder_input is
                        when "01" => next_state <= state_O_Dot; 
                        when "10" => next_state <= state_O_Dash;  
                        when others => next_state <= idle;  
                    end case;
                end if;
					 
				when state_O_Dot =>
                    case mcdecoder_input is
                        when "01" => next_state <= state_8; 
                        when "10" => next_state <= reset_state;  
                        when others => next_state <= idle; 
                    end case;

						  
				when state_O_Dash =>
                    case mcdecoder_input is
                        when "01" => next_state <= state_9; 
                        when "10" => next_state <= state_0;  
                        when others => next_state <= idle;  
                    end case;
				
				when state_P =>
                if mcdecoder_input = "11" then  
                    ascii_out <= "01010000";  
                    detect <= '1';      
                    next_state <= reset_state;
                else
                    case mcdecoder_input is
                        when "01" => next_state <= reset_state; 
                        when "10" => next_state <= reset_state;  
                        when others => next_state <= idle;  
                    end case;
                end if;
				
				
				when state_Q =>
                if mcdecoder_input = "11" then  
                    ascii_out <= "01010001";  
                    detect <= '1';      
                    next_state <= reset_state;
                else
                    case mcdecoder_input is
                        when "01" => next_state <= reset_state; 
                        when "10" => next_state <= reset_state;  
                        when others => next_state <= idle;  
                    end case;
                end if;
		
				when state_R =>
                if mcdecoder_input = "11" then  
                    ascii_out <= "01010010";  
                    detect <= '1';      
                    next_state <= reset_state;
                else
                    case mcdecoder_input is
                        when "01" => next_state <= state_L; 
                        when "10" => next_state <= reset_state;  
                        when others => next_state <= idle;  
                    end case;
                end if;
					 
					 
				when state_S =>
                if mcdecoder_input = "11" then  
                    ascii_out <= "01010011";  
                    detect <= '1';      
                    next_state <= reset_state;
                else
                    case mcdecoder_input is
                        when "01" => next_state <= state_H; 
                        when "10" => next_state <= state_V;  
                        when others => next_state <= idle;  
                    end case;
                end if;
					 
					 
				when state_T =>
                if mcdecoder_input = "11" then  
                    ascii_out <= "01010100";  
                    detect <= '1';      
                    next_state <= reset_state;
                else
                    case mcdecoder_input is
                        when "01" => next_state <= state_N;  
                        when "10" => next_state <= state_M;  
                        when others => next_state <= idle;  
                    end case;
                end if;
					 
					 
				when state_U =>
                if mcdecoder_input = "11" then  
                    ascii_out <= "01010101";  
                    detect <= '1';      
                    next_state <= reset_state;
                else
                    case mcdecoder_input is
                        when "01" => next_state <= state_F; 
                        when "10" => next_state <= state_U_Dash;  
                        when others => next_state <= idle;  
                    end case;
                end if;
					 
					 
					 
				when state_U_Dash =>
                    case mcdecoder_input is
                        when "01" => next_state <= reset_state; 
                        when "10" => next_state <= state_2;  
                        when others => next_state <= idle;  
                    end case;
					 
					 
					 
			   when state_V =>
                if mcdecoder_input = "11" then  
                    ascii_out <= "01010110";  
                    detect <= '1';      
                    next_state <= reset_state;
                else
                    case mcdecoder_input is
                        when "01" => next_state <= reset_state; 
                        when "10" => next_state <= state_3;  
                        when others => next_state <= idle;  
                    end case;
                end if;
					 
					 
				when state_W =>
                if mcdecoder_input = "11" then  
                    ascii_out <= "01010111";  
                    detect <= '1';      
                    next_state <= reset_state;
                else
                    case mcdecoder_input is
                        when "01" => next_state <= state_P; 
                        when "10" => next_state <= state_J;  
                        when others => next_state <= idle;  
                    end case;
                end if;
					 
					 
				when state_X =>
                if mcdecoder_input = "11" then  
                    ascii_out <= "01011000";  
                    detect <= '1';      
                    next_state <= reset_state;
                else
                    case mcdecoder_input is
                        when "01" => next_state <= reset_state; 
                        when "10" => next_state <= reset_state;  
                        when others => next_state <= idle; 
                    end case;
                end if;
					 
					 
			when state_Y =>
                if mcdecoder_input = "11" then  
                    ascii_out <= "01011001";  
                    detect <= '1';      
                    next_state <= reset_state;
                else
                    case mcdecoder_input is
                        when "01" => next_state <= reset_state; 
                        when "10" => next_state <= reset_state;  
                        when others => next_state <= idle;  
                    end case;
                end if;
					 
					 
			when state_Z =>
                if mcdecoder_input = "11" then  
                    ascii_out <= "01011010";  
                    detect <= '1';      
                    next_state <= reset_state;
                else
                    case mcdecoder_input is
                        when "01" => next_state <= state_7; 
                        when "10" => next_state <= reset_state;  
                        when others => next_state <= idle;  
                    end case;
                end if;
					 
					 
			when state_0 =>
                if mcdecoder_input = "11" then  
                    ascii_out <= "00110000";  
                    detect <= '1';      
                    next_state <= reset_state;
                else
                    case mcdecoder_input is
                        when "01" => next_state <= reset_state; 
                        when "10" => next_state <= reset_state;  
                        when others => next_state <= idle;  
                    end case;
                end if;
					 
			when state_1 =>
                if mcdecoder_input = "11" then  
                    ascii_out <= "00110001";  
                    detect <= '1';      
                    next_state <= reset_state;
                else
                    case mcdecoder_input is
                        when "01" => next_state <= reset_state; 
                        when "10" => next_state <= reset_state;  
                        when others => next_state <= idle;  
                    end case;
                end if;
			when state_2 =>
                if mcdecoder_input = "11" then  
                    ascii_out <= "00110010";  
                    detect <= '1';      
                    next_state <= reset_state;
                else
                    case mcdecoder_input is
                        when "01" => next_state <= reset_state; 
                        when "10" => next_state <= reset_state;  
                        when others => next_state <= idle;  
                    end case;
                end if;
					 
		   when state_3 =>
                if mcdecoder_input = "11" then  
                    ascii_out <= "00110011";  
                    detect <= '1';      
                    next_state <= reset_state;
                else
                    case mcdecoder_input is
                        when "01" => next_state <= reset_state; 
                        when "10" => next_state <= reset_state;  
                        when others => next_state <= idle;  
                    end case;
                end if;
					 
			when state_4 =>
                if mcdecoder_input = "11" then  
                    ascii_out <= "00110100";  
                    detect <= '1';      
                    next_state <= reset_state;
                else
                    case mcdecoder_input is
                        when "01" => next_state <= reset_state; 
                        when "10" => next_state <= reset_state;  
                        when others => next_state <= idle;  
                    end case;
                end if;
					 
					 
		   when state_5 =>
                if mcdecoder_input = "11" then  
                    ascii_out <= "00110101";  
                    detect <= '1';      
                    next_state <= reset_state;
                else
                    case mcdecoder_input is
                        when "01" => next_state <= reset_state; 
                        when "10" => next_state <= reset_state;  
                        when others => next_state <= idle;  
                    end case;
                end if;
					 
					 
			when state_6 =>
                if mcdecoder_input = "11" then  
                    ascii_out <= "00110110";  
                    detect <= '1';      
                    next_state <= reset_state;
                else
                    case mcdecoder_input is
                        when "01" => next_state <= reset_state; 
                        when "10" => next_state <= reset_state;  
                        when others => next_state <= idle; 
                    end case;
                end if;
					 
					 
			when state_7 =>
                if mcdecoder_input = "11" then  
                    ascii_out <= "00110111";  
                    detect <= '1';      
                    next_state <= reset_state;
                else
                    case mcdecoder_input is
                        when "01" => next_state <= reset_state; 
                        when "10" => next_state <= reset_state;  
                        when others => next_state <= idle;  
                    end case;
                end if;
					 
					 
			when state_8 =>
                if mcdecoder_input = "11" then  
                    ascii_out <= "00111000";  
                    detect <= '1';      
                    next_state <= reset_state;
                else
                    case mcdecoder_input is
                        when "01" => next_state <= reset_state; 
                        when "10" => next_state <= reset_state;  
                        when others => next_state <= idle;  
                    end case;
                end if;
					 
					 
			when state_9 =>
                if mcdecoder_input = "11" then  
                    ascii_out <= "00111001";  
                    detect <= '1';      
                    next_state <= reset_state;
                else
                    case mcdecoder_input is
                        when "01" => next_state <= reset_state; 
                        when "10" => next_state <= reset_state;  
                        when others => next_state <= idle; 
                    end case;
                end if;

            -- Transitions for other characters...

            when reset_state =>
                -- Transition to idle on next clock edge regardless of input
                next_state <= idle;

            -- ... additional states for other Morse codes ...

            when others =>
                -- In case of an undefined state, go back to idle
					 ascii_out <= "00000000";
        end case;
    end process;

end Behavioral;