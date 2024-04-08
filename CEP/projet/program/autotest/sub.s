# TAG = sub
	.text

    lui x31, 0      #chargement d'une valeur
    lui x29, 0
    addi x29, x29, 2
    addi x31, x31, 6; # x31 = x31 + 
    sub x31, x31, x29; # x31 = x31 - x30
    sub x31, x31, x31; # x31 = x31 + x31
    
	# max_cycle 250
	# pout_start
	# 00000000
	# 00000006
	# 00000004
	# 00000000
    # pout_end
