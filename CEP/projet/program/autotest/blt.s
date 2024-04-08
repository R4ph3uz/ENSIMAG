# TAG = blt
    .text
    lui x30,0
    lui x31,0
    addi x30,x30,3
    addi x31,x31,5
    blt x31,x30,fin 
    addi x31,x31, -5
    blt x31,x30,fin
    addi x31,x31, -5

    fin:

    # max_cycle 50
    # pout_start
    # 00000000
    # 00000005
    # 00000000
    # pout_end