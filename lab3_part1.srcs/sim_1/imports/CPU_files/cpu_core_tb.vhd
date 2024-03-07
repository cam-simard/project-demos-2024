----------------------------------------------------------------------------------
-- University  : University of Alberta
-- Course      : ECE 410 Advanced Digital Logic Design
-- Project     : Lab 3 Part 4: CPU Test Programs
-- Authors     : Eric Khumbata, Cameron Simard
-- Students ID : 1559320, 1662680
-- Date        : December 1 2023
-- 
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY cpu_core_tb IS
END cpu_core_tb;

ARCHITECTURE behavior OF cpu_core_tb IS

    SIGNAL clock          : STD_LOGIC := '0';
    SIGNAL reset          : STD_LOGIC := '0';
    SIGNAL user_input     : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL OPCODE_output  : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL PC_output      : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL CPU_output     : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL enter          : STD_LOGIC;
    SIGNAL done           : STD_LOGIC;

    -- Clock period definitions
    CONSTANT clock_period : TIME := 8 ns;

BEGIN
    --*********************************
    -- Instantiate the Unit Under Test (UUT)
    UUT : ENTITY WORK.cpu_core(Structural) PORT MAP(clock => clock
                                                    , reset => reset
                                                    , enter => enter
                                                    , user_input => user_input
                                                    , CPU_output => CPU_output
                                                    , PC_output => PC_output
                                                    , OPCODE_output => OPCODE_output
                                                    , done => done);
    -----------------------------------

    -- Clock process definition
    clock_process : PROCESS
    BEGIN
        clock <= '0';
        WAIT FOR clock_period/2;
        clock <= '1';
        WAIT FOR clock_period/2;
    END PROCESS;

    -- Stimulus process
    stim_proc : PROCESS
    BEGIN
        reset <= '1';
        WAIT FOR 10 ns;
        reset <= '0';
        
        --*********************************
        -- provide the required input stimulus here for the design under test
        wait for 16ns;
        enter <= '1';
        wait for 8ns;
        user_input <= "00000001";
        -----------------------------------

        WAIT;
    END PROCESS;

END behavior;
