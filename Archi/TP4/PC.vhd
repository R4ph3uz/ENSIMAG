library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity PC is
    port (
        clk  : in std_logic;
        reset: in std_logic;
        start: in std_logic;
        inf  : in std_logic;
        egal : in std_logic;
        getA : out std_logic;
        getB : out std_logic;
        subBA: out std_logic;
        ldA  : out std_logic;
        ldB  : out std_logic;
        done : out std_logic
    );
end PC;

architecture mixte of PC is
  -- Définir ici le nécessaire pour la réalisation de l'automate.
  -- Attention à ne pas utiliser pour les noms des états des mots clés du langage comme
  -- wait, end, init... Par exemple nommer l'état "wait" sWait (comme "state Wait")
  type Etat_type is (sWait, sInit, sTest, sAB, sBA, sEnd);
  signal Etat_courant, Etat_futur : Etat_type;

begin
-- A completer
-- Ici pour la gestion de l'état
Registre : process (clk)
begin
    if rising_edge(clk) then
        if reset='1' then
            Etat_courant <= sWait; -- premier etat
        else
            Etat_courant <= Etat_futur; 
        end if;
    end if;
end process;

-- Ici pour la description des transition (état futur en fonction de l'état courant et des entrées)
-- et pour déterminer les sorties pour chaque état
-- Contrairement au TP précédent, on va regrouper les fonctions de transition et de sortie dans un même process
    Combinatoire : process (
        -- Liste de sensibilité des DEUX fonctions combinatoires (fonction de transition et fonction de sortie)
        Etat_courant, egal, inf,start
        )
    begin
    -- Un processus décrit le comportement séquentiellement. Il est donc possible d'attribuer une valeur par défaut dans la description (par exemple '0') et de changer cette valeur plus loin (avant le end évidemment).
        -- Donnez ici des valeurs par défaut pour les sorties.
        getA<='0';
        getB<='0';
        ldA<='0';
        ldB<='0';
        subBA<='0';
        done<='0';
        
        -- Dans la suite, on ne les précisera que si elles prennent une autre valeur.
        case Etat_courant is	 -- Dans un process, on peut utiliser une structure de type case (mots clés :	'case' et 'is')
        when sWait => -- comprendre : quand Etat_courant vaut A faire ...
            if start = '1' then -- Dans un process, on peut aussi utiliser un if/then/else
                Etat_futur <= sInit;
                getA<='1';
                getB<='1';
                ldA<='1';
                ldB<='1';
            else
                Etat_futur <= sWait;
            end if;
        when sInit =>
        Etat_futur<=sTest;
        getA<='0';
        getB<='0';
        ldA<='0';
        ldB<='0';
        when sTest =>
            if egal = '0' and inf='0' then 
                Etat_futur <= sAB;
                ldA<='1';
            elsif egal='0' and inf='1' then
                ldB<='1';
                subBA<='1';
                Etat_futur <= sBA;
            else
                Etat_futur<=sEnd;
                getA<='0';
                getB<='0';
                ldA<='0';
                ldB<='0';
                subBA<='0';
                done<='1';
            end if;
        when sAB =>
        Etat_futur <= sTest;
        ldA<='0';
        when sBA =>
        Etat_futur <= sTest;
        ldB<='0';
        subBA<='1';
        when sEnd =>
            Etat_futur<=sWait;
            done<='0';
    end case; -- fin de la structur
    end process;
end mixte;
