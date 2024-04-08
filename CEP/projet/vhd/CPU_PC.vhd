library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.PKG.all;


entity CPU_PC is
    generic(
        mutant: integer := 0
    );
    Port (
        -- Clock/Reset
        clk    : in  std_logic ;
        rst    : in  std_logic ;

        -- Interface PC to PO
        cmd    : out PO_cmd ;
        status : in  PO_status
    );
end entity;

architecture RTL of CPU_PC is
    type State_type is (
        S_Error,
        S_Init,
        S_Pre_Fetch,
        S_Fetch,
        S_Decode,
        S_LUI,
        S_ADDI,
        S_ADD,
        S_SUB,
        S_AND,
        S_ANDI,
        S_OR,
        S_ORI,
        S_XOR,
        S_XORI,
        S_SLL,
        S_SRL,
        S_SRA,
        S_AUIPC,
        S_SRLI,
        S_SLLI,
        S_SRAI,
        S_BEQ,
        S_BGE,
        S_BGEU,
        S_BLT,
        S_BLTU,
        S_BNE,
        S_SLT,
        S_SLTI,
        S_SLTU,
        S_SLTIU,
        S_LW,
        S_LW2,
        S_LW3,
        S_LB,
        S_LB2,
        S_LB3,
        S_LBU,
        S_LBU2,
        S_LBU3,
        S_LH,
        S_LH2,
        S_LH3,
        S_LHU,
        S_LHU2,
        S_LHU3,
        S_JAL,
        S_JALR,
        S_SW,
        S_SW2,
        S_SH,
        S_SH2,
        S_SB,
        S_SB2
    );

    signal state_d, state_q : State_type;


begin

    FSM_synchrone : process(clk)
    begin
        if clk'event and clk='1' then
            if rst='1' then
                state_q <= S_Init;
            else
                state_q <= state_d;
            end if;
        end if;
    end process FSM_synchrone;

    FSM_comb : process (state_q, status)
    begin

        -- Valeurs par défaut de cmd à définir selon les préférences de chacun
        cmd.ALU_op            <= ALU_plus;
        cmd.LOGICAL_op        <= LOGICAL_and;
        cmd.ALU_Y_sel         <= ALU_Y_rf_rs2;

        cmd.SHIFTER_op        <= SHIFT_rl;
        cmd.SHIFTER_Y_sel     <= SHIFTER_Y_rs2;

        cmd.RF_we             <= '0';
        cmd.RF_SIZE_sel       <= RF_SIZE_word;
        cmd.RF_SIGN_enable    <= '0';
        cmd.DATA_sel          <= DATA_from_alu;

        cmd.PC_we             <= '0';
        cmd.PC_sel            <= PC_from_alu;

        cmd.PC_X_sel          <= PC_X_cst_x00;
        cmd.PC_Y_sel          <= PC_Y_cst_x04;

        cmd.TO_PC_Y_sel       <= TO_PC_Y_cst_x04;

        cmd.AD_we             <= '0';
        cmd.AD_Y_sel          <= AD_Y_immI;

        cmd.IR_we             <= '0';

        cmd.ADDR_sel          <= ADDR_from_pc;
        cmd.mem_we            <= '0';
        cmd.mem_ce            <= '0';

        cmd.cs.CSR_we            <= CSR_none;

        cmd.cs.TO_CSR_sel        <= TO_CSR_from_rs1;
        cmd.cs.CSR_sel           <= CSR_from_mcause;
        cmd.cs.MEPC_sel          <= MEPC_from_pc;

        cmd.cs.MSTATUS_mie_set   <= '0';
        cmd.cs.MSTATUS_mie_reset <= '0';

        cmd.cs.CSR_WRITE_mode    <= WRITE_mode_simple;

        state_d <= state_q;

        case state_q is
            when S_Error =>
                -- Etat transitoire en cas d'instruction non reconnue 
                -- Aucune action
                state_d <= S_Init;
            when S_Init =>
                -- PC <- RESET_VECTOR
                cmd.PC_we <= '1';
                cmd.PC_sel <= PC_rstvec;
                state_d <= S_Pre_Fetch;

            when S_Pre_Fetch =>
                -- mem[PC]
                cmd.mem_we   <= '0';
                cmd.mem_ce   <= '1';
                cmd.ADDR_sel <= ADDR_from_pc;
                state_d      <= S_Fetch;

            when S_Fetch =>
                -- IR <- mem_datain
                cmd.IR_we <= '1';
                state_d <= S_Decode;

            when S_Decode =>
                if status.IR(6 downto 0) = "0110111" then --si on entre dans Lui
                    state_d <= S_LUI; -- changement d'etat 
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04; -- selection de PC +4
                    cmd.PC_sel <= PC_from_pc;  -- PC+4
                    cmd.PC_we <= '1'; -- droit d'ecriture à 1
                elsif (status.IR(6 downto 0)= "0010011") and (status.IR(14 downto 12)="000") then -- on rentre dans ADDI
                    state_d <= S_ADDI; -- changement d'etat 
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04; -- selection de PC +4
                    cmd.PC_sel <= PC_from_pc;  -- PC+4
                    cmd.PC_we <= '1'; -- droit d'ecriture à 1
                elsif (status.IR(6 downto 0)= "0110011") and (status.IR(31 downto 25)="0000000") and (status.IR(14 downto 12)="000") then 
                -- on rentre dans ADD
                    state_d <= S_ADD; -- changement d'etat 
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04; -- selection de PC +4
                    cmd.PC_sel <= PC_from_pc;  -- PC+4
                    cmd.PC_we <= '1'; -- droit d'ecriture à 1
                elsif status.IR(6 downto 0)= "0110011" and (status.IR(31 downto 25)="0100000") and (status.IR(14 downto 12)="000")then 
                -- on rentre dans SUB
                    state_d <= S_SUB; -- changement d'etat 
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04; -- selection de PC +4
                    cmd.PC_sel <= PC_from_pc;  -- PC+4
                    cmd.PC_we <= '1'; -- droit d'ecriture à 1
                elsif status.IR(6 downto 0)= "0110011" and (status.IR(31 downto 25)="0000000") and (status.IR(14 downto 12)="111")then 
                -- on rentre dans AND
                    state_d <= S_AND; -- changement d'etat 
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04; -- selection de PC +4
                    cmd.PC_sel <= PC_from_pc;  -- PC+4
                    cmd.PC_we <= '1'; -- droit d'ecriture à 1
                elsif status.IR(6 downto 0)= "0010011" and (status.IR(14 downto 12)="111")then 
                -- on rentre dans ANDI
                    state_d <= S_ANDI; -- changement d'etat 
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04; -- selection de PC +4
                    cmd.PC_sel <= PC_from_pc;  -- PC+4
                    cmd.PC_we <= '1'; -- droit d'ecriture à 1
                elsif status.IR(6 downto 0)= "0110011" and (status.IR(31 downto 25)="0000000") and (status.IR(14 downto 12)="110")then 
                -- on rentre dans OR
                    state_d <= S_OR; -- changement d'etat 
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04; -- selection de PC +4
                    cmd.PC_sel <= PC_from_pc;  -- PC+4
                    cmd.PC_we <= '1'; -- droit d'ecriture à 1
                elsif status.IR(6 downto 0)= "0010011" and (status.IR(14 downto 12)="110")then 
                -- on rentre dans ORI
                    state_d <= S_ORI; -- changement d'etat 
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04; -- selection de PC +4
                    cmd.PC_sel <= PC_from_pc;  -- PC+4
                    cmd.PC_we <= '1'; -- droit d'ecriture à 1
                elsif status.IR(6 downto 0)= "0110011" and (status.IR(31 downto 25)="0000000") and (status.IR(14 downto 12)="100")then 
                -- on rentre dans XOR
                    state_d <= S_XOR; -- changement d'etat 
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04; -- selection de PC +4
                    cmd.PC_sel <= PC_from_pc;  -- PC+4
                    cmd.PC_we <= '1'; -- droit d'ecriture à 1
                elsif status.IR(6 downto 0)= "0010011" and (status.IR(14 downto 12)="100")then 
                -- on rentre dans XORI
                    state_d <= S_XORI; -- changement d'etat 
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04; -- selection de PC +4
                    cmd.PC_sel <= PC_from_pc;  -- PC+4
                    cmd.PC_we <= '1'; -- droit d'ecriture à 1
                elsif (status.IR(6 downto 0)= "0110011") and (status.IR(31 downto 25)="0000000") and (status.IR(14 downto 12)="001") then 
                -- on rentre dans SLL
                    state_d <= S_SLL; -- changement d'etat 
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04; -- selection de PC +4
                    cmd.PC_sel <= PC_from_pc;  -- PC+4
                    cmd.PC_we <= '1'; -- droit d'ecriture à 1
                elsif (status.IR(6 downto 0)= "0110011") and (status.IR(31 downto 25)="0000000") and (status.IR(14 downto 12)="101") then 
                -- on rentre dans SRL
                    state_d <= S_SRL; -- changement d'etat 
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04; -- selection de PC +4
                    cmd.PC_sel <= PC_from_pc;  -- PC+4
                    cmd.PC_we <= '1'; -- droit d'ecriture à 1
                elsif (status.IR(6 downto 0)= "0110011") and (status.IR(31 downto 25)="0100000") and (status.IR(14 downto 12)="101") then 
                -- on rentre dans SRA
                    state_d <= S_SRA; -- changement d'etat 
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04; -- selection de PC +4
                    cmd.PC_sel <= PC_from_pc;  -- PC+4
                    cmd.PC_we <= '1'; -- droit d'ecriture à 1
                elsif (status.IR(6 downto 0)= "0010111") then 
                -- on rentre dans AUIPC
                    state_d <= S_AUIPC; -- changement d'etat 
                elsif (status.IR(6 downto 0)= "0010011") and (status.IR(31 downto 25)="0100000") and (status.IR(14 downto 12)="101") then 
                -- on rentre dans SRAI
                    state_d <= S_SRAI; -- changement d'etat 
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04; -- selection de PC +4
                    cmd.PC_sel <= PC_from_pc;  -- PC+4
                    cmd.PC_we <= '1'; -- droit d'ecriture à 1
                elsif (status.IR(6 downto 0)= "0010011") and (status.IR(31 downto 25)="0000000") and (status.IR(14 downto 12)="001")then 
                -- on rentre dans SLLI
                    state_d <= S_SLLI; -- changement d'etat 
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04; -- selection de PC +4
                    cmd.PC_sel <= PC_from_pc;  -- PC+4
                    cmd.PC_we <= '1'; -- droit d'ecriture à 1
                elsif (status.IR(6 downto 0)= "0010011") and (status.IR(31 downto 25)="0000000") and (status.IR(14 downto 12)="101")then 
                    -- on rentre dans SRLI
                    state_d <= S_SRLI; -- changement d'etat 
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04; -- selection de PC +4
                    cmd.PC_sel <= PC_from_pc;  -- PC+4
                    cmd.PC_we <= '1'; -- droit d'ecriture à 1
                elsif (status.IR(6 downto 0)= "0000011") and (status.IR(14 downto 12)="010")then
                    -- on rentre dans LW
                    state_d <= S_LW; -- changement d'etat 
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04; -- selection de PC +4
                    cmd.PC_sel <= PC_from_pc;  -- PC+4
                    cmd.PC_we <= '1'; -- droit d'ecriture à 1
                elsif (status.IR(6 downto 0)= "0000011") and (status.IR(14 downto 12)="000")then
                    -- on rentre dans LB
                    state_d <= S_LB; -- changement d'etat 
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04; -- selection de PC +4
                    cmd.PC_sel <= PC_from_pc;  -- PC+4
                    cmd.PC_we <= '1'; -- droit d'ecriture à 1
                elsif (status.IR(6 downto 0)= "0000011") and (status.IR(14 downto 12)="100")then
                    -- on rentre dans LBU
                    state_d <= S_LBU; -- changement d'etat 
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04; -- selection de PC +4
                    cmd.PC_sel <= PC_from_pc;  -- PC+4
                    cmd.PC_we <= '1'; -- droit d'ecriture à 1
                elsif (status.IR(6 downto 0)= "0000011") and (status.IR(14 downto 12)="001")then
                    -- on rentre dans LH
                    state_d <= S_LH; -- changement d'etat 
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04; -- selection de PC +4
                    cmd.PC_sel <= PC_from_pc;  -- PC+4
                    cmd.PC_we <= '1'; -- droit d'ecriture à 1
                elsif (status.IR(6 downto 0)= "0000011") and (status.IR(14 downto 12)="101")then
                    -- on rentre dans LHU
                    state_d <= S_LHU; -- changement d'etat 
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04; -- selection de PC +4
                    cmd.PC_sel <= PC_from_pc;  -- PC+4
                    cmd.PC_we <= '1'; -- droit d'ecriture à 1
                elsif (status.IR(6 downto 0)= "1100011") and (status.IR(14 downto 12)="000")then 
                    -- on rentre dans BEQ
                    state_d <= S_BEQ; -- changement d'etat 
                elsif (status.IR(6 downto 0)= "1100011") and (status.IR(14 downto 12)="101")then 
                    -- on rentre dans BGE
                    state_d <= S_BGE; -- changement d'etat
                elsif (status.IR(6 downto 0)= "1100011") and (status.IR(14 downto 12)="111")then 
                    -- on rentre dans BGEU
                    state_d <= S_BGEU; -- changement d'etat
                elsif (status.IR(6 downto 0)= "1100011") and (status.IR(14 downto 12)="100")then 
                    -- on rentre dans BGEU
                    state_d <= S_BLT; -- changement d'etat
                elsif (status.IR(6 downto 0)= "1100011") and (status.IR(14 downto 12)="110")then 
                    -- on rentre dans BGEU
                    state_d <= S_BLTU; -- changement d'etat
                elsif (status.IR(6 downto 0)= "1100011") and (status.IR(14 downto 12)="001")then 
                    -- on rentre dans BEQ
                    state_d <= S_BNE; -- changement d'etat  
                elsif (status.IR(31 downto 25)="0000000") and (status.IR(14 downto 12)="010") and (status.IR(6 downto 0) ="0110011") then
                    state_d <= S_SLT; -- changement d'etat 
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04; -- selection de PC +4
                    cmd.PC_sel <= PC_from_pc;  -- PC+4
                    cmd.PC_we <= '1'; -- droit d'ecriture à 1
                elsif (status.IR(14 downto 12)="010") and (status.IR(6 downto 0) ="0010011") then
                    state_d <= S_SLTI; -- changement d'etat 
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04; -- selection de PC +4
                    cmd.PC_sel <= PC_from_pc;  -- PC+4
                    cmd.PC_we <= '1'; -- droit d'ecriture à 1
                elsif (status.IR(31 downto 25)="0000000") and (status.IR(14 downto 12)="011") and (status.IR(6 downto 0) ="0110011") then
                    state_d <= S_SLTU; -- changement d'etat 
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04; -- selection de PC +4
                    cmd.PC_sel <= PC_from_pc;  -- PC+4
                    cmd.PC_we <= '1'; -- droit d'ecriture à 1
                elsif (status.IR(14 downto 12)="011") and (status.IR(6 downto 0) ="0010011") then
                    state_d <= S_SLTIU; -- changement d'etat 
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04; -- selection de PC +4
                    cmd.PC_sel <= PC_from_pc;  -- PC+4
                    cmd.PC_we <= '1'; -- droit d'ecriture à 1
                elsif status.IR(6 downto 0)="1101111" then
                    state_d <= S_JAL; -- changement d'etat 
                elsif status.IR(6 downto 0)="1100111" then
                    state_d <= S_JALR; -- changement d'etat
                elsif (status.IR(6 downto 0) = "0100011")and (status.IR(14 downto 12)="010") then
                    state_d <= S_SW;
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';
                elsif (status.IR(6 downto 0) = "0100011")and (status.IR(14 downto 12)="000") then
                    state_d <= S_SB;
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';
                elsif (status.IR(6 downto 0) = "0100011")and (status.IR(14 downto 12)="001") then
                    state_d <= S_SH;
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';
                else
                    state_d <= S_Error; -- Pour d´etecter les rat´es du d´ecodage

                end if;
                -- Décodage effectif des instructions,
                -- à compléter par vos soins

---------- Instructions avec immediat de type U ----------
            when S_LUI =>
                -- rd <- ImmU + 0
                cmd.PC_X_sel <= PC_X_cst_x00; -- on va mettre 0 dans X
                cmd.PC_Y_sel <= PC_Y_immU; -- valeur de la constante 
                cmd.RF_we <= '1'; --pour stocker la cte
                cmd.DATA_sel <= DATA_from_pc; -- cte venue de la pc pour etre stockee
                -- passage autre etat
                state_d <= S_Pre_Fetch; -- on retourne pour decoder le prochain etat
            when S_AUIPC =>
                -- pc <- ImmU + PC
                cmd.PC_X_sel <= PC_X_pc; -- on va mettre 0 dans X
                cmd.PC_Y_sel <= PC_Y_immU; -- valeur de la constante 
                cmd.RF_we <= '1'; --pour stocker la cte
                cmd.DATA_sel <= DATA_from_pc; -- cte venue de la pc pour etre stockee
                
                -- code <o>
                cmd.TO_PC_Y_sel<=TO_PC_Y_cst_x04; -- pc +4
                cmd.PC_sel<=PC_from_pc;
                cmd.PC_we<='1';
                
                -- next state
                state_d <= S_Pre_Fetch; -- on retourne pour decoder le prochain etat
---------- Instructions arithmétiques et logiques ----------
            when S_ADDI =>
                cmd.RF_we<='1'; -- pour pouvoir ecrire l'addition
                cmd.DATA_sel <= DATA_from_alu; -- recupere la constante calculee et la stocke
                cmd.ALU_Y_sel<=ALU_Y_immI; -- recupere la cte
                cmd.ALU_op<=ALU_plus; -- choix du plus pour l'alu
                -- next state
                state_d <= S_Pre_Fetch; -- on retourne pour decoder le prochain etat
            when S_ADD =>
                cmd.RF_we<='1'; -- pour pouvoir ecrire l'addition
                cmd.DATA_sel <= DATA_from_alu; -- recupere la constante calculee et la stocke
                cmd.ALU_Y_sel<=ALU_Y_rf_rs2; -- recupere la cte
                cmd.ALU_op<=ALU_plus; -- choix du plus pour l'alu
                -- passage autre etat
                state_d <= S_Pre_Fetch; -- on retourne pour decoder le prochain etat
            when S_SUB =>
                cmd.RF_we<='1'; -- pour pouvoir ecrire l'addition
                cmd.DATA_sel <= DATA_from_alu; -- recupere la constante calculee et la stocke
                cmd.ALU_Y_sel<=ALU_Y_rf_rs2; -- recupere la cte
                cmd.ALU_op<=ALU_minus; -- choix du plus pour l'alu
                -- passage autre etat
                state_d <= S_Pre_Fetch; -- on retourne pour decoder le prochain etat
            when S_AND =>
                cmd.RF_we<='1'; -- pour pouvoir ecrire l'addition
                cmd.DATA_sel<=DATA_from_logical; -- recupere la cte
                cmd.ALU_Y_sel<=ALU_Y_rf_rs2; -- recupere la cte
                cmd.LOGICAL_op<=LOGICAL_and; -- choix du plus pour l'alu
                -- passage autre etat
                state_d <= S_Pre_Fetch; -- on retourne pour decoder le prochain etat
            when S_OR =>
                cmd.RF_we<='1'; -- pour pouvoir ecrire l'addition
                cmd.DATA_sel <= DATA_from_logical; -- recupere la constante calculee et la stocke
                cmd.ALU_Y_sel<=ALU_Y_rf_rs2; -- recupere la cte
                cmd.LOGICAL_op<=LOGICAL_or; -- choix du plus pour l'alu
                -- passage autre etat
                state_d <= S_Pre_Fetch; -- on retourne pour decoder le prochain etat
            when S_XOR =>
                cmd.RF_we<='1'; -- pour pouvoir ecrire l'addition
                cmd.DATA_sel <= DATA_from_logical; -- recupere la constante calculee et la stocke
                cmd.ALU_Y_sel<=ALU_Y_rf_rs2; -- recupere la cte
                cmd.LOGICAL_op<=LOGICAL_xor; -- choix du plus pour l'alu
                -- passage autre etat
                state_d <= S_Pre_Fetch; -- on retourne pour decoder le prochain etat
            when S_ANDI =>
                cmd.RF_we<='1'; -- pour pouvoir ecrire l'addition
                cmd.DATA_sel<=DATA_from_logical; -- recupere la cte
                cmd.ALU_Y_sel<=ALU_Y_immI; -- recupere la cte
                cmd.LOGICAL_op<=LOGICAL_and; -- choix du plus pour l'alu
                -- passage autre etat
                state_d <= S_Pre_Fetch; -- on retourne pour decoder le prochain etat
            when S_ORI =>
                cmd.RF_we<='1'; -- pour pouvoir ecrire l'addition
                cmd.DATA_sel <= DATA_from_logical; -- recupere la constante calculee et la stocke
                cmd.ALU_Y_sel<=ALU_Y_immI; -- recupere la cte
                cmd.LOGICAL_op<=LOGICAL_or; -- choix du plus pour l'alu
                -- passage autre etat
                state_d <= S_Pre_Fetch; -- on retourne pour decoder le prochain etat
            when S_XORI =>
                cmd.RF_we<='1'; -- pour pouvoir ecrire l'addition
                cmd.DATA_sel <= DATA_from_logical; -- recupere la constante calculee et la stocke
                cmd.ALU_Y_sel<=ALU_Y_immI; -- recupere la cte
                cmd.LOGICAL_op<=LOGICAL_xor; -- choix du plus pour l'alu
                -- passage autre etat
                state_d <= S_Pre_Fetch; -- on retourne pour decoder le prochain etat
            when S_SLL =>
                cmd.RF_we<='1'; -- pour pouvoir ecrire la sortie
                cmd.DATA_sel <= DATA_from_shifter; -- recupere la constante calculee et la stocke
                cmd.SHIFTER_Y_sel<=SHIFTER_Y_rs2; -- choix du plus pour l'alu
                cmd.SHIFTER_op<=SHIFT_ll;
                -- passage autre etat
                state_d <= S_Pre_Fetch; -- on retourne pour decoder le prochain etat
            when S_SRL =>
                cmd.RF_we<='1'; -- pour pouvoir ecrire la sortie
                cmd.DATA_sel <= DATA_from_shifter; -- recupere la constante calculee et la stocke
                cmd.SHIFTER_Y_sel<=SHIFTER_Y_rs2; -- choix du plus pour l'alu
                cmd.SHIFTER_op<=SHIFT_rl;
                -- passage autre etat
                state_d <= S_Pre_Fetch; -- on retourne pour decoder le prochain etat
            when S_SRA =>
                cmd.RF_we<='1'; -- pour pouvoir ecrire la sortie
                cmd.DATA_sel <= DATA_from_shifter; -- recupere la constante calculee et la stocke
                cmd.SHIFTER_Y_sel<=SHIFTER_Y_rs2; -- choix du plus pour l'alu
                cmd.SHIFTER_op<=SHIFT_ra;
                -- passage autre etat
                state_d <= S_Pre_Fetch; -- on retourne pour decoder le prochain etat
            when S_SLLI =>
                cmd.RF_we<='1'; -- pour pouvoir ecrire la sortie
                cmd.DATA_sel <= DATA_from_shifter; -- recupere la constante calculee et la stocke
                cmd.SHIFTER_Y_sel<=SHIFTER_Y_ir_sh; -- choix du plus pour l'alu
                cmd.SHIFTER_op<=SHIFT_ll;
                -- passage autre etat
                state_d <= S_Pre_Fetch; -- on retourne pour decoder le prochain etat
            when S_SRLI =>
                cmd.RF_we<='1'; -- pour pouvoir ecrire la sortie
                cmd.DATA_sel <= DATA_from_shifter; -- recupere la constante calculee et la stocke
                cmd.SHIFTER_Y_sel<=SHIFTER_Y_ir_sh; -- choix du plus pour l'alu
                cmd.SHIFTER_op<=SHIFT_rl;
                -- passage autre etat
                state_d <= S_Pre_Fetch; -- on retourne pour decoder le prochain etat
            when S_SRAI =>
                cmd.RF_we<='1'; -- pour pouvoir ecrire la sortie
                cmd.DATA_sel <= DATA_from_shifter; -- recupere la constante calculee et la stocke
                cmd.SHIFTER_Y_sel<=SHIFTER_Y_ir_sh; -- choix du plus pour l'alu
                cmd.SHIFTER_op<=SHIFT_ra;
                -- passage autre etat
                state_d <= S_Pre_Fetch; -- on retourne pour decoder le prochain etat

---------- Instructions de saut ----------
            when S_BEQ =>
                cmd.ALU_Y_sel<=ALU_Y_rf_rs2;
                if status.JCOND then 
                    cmd.TO_PC_Y_sel<=TO_PC_Y_immB;
                    cmd.PC_sel<=PC_from_pc;
                    cmd.PC_we<='1';
                else
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04; -- selection de PC +4
                    cmd.PC_sel <= PC_from_pc;  -- PC+4
                    cmd.PC_we <= '1';
                end if;
                -- passage autre etat
                state_d <= S_Pre_Fetch; -- on retourne pour decoder le prochain etat
            when S_BGE =>
                cmd.ALU_Y_sel<=ALU_Y_rf_rs2;
                if status.JCOND then 
                    cmd.TO_PC_Y_sel<=TO_PC_Y_immB;
                    cmd.PC_sel<=PC_from_pc;
                    cmd.PC_we<='1';
                else
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04; -- selection de PC +4
                    cmd.PC_sel <= PC_from_pc;  -- PC+4
                    cmd.PC_we <= '1';
                end if;
                -- passage autre etat
                state_d <= S_Pre_Fetch; -- on retourne pour decoder le prochain etat
            when S_BGEU =>
                cmd.ALU_Y_sel<=ALU_Y_rf_rs2;
                if status.JCOND then 
                    cmd.TO_PC_Y_sel<=TO_PC_Y_immB;
                    cmd.PC_sel<=PC_from_pc;
                    cmd.PC_we<='1';
                else
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04; -- selection de PC +4
                    cmd.PC_sel <= PC_from_pc;  -- PC+4
                    cmd.PC_we <= '1';
                end if;
                -- passage autre etat
                state_d <= S_Pre_Fetch; -- on retourne pour decoder le prochain etat
            when S_BLT =>
                cmd.ALU_Y_sel<=ALU_Y_rf_rs2;
                if status.JCOND then 
                    cmd.TO_PC_Y_sel<=TO_PC_Y_immB;
                    cmd.PC_sel<=PC_from_pc;
                    cmd.PC_we<='1';
                else
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04; -- selection de PC +4
                    cmd.PC_sel <= PC_from_pc;  -- PC+4
                    cmd.PC_we <= '1';
                end if;
                -- passage autre etat
                state_d <= S_Pre_Fetch; -- on retourne pour decoder le prochain etat
            when S_BLTU =>
                cmd.ALU_Y_sel<=ALU_Y_rf_rs2;
                if status.JCOND then 
                    cmd.TO_PC_Y_sel<=TO_PC_Y_immB;
                    cmd.PC_sel<=PC_from_pc;
                    cmd.PC_we<='1';
                else
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04; -- selection de PC +4
                    cmd.PC_sel <= PC_from_pc;  -- PC+4
                    cmd.PC_we <= '1';
                end if;
                -- passage autre etat
                state_d <= S_Pre_Fetch; -- on retourne pour decoder le prochain etat
            when S_BNE =>
                cmd.ALU_Y_sel<=ALU_Y_rf_rs2;
                if status.JCOND then 
                    cmd.TO_PC_Y_sel<=TO_PC_Y_immB;
                    cmd.PC_sel<=PC_from_pc;
                    cmd.PC_we<='1';
                else
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04; -- selection de PC +4
                    cmd.PC_sel <= PC_from_pc;  -- PC+4
                    cmd.PC_we <= '1';
                end if;
                -- passage autre etat
                state_d <= S_Pre_Fetch; -- on retourne pour decoder le prochain etat
            when S_SLT =>
                cmd.ALU_Y_sel<=ALU_Y_rf_rs2;
                cmd.DATA_sel <= DATA_from_slt;
                cmd.RF_we<='1';
                -- passage autre etat
                state_d <= S_Pre_Fetch;
            when S_SLTI =>
                cmd.ALU_Y_sel<=ALU_Y_immI;
                cmd.DATA_sel <= DATA_from_slt;
                cmd.RF_we<='1';
                -- passage autre etat
                state_d <= S_Pre_Fetch; 
            when S_SLTU =>
                cmd.ALU_Y_sel<=ALU_Y_rf_rs2;
                cmd.DATA_sel <= DATA_from_slt;
                cmd.RF_we<='1';
                -- passage autre etat
                state_d <= S_Pre_Fetch; 
            when S_SLTIU =>
                cmd.ALU_Y_sel<=ALU_Y_immI;
                cmd.DATA_sel <= DATA_from_slt;
                cmd.RF_we<='1';
                -- passage autre etat
                state_d <= S_Pre_Fetch;
            when S_JAL =>
                cmd.TO_PC_Y_sel <= TO_PC_Y_immJ; -- selection de PC +J
                cmd.PC_sel <= PC_from_pc;
                cmd.PC_we <= '1';
                
                --stocke dans ra 
                cmd.PC_X_sel<=PC_X_pc;
                cmd.PC_Y_sel<=PC_Y_cst_x04;
                cmd.DATA_sel<=DATA_from_pc;
                cmd.RF_we<='1';
                
                -- passage autre etat
                state_d <= S_Pre_Fetch; -- on retourne pour decoder le prochain etat
            when S_JALR =>
                cmd.ALU_Y_sel <= ALU_Y_immI; -- selection de PC +J
                cmd.ALU_op<=ALU_plus;
                cmd.PC_sel <= PC_from_alu;
                cmd.PC_we <= '1';
                
                --stocke dans rd
                cmd.PC_X_sel<=PC_X_pc;
                cmd.PC_Y_sel<=PC_Y_cst_x04;
                cmd.DATA_sel<=DATA_from_pc;
                cmd.RF_we<='1';
                
                -- passage autre etat
                state_d <= S_Pre_Fetch; -- on retourne pour decoder le prochain etat
---------- Instructions de chargement à partir de la mémoire ----------
            when S_LW =>
                cmd.AD_we<='1'; 
                cmd.AD_Y_sel <= AD_Y_immI;
                state_d <= S_LW2;        
            
            when S_LW2 =>
                cmd.ADDR_sel <= ADDR_from_ad;
                cmd.mem_ce <= '1';
                cmd.RF_SIZE_sel<=RF_SIZE_word;
                state_d <= S_LW3; 
            when S_LW3 =>
                cmd.RF_we<='1'; 
                cmd.RF_SIGN_enable <='1';
                cmd.RF_SIZE_sel<=RF_SIZE_word;
                cmd.mem_ce <= '1';
                cmd.DATA_sel <= DATA_from_mem;
                -- passage autre etat
                state_d <= S_Pre_Fetch; 
            
            when S_LB =>
                cmd.AD_we<='1';
                cmd.AD_Y_sel <= AD_Y_immI;
                state_d <= S_LB2;        
            
            when S_LB2 =>
                cmd.ADDR_sel <= ADDR_from_ad;
                cmd.mem_ce <= '1';
                cmd.RF_SIZE_sel<=RF_SIZE_byte;
                state_d <= S_LB3; 
            when S_LB3 =>
                cmd.RF_we<='1'; 
                cmd.RF_SIGN_enable <='1';
                cmd.RF_SIZE_sel<=RF_SIZE_byte;
                cmd.mem_ce <= '1';
                cmd.DATA_sel <= DATA_from_mem;
                -- passage autre etat
                state_d <= S_Pre_Fetch;
            when S_LBU =>
                cmd.AD_we<='1';
                cmd.AD_Y_sel <= AD_Y_immI;
                state_d <= S_LBU2;        
            
            when S_LBU2 =>
                cmd.ADDR_sel <= ADDR_from_ad;
                cmd.mem_ce <= '1';
                cmd.RF_SIZE_sel<=RF_SIZE_byte;
                state_d <= S_LBU3; 
            when S_LBU3 =>
                cmd.RF_we<='1'; 
                cmd.RF_SIGN_enable <='0';
                cmd.RF_SIZE_sel<=RF_SIZE_byte;
                cmd.mem_ce <= '1';
                cmd.DATA_sel <= DATA_from_mem;
                -- passage autre etat
                state_d <= S_Pre_Fetch;
            
            when S_LH =>
                cmd.AD_we<='1';
                cmd.AD_Y_sel <= AD_Y_immI;
                state_d <= S_LH2;        
            
            when S_LH2 =>
                cmd.ADDR_sel <= ADDR_from_ad;
                cmd.mem_ce <= '1';
                cmd.RF_SIZE_sel<=RF_SIZE_half;
                state_d <= S_LH3; 
            when S_LH3 =>
                cmd.RF_we<='1'; 
                cmd.RF_SIGN_enable <='1';
                cmd.RF_SIZE_sel<=RF_SIZE_half;
                cmd.mem_ce <= '1';
                cmd.DATA_sel <= DATA_from_mem;
                -- passage autre etat
                state_d <= S_Pre_Fetch;
            when S_LHU =>
                cmd.AD_we<='1';
                cmd.AD_Y_sel <= AD_Y_immI;
                state_d <= S_LHU2;        
            
            when S_LHU2 =>
                cmd.ADDR_sel <= ADDR_from_ad;
                cmd.mem_ce <= '1';
                cmd.RF_SIZE_sel<=RF_SIZE_half;
                state_d <= S_LHU3; 
            when S_LHU3 =>
                cmd.RF_we<='1'; 
                cmd.RF_SIGN_enable <='0';
                cmd.RF_SIZE_sel<=RF_SIZE_half;
                cmd.mem_ce <= '1';
                cmd.DATA_sel <= DATA_from_mem;
                -- passage autre etat
                state_d <= S_Pre_Fetch; 
---------- Instructions de sauvegarde en mémoire ----------
            when S_SW =>
                cmd.AD_Y_sel<=AD_Y_immS; 
                cmd.AD_we <= '1';    
                -- passage autre etat
                state_d <= S_SW2;
            when S_SW2=>
                cmd.mem_ce <= '1';
                cmd.mem_we <= '1'; 
                cmd.ADDR_sel<=ADDR_from_ad;
                cmd.RF_SIZE_sel <= RF_SIZE_word;
                state_d <= S_Pre_Fetch;

            when S_SH =>
                cmd.AD_Y_sel<=AD_Y_immS; 
                cmd.AD_we <= '1';
                -- passage autre etat
                state_d <= S_SH2;
            when S_SH2=>
                cmd.mem_ce <= '1';
                cmd.mem_we <= '1'; 
                cmd.ADDR_sel<=ADDR_from_ad;
                cmd.RF_SIZE_sel <= RF_SIZE_half;
                state_d <= S_Pre_Fetch;

            when S_SB =>
                cmd.AD_Y_sel<=AD_Y_immS; 
                cmd.AD_we <= '1';
                
                -- passage autre etat
                state_d <= S_SB2;
            when S_SB2=>
                cmd.mem_ce <= '1';
                cmd.mem_we <= '1'; 
                cmd.ADDR_sel<=ADDR_from_ad;
                cmd.RF_SIZE_sel <= RF_SIZE_byte;
                state_d <= S_Pre_Fetch;
---------- Instructions d'accès aux CSR ----------

            when others => null;
        end case;

    end process FSM_comb;

end architecture;
