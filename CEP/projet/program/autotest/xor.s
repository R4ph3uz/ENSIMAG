# TAG = xor
	.text

	lui x31, 0       #Test chargement d'une valeur nulle
	lui x29, 0xfffff
    xor x31, x29,x31
    lui x31, 0xfff00
    lui x29, 0x00fff
	xor x31, x29,x31

	# max_cycle 50
	# pout_start
	# 00000000
    # FFFFF000
	# FFF00000
	# FF0FF000
	# pout_end
