----------------------------------------------------------------------------------
-- Filename : register_file_tb.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 31-Oct-2023
-- Design Name: register_file_tb
-- Project Name: ECE 410 lab 3 2023
-- Description : testbench for the register file of the simple CPU design
-- Additional Comments:
-- Copyright : University of Alberta, 2023
-- License : CC0 1.0 Universal
----------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY register_file_tb IS
END register_file_tb;

ARCHITECTURE sim OF register_file_tb IS
    SIGNAL clock      : STD_LOGIC := '0';
    SIGNAL rf_write   : STD_LOGIC := '0';
    SIGNAL rf_address : STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');
    SIGNAL rf_in      : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL rf_out     : STD_LOGIC_VECTOR(7 DOWNTO 0);

    -- Array to store written values for validation
    TYPE reg_array IS ARRAY (0 TO 7) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL written_vals : reg_array := (OTHERS => (OTHERS => '0'));

BEGIN

    -- Clock process definition
    clock_process: PROCESS
    BEGIN
        clock <= '0';
        WAIT FOR 10 ns;
        clock <= '1';
        WAIT FOR 10 ns;
    END PROCESS;

    --*********************************
    -- Instantiate the Unit Under Test (UUT)
    uut: ENTITY WORK.register_file(Behavioral)
        PORT MAP(
                  clock => clock
                , rf_write => rf_write
                , rf_address => rf_address
                , rf_in => rf_in
                , rf_out => rf_out
                );
    -----------------------------------

    stim_proc: PROCESS
    BEGIN
        -- Write to all registers
        FOR i IN 0 TO 7 LOOP
            rf_address <= STD_LOGIC_VECTOR(TO_UNSIGNED(i, rf_address'LENGTH));
            rf_in      <= STD_LOGIC_VECTOR(TO_UNSIGNED(i, rf_in'LENGTH)); -- Example values
            rf_write   <= '1';
            WAIT FOR 20 ns;
            -- Store the written value for later verification
            written_vals(i) <= rf_in;
        END LOOP;
        
        rf_write <= '0';
        
        -- Read from all registers and assert
        FOR i IN 0 TO 7 LOOP
            rf_address <= STD_LOGIC_VECTOR(TO_UNSIGNED(i, rf_address'LENGTH));
            WAIT FOR 20 ns;
            -- Assertion to check if output matches written data
            ASSERT (rf_out = written_vals(i))
            REPORT "Mismatch for rf_address = " & INTEGER'IMAGE(i) & "!"
            SEVERITY ERROR;
        END LOOP;
        WAIT;
    END PROCESS stim_proc;

END sim;
