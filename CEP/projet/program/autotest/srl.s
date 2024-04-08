# TAG = srl
	.text

	lui x31, 0xFFF00
	lui x29, 0
	addi x29, x29, 1; # x29 = x29 + 1
    srl x31, x31,x29

	# max_cycle 50
	# pout_start
	# FFF00000
	# 7FF80000
	# pout_end
