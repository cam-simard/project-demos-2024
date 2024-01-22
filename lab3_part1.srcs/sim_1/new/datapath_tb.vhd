----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/01/2023 08:00:43 AM
-- Design Name: 
-- Module Name: datapath_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity datapath_tb is
--  Port ( );
end datapath_tb;

architecture Behavioral of datapath_tb is
    SIGNAL clock          : STD_LOGIC := '0';
    SIGNAL reset          : STD_LOGIC := '0';
    SIGNAL mux_sel        : STD_LOGIC_VECTOR (1 downto 0):= "00";
    SIGNAL immediate_data : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
    SIGNAL user_input     : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
    SIGNAL acc_write      : STD_LOGIC := '0';
    SIGNAL rf_address     : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
    SIGNAL rf_write       : STD_LOGIC := '0';
    SIGNAL alu_sel        : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
    SIGNAL bits_rotate    : STD_LOGIC_VECTOR (1 DOWNTO 0) := "00";
    SIGNAL output_enable  : STD_LOGIC := '0';
    SIGNAL zero_flag      : STD_LOGIC := '0';
    SIGNAL positive_flag  : STD_LOGIC := '0';
    SIGNAL datapath_out   : STD_LOGIC_VECTOR (7 DOWNTO 0) := "00000000";
    
begin
    DUT: ENTITY work.datapath(Structural) PORT MAP(clock => clock
                                                 , reset => reset
                                                 , mux_sel => mux_sel
                                                 , immediate_data => immediate_data
                                                 , user_input => user_input
                                                 , acc_write => acc_write
                                                 , rf_address => rf_address
                                                 , rf_write => rf_write
                                                 , alu_sel => alu_sel
                                                 , bits_rotate => bits_rotate
                                                 , output_enable => output_enable
                                                 , zero_flag => zero_flag
                                                 , positive_flag => positive_flag
                                                 , datapath_out => datapath_out
                                                 );
                                                 
    -- Stimulus process
    stim_proc : PROCESS
    BEGIN
        -- write to register file
        WAIT FOR 8ns;
        reset <= '1';
        clock <= '1';
        WAIT FOR 8ns;
        clock <= '0';
        WAIT FOR 8ns;
        
        reset <= '0';
        mux_sel <= "11";
        user_input <= "00001010";
        acc_write <= '1';
        
        clock <= '1';
        WAIT FOR 8ns;
        clock <= '0';
        WAIT FOR 8ns;
        
        rf_write  <= '1';
        rf_address <= "101";
        
        clock <= '1';
        WAIT FOR 8ns;
        clock <= '0';
        WAIT FOR 8ns;
        
        clock <= '1';
        WAIT FOR 8ns;
        clock <= '0';
        WAIT FOR 8ns;
        
        
        
        -- load another value into accumulator
        rf_write <= '0';
        user_input <= "00110000";
        
        clock <= '1';
        WAIT FOR 8ns;
        clock <= '0';
        WAIT FOR 8ns;
        
        -- add accumulator and value in register file
        mux_sel <= "00";
        alu_sel <= "100";
        
        clock <= '1';
        WAIT FOR 8ns;
        clock <= '0';
        WAIT FOR 8ns;
        
        alu_sel <= "000";
        
        clock <= '1';
        WAIT FOR 8ns;
        clock <= '0';
        WAIT FOR 8ns;
        
        -- output result
        output_enable <= '1';
        
        clock <= '1';
        WAIT FOR 8ns;
        clock <= '0';
        WAIT FOR 8ns;
        clock <= '1';
        WAIT FOR 8ns;
        clock <= '0';
        WAIT FOR 8ns;
        
        WAIT;
    END PROCESS;
                                              


end Behavioral;
