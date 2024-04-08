# TAG = xori
	.text

	lui x31, 0       #Test chargement d'une valeur nulle
    xori x31, x31, 255
	lui x31, 0
    addi x31, x31, 85 
	xori x31,x31,255

	# max_cycle 50
	# pout_start
	# 00000000
    # 000000FF
	# 00000000
	# 00000055
	# 000000AA
	# pout_end
