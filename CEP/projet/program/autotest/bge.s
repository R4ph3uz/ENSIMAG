# TAG = bge
    .text
    lui x30,0
    lui x31,0
    addi x30,x30,5
    addi x31,x31,3
    bge x31,x30,fin 
    addi x31,x31, 5
    bge x31,x30,fin
    addi x31,x31, 5

    fin:

    # max_cycle 50
    # pout_start
    # 00000000
    # 00000003
    # 00000008
    # pout_end