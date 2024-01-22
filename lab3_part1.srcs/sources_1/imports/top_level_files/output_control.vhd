--------------------------------------------------------------------------------
-- Filename : output_control.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 26-Oct-2023
-- Design Name: output_mode
-- Module Name: VHDL_essentials
-- Project Name: VHDL_essentials
-- Description : Design for an output control system to be connected to a CPU
-- it uses the RGB led to indicate what output is being displayed by the SSD
-- this design allows to switch the SSD output to the user input (red)
-- the CPU output (green) or program counter (blue)
-- Copyright : University of Alberta, 2023
-- License : CC0 1.0 Universal
--------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL; -- only neccesary if using the rotate function

ENTITY output_control IS
    PORT( clock         : IN STD_LOGIC
        ; change_output : IN STD_LOGIC
        ; OPCODE_output : IN STD_LOGIC_VECTOR(3 DOWNTO 0)
        ; user_input    : IN STD_LOGIC_VECTOR(7 DOWNTO 0)
        ; CPU_output    : IN STD_LOGIC_VECTOR(7 DOWNTO 0)
        ; PC_output     : IN STD_LOGIC_VECTOR(4 DOWNTO 0)
        ; done          : IN STD_LOGIC
        ; output_state  : OUT STD_LOGIC_VECTOR (2 DOWNTO 0)
        ; OPCODE_leds   : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        ; main_output   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
END output_control;

ARCHITECTURE Behavioral OF output_control IS

    SIGNAL clock_div        : STD_LOGIC;
    SIGNAL halt_div         : STD_LOGIC;
    SIGNAL halt_expanded    : STD_LOGIC_VECTOR(3 downto 0);
    SIGNAL aux              : STD_LOGIC_VECTOR(2 DOWNTO 0) := "100";
    SIGNAL program_counter  : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL done_opcode_leds : STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN
    rgb_div: ENTITY WORK.clock_divider(Behavioral)
        GENERIC MAP (freq_out => 2)
        PORT MAP( clock=>clock
                , clock_div=>clock_div
                );
    done_div: ENTITY WORK.clock_divider(Behavioral)
        GENERIC MAP (freq_out => 4)
        PORT MAP( clock=>clock
                ,clock_div=>halt_div
                );

    output_state <= aux;
    program_counter <= "000"&PC_output;
    halt_expanded <= (others => halt_div);
    done_opcode_leds <= OPCODE_output AND halt_expanded;

    PROCESS (clock_div)
    BEGIN
        IF rising_edge(clock_div) AND change_output = '1'THEN
            aux <= STD_LOGIC_VECTOR(rotate_right(unsigned(aux), 1));
        END IF;
    END PROCESS;

    WITH aux SELECT
        main_output <= user_input WHEN "100",
                       CPU_output WHEN "010",
                 program_counter  WHEN "001",
                  (OTHERS => '0') WHEN OTHERS;

    WITH done SELECT
        OPCODE_leds <= done_opcode_leds WHEN '1',
                          OPCODE_output WHEN OTHERS;
                    
END Behavioral;
