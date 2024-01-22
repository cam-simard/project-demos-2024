----------------------------------------------------------------------------------
-- Filename : tristatebuffer.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 31-Oct-2023
-- Design Name: tri_state_buffer_tb
-- Project Name: ECE 410 lab 3 2023
-- Description : testbench for the tri-state buffer file of the simple CPU design
-- Additional Comments:
-- Copyright : University of Alberta, 2023
-- License : CC0 1.0 Universal
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY tri_state_buffer_tb IS
END tri_state_buffer_tb;

ARCHITECTURE sim OF tri_state_buffer_tb IS
    SIGNAL output_enable : STD_LOGIC                     := '0';
    SIGNAL buffer_input  : STD_LOGIC_VECTOR (7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL buffer_output : STD_LOGIC_VECTOR (7 DOWNTO 0);

BEGIN
    tri_state_buffer : ENTITY WORK.tri_state_buffer(Behavioral) PORT MAP(
                                                                 output_enable => output_enable
                                                                , buffer_input => buffer_input
                                                                , buffer_output => buffer_output
                                                                );
    stimulus : PROCESS
    BEGIN
--*************************************************************************************************
-- fix the testbench to properly test the tri-state buffer
        -- Test with output_enable low (should produce high impedance 'Z' output)
        output_enable <= '0';
        buffer_input  <= "10101010";
        WAIT FOR 200 ns;

        -- Assertion to check if output is high impedance state
        ASSERT (buffer_output = "ZZZZZZZZ")
        REPORT "Mismatch in buffer_output value with output_enable low!"
        SEVERITY ERROR;

        -- Test with output_enable high
        output_enable <= '1';
        buffer_input  <= "10101010";
        WAIT FOR 200 ns;

        -- Assertion to check if output is high impedance state
        ASSERT (buffer_output = "10101010")
        REPORT "Mismatch in buffer_output value with output_enable low!"
        SEVERITY ERROR;

        WAIT;
    END PROCESS stimulus;

END sim;
