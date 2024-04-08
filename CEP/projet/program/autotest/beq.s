# TAG = beq
    .text
    lui x31,0
    lui x30,0
    addi x30 ,x30,4
    beq x31,x30,fin
    addi x31,x31,1
    beq x31,x30,fin
    addi x31,x31,1
    beq x31,x30,fin
    addi x31,x31,1
    beq x31,x30,fin
    addi x31,x31,1
    beq x31,x30,fin
    addi x31,x31,1
    beq x31,x30,fin
    addi x31,x31,1
    beq x31,x30,fin
    addi x31,x31,1
    beq x31,x30,fin
    addi x31,x31,1
    beq x31,x30,fin
    addi x31,x31,1
    beq x31,x30,fin
    addi x31,x31,1
    beq x31,x30,fin
    addi x31,x31,1
    beq x31,x30,fin
    addi x31,x31,1
    beq x31,x30,fin
    addi x31,x31,1
    
    fin:

    # max_cycle 50
    # pout_start
    # 00000000
    # 00000001
    # 00000002
    # 00000003
    # 00000004
    # pout_end