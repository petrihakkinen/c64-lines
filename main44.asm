	.segment "PRG"

	.byte $01,$08			; load address

	; basic stub
	.byte $30,$08
	.byte 39,$6d			; line number
	.byte $9e,$32,$30,$35,$38	; SYS 2058

	.org $80a

cursor_row = $d6
cursor_col = $d3

main:	jsr $e544	; clear screen
	
dloop:	;jsr $e50c	; plot
	jsr $e510	; plot
	lda #$a0
	sta $d020,x	; set colors
	sta ($d1),y
	; mirror
	ldy $39
	sta ($d1),y
	; next row?
	asl $3a
	bcc :+
	inc cursor_row
	inc $3a
:	inc cursor_col
	dec $39
	bpl dloop

halt:	bvc halt
