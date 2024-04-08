# TAG = addi
	.text

    lui x31, 0       #Test chargement d'une valeur nulle
    addi x31, x31, 1; # x31 = x31 + 1

	# max_cycle 250
	# pout_start
	# 00000000
    # 00000001
    # pout_end
