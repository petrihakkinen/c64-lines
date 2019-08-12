	.segment "PRG"

	.byte $01,$08			; load address

	; basic stub
	.byte $30,$08
	.byte $0a,$00			; line number
	.byte $9e,$32,$30,$35,$38	; SYS 2058

	.org $80a

col = $d5	; initial value 39

main:	lda #$6d	; init shift register to 01101101
loop:	; next row?
	lsr
	bcc skip
	ora #$80
	jsr $e8ec	; scroll, clobbers X & Y
skip:	pha
	lda col
	tay
	eor #$ff
	tax
	lda #$a0
	sta $400+25*40-255-1,x
	; plot
	sta ($d1),y
	sta $d020,y	; set colors
 	; next column
	dec col
halt:	bmi halt
	pla
	bne loop	; always branches
