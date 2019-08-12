col = $86	; initial value $30 (48)

	.segment "PRG"

	.byte $02,$08			; load address

	; basic stub
	.byte $ff 			; next line link

	.byte $d0,$b6			; line number, write $d0,$b6 to $39,$3a ($b6 = 01101101 in binary)

	.byte $9e,$32,$30,$36		; SYS 2060 ($80c)
halt:	bmi halt			; $30,$fe	bmi is the last digit of the sys address
	
loop:	; next row?
	asl $3a
	bcc skip
	; entry point roughly here ($80c, sys 2060)
	inc $3a
	jsr $e8ec	; scroll down, clobbers X & Y
skip:	pla		; increment stack pointer
	tsx
	lda #$a0
	sta $400+40*24,x
	ldy col
	dec col
	sta ($d1),y
	sta ($38),y	; set colors
	bvc halt