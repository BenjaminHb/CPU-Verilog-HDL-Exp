# Test File for 7 Instruction, include:
# ADDU/SUBU/LW/SW/ORI/BEQ/JAL
################################################################
### Make sure following Settings :
# Settings -> Memory Configuration -> Compact, Data at address 0

.text
	lui  $1,0x2000
	ori $29, $1, 12
	ori $2, $1, 0x1234
	ori $3, $1, 0x3456
	ori $7, $1, 0x3456
	ori $8, $0, 0x10
	f0:
	addu $4, $2, $3
	sw $2, 0($0)
	sw $3, 4($0)
	sw $4, 8($0)
	lw $5, 0($0)
	beq $2, $5, _lb2
	
	subu $6, $3, $4
	_lb1:
	lw $3, 4($0)
	_lb2:
	lw $5, 8($0)
	beq $3, $5, _lb1
	subu $6, $6, $2
	sw $6, -4($8)
	j f0
	

	
