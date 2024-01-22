----------------------------------------------------------------------------------
-- Company: Department of Electrical and Computer Engineering, University of Alberta
-- Engineer: Shyama Gandhi and Bruce Cockburn
-- Create Date: 10/29/2020 07:18:24 PM
-- Module Name: cpu - structural(inputpath)
-- Description: CPU LAB 3 - ECE 410 (2021)
-- Revision:
-- Revision 0.01 - File Created
-- Revision 1.01 - File Modified by Raju Machupalli (October 31, 2021)
-- Revision 2.01 - File Modified by Shyama Gandhi (November 2, 2021)
-- Revision 3.01 - File Modified by Antonio Andara (October 31, 2023)
-- Additional Comments:
--*********************************************************************************
-- This register_file has 8 locations each of 8-bits. Address lines are used to select from 
-- R[0]:R[7]. A write enable port helps to write to respective location of register.
-- A given instruction will perform either read or write any given time but not both
-- at the same time.
-----------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY register_file IS
    PORT( clock      : IN STD_LOGIC
        ; rf_write   : IN STD_LOGIC
        ; rf_address : IN STD_LOGIC_VECTOR(2 DOWNTO 0) -- addresses 8 locations in the register file
        ; rf_in      : IN STD_LOGIC_VECTOR(7 DOWNTO 0)
        ; rf_out     : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
END register_file;

ARCHITECTURE Behavioral OF register_file IS
    SUBTYPE reg IS STD_LOGIC_VECTOR(7 DOWNTO 0);
    TYPE register_array IS ARRAY(0 TO 7) OF reg;
    SIGNAL RF : register_array; --register file contents

BEGIN
--*************************************************************************************************
-- add the process sensitivity list
-- fix the type mismatch on line 45 and set the input and output appropriately on lines 48 and 51
--*************************************************************************************************
    PROCESS (clock, rf_write, rf_address, rf_in)
        VARIABLE address_index : INTEGER RANGE 0 TO 7; -- Because address go from "000" to "111"

    BEGIN
        address_index := TO_INTEGER(UNSIGNED(rf_address));
        IF rising_edge(clock) THEN
            IF rf_write = '1' THEN -- writing enabled
                RF(address_index) <= rf_in; -- finish this line with the proper assignments
                rf_out            <= (OTHERS => '0');
            ELSE 
                rf_out <= RF(address_index); -- finish this line with the proper assignments
            END IF;
        END IF;

    END PROCESS;
END Behavioral;
