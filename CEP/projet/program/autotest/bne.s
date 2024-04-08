# TAG = bne
    .text
    lui x31,0
    lui x30,0
    bne x31,x30,fin
    addi x31,x31,1
    bne x31,x30,fin
    addi x31,x31,1
    bne x31,x30,fin
    addi x31,x31,1
 
    
    fin:

    # max_cycle 50
    # pout_start
    # 00000000
    # 00000001  
    # pout_end