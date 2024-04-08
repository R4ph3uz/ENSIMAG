library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.PKG.all;

entity CPU_CND is
    generic (
        mutant      : integer := 0
    );
    port (
        rs1         : in w32;
        alu_y       : in w32;
        IR          : in w32;
        slt         : out std_logic;
        jcond       : out std_logic
    );
end entity;

architecture RTL of CPU_CND is
signal a, z, s : std_logic;
signal futur_RS1, futur_alu_Y, resultat : unsigned(32 downto 0);

begin
    -- Valeurs par défaut pour le passage sur carte, à remplacer
    -- jcond <= '0';
    -- slt <= '0';
    a<=(NOT(IR(12)) AND NOT(IR(6))) OR (IR(6) AND NOT(IR(13)));
    futur_RS1 <= rs1(31) & rs1 when a = '1' else '0' & rs1;
    futur_alu_Y<= alu_Y(31) & alu_Y when a = '1' else '0' & alu_Y;
    resultat<=futur_RS1-futur_alu_Y;
    z<='1' when resultat = "0" else '0';
    s<=resultat(32);
    jcond <= ((z XOR IR(12)) AND NOT(IR(14))) OR ((s XOR IR(12)) AND IR(14));
    slt <= s;
end architecture;
