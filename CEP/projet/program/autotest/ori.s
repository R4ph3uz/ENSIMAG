# TAG = ori
	.text

	lui x31, 0       #Test chargement d'une valeur nulle
    ori x31, x31, 255
	lui x31, 0
    addi x31, x31, 85 # 85 = 1010101 = 55 |16
	ori x31, x31,170 # 170 =10101010 = AA |16

	# max_cycle 50
	# pout_start
	# 00000000
    # 000000FF
	# 00000000
	# 00000055
	# 000000FF
	# pout_end
