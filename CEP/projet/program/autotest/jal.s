# TAG = jal
    .text
    lui x31,0
    jal ra,fin
    addi x31,x31,3

    fin:
    addi x31,x31,5

    # max_cycle 50
    # pout_start
    # 00000000
    # 00000005
    # pout_end
