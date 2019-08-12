col = $d5	; initial value 39

	.segment "PRG"

	.byte $01,$08			; load address

	; basic stub
	.byte $ff,$ff 			; next line link

	.byte $d0,$b6			; line number, write $d0 to $39 and $b6 (01101101 in binary) to $3a

	.byte $9e,$32,$30,$38		; SYS 2080 ($820)
halt:	bmi halt	; $30,$fe

	;01101101	6d
	;10110110	b6

loop:	; next row?
	asl $3a		; $4a	+2
	bcc skip
	inc $3a
	jsr $e8ec	; scroll, clobbers X & Y
skip:	lda col		; $a5 $d5
	tay
	eor #$ff
	tax
	lda #$a0
	; plot
	dec col
	sta $400+25*40-255-1,x		; $6e8
	sta ($d1),y
	sta ($38),y			; set colors
	bvc halt
