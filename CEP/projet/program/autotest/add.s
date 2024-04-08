# TAG = add
	.text

    lui x31, 0       #chargement d'une valeur
    addi x31, x31, 1; # x31 = x31 + 1
    add x31, x31, x31; # x31 = x31 + x31
    add x31, x31, x31; # x31 = x31 + x31
    
	# max_cycle 250
	# pout_start
	# 00000000
	# 00000001
	# 00000002
	# 00000004
    # pout_end
