# TAG = or
	.text

	lui x31, 0       #Test chargement d'une valeur nulle
	lui x29, 0xfffff
    or x31, x29,x31
    lui x31, 0xfff00
    lui x29, 0x000ff
	or x31, x29,x31

	# max_cycle 50
	# pout_start
	# 00000000
    # FFFFF000
	# FFF00000
	# FFFFF000
	# pout_end
