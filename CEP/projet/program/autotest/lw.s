# TAG = lw
	.text

    lui x31,0
    addi x31,x31,5
    lw x31,0(zero)
    
	# max_cycle 250
	# pout_start
	# 00000000
	# 00000005
	# 00000000
    # pout_end
