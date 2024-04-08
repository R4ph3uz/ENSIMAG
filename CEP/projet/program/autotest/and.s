# TAG = and
	.text

	lui x31, 0       #Test chargement d'une valeur nulle
	lui x29, 0xfffff 
    and x31, x29,x31
    lui x31, 0xfffff
    lui x29, 0xfff00
	and x31, x29,x31

	# max_cycle 50
	# pout_start
	# 00000000
	# 00000000
	# FFFFF000
    # FFF00000
	# pout_end
