----------------------------------------------------------------------------------
-- Filename : keypad_register.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 06-Nov-10-2022
-- Design Name: keypad register
-- Module Name: VHDL_essentials
-- Project Name: VHDL_essentials
-- Description : In this file we will implement a simple shift register to store
-- values coming from a keypad or any other 4 bit input
-- Additional Comments: for this design we require a register that can store
-- the last 2 received values and also need a way to prevent multiple updates
-- in succesion, for this we use a flag signal that is raised with every update
-- and it's only lowered after a certain amount of time has passed, this time
-- can be changed by changing the count variable
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD;

ENTITY keypad_register IS
    PORT( clock  : IN STD_LOGIC
        ; key_value  : IN STD_LOGIC_VECTOR(4 DOWNTO 0)  := (OTHERS => '0')
        ; register_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0')
        );
END;

ARCHITECTURE Behavioral OF keypad_register IS
    
    SIGNAL count     : INTEGER := 0;
    SIGNAL flag      : STD_LOGIC:='0';
    SIGNAL clock_div : STD_LOGIC:='0';
    SIGNAL aux       : STD_LOGIC_VECTOR(7 downto 0);
    
BEGIN

    register_div : ENTITY WORK.clock_divider(Behavioral)
        GENERIC MAP (freq_out => 200)
        PORT MAP(clock=>clock
                ,clock_div=>clock_div
                );

    register_out <= aux;

    PROCESS (clock_div)
    BEGIN
    
        IF rising_edge(clock_div) THEN
            -- update event. set count and raise flag
            IF key_value(4) = '0' AND flag = '0' THEN
                aux(7 DOWNTO 4) <= aux(3 DOWNTO 0);
                aux(3 DOWNTO 0) <= key_value(3 DOWNTO 0);
                count           <= 40;
                flag            <= '1';
                -- output locked, a change in the input won't
                -- have effect on the output during this time.
            ELSIF count > 0 THEN
                count <= count - 1;
            ELSIF count = 0 THEN
                flag <= '0';
            END IF;
            
        END IF;
    END PROCESS;
    
END Behavioral;