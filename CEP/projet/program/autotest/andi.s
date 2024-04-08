# TAG = andi
	.text

	lui x31, 0       #Test chargement d'une valeur nulle
	andi x31, x31, 255
    addi x31,x31, 255
    andi x31,x31, 85 # 85 = 1010101 = 55|16

	# max_cycle 50
	# pout_start
	# 00000000
	# 00000000
	# 000000FF
    # 00000055
	# pout_end
