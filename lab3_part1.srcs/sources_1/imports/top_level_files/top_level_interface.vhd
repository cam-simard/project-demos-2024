----------------------------------------------------------------------------------
-- Filename : top_level_interface.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 26-Oct-2023
-- Design Name: CPU_interface
-- Module Name: VHDL_essentials
-- Project Name: VHDL_essentials
-- Description : In this file we will implement an interface model to interact
-- lab's 3 CPU model, it contains a shift register that takes values from the
-- with keypad as input as well as a way to change the output diplayed by the
-- seven segment display
-- Copyright : University of Alberta, 2023
-- License : CC0 1.0 Universal
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY cpu_interface IS
    PORT( clock          : IN STD_LOGIC
        ; enter          : IN STD_LOGIC
        ; reset          : IN STD_LOGIC
        ; change_output  : IN STD_LOGIC
        ; output_state   : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
        ; OPCODE_leds    : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        ; row            : IN STD_LOGIC_VECTOR(3 DOWNTO 0)
        ; column         : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        ; display_select : OUT STD_LOGIC
        ; segments       : OUT STD_LOGIC_VECTOR (6 DOWNTO 0)
        );
END cpu_interface;

ARCHITECTURE Structural OF cpu_interface IS

    SIGNAL done          : STD_LOGIC;
    SIGNAL pressed_key   : STD_LOGIC_VECTOR (4 DOWNTO 0);
    SIGNAL digits        : STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL user_input    : STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL CPU_output    : STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL PC_output     : STD_LOGIC_VECTOR (4 DOWNTO 0);
    SIGNAL OPCODE_output : STD_LOGIC_VECTOR (3 DOWNTO 0);

BEGIN

    cpu_core: ENTITY WORK.cpu_core(Structural)
        PORT MAP ( clock         => clock
                 , reset         => reset
                 , enter         => enter
                 , user_input    => user_input
                 , CPU_output    => CPU_OUTPUT
                 , PC_output     => PC_OUTPUT
                 , OPCODE_output => OPCODE_OUTPUT
                 , done          => done
                 );

    SSD_driver: ENTITY WORK.display_controller(Behavioral)
        PORT MAP( digits=>digits
                , clock=>clock
                , display_select=>display_select
                , segments=>segments
                );

    keypad_decoder: ENTITY WORK.keypad_decoder(Behavioral)
        PORT MAP( clock=>clock
                , row=>row
                , column=>column
                , pressed_key=>pressed_key
                );

    keypad_register: ENTITY WORK.keypad_register(Behavioral)
        PORT MAP( key_value=>pressed_key
                , clock=>clock
                , register_out=>user_input
                );

    output_control: ENTITY WORK.output_control(Behavioral)
        PORT MAP( clock=>clock
                , change_output=>change_output
                , output_state=>output_state
                , OPCODE_output=>OPCODE_output
                , user_input=>user_input
                , CPU_output=>CPU_output
                , PC_output=>PC_output
                , done=>done
                , OPCODE_leds=>OPCODE_leds
                , main_output=>digits
                ); 

END;
