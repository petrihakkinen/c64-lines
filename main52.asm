	.segment "PRG"

	.byte $01,$08			; load address

	; basic stub
	.byte $0b,$08
	.byte $0a,$00			; line number
	.byte $9e,$32,$30,$36,$31	; SYS 2061
	.byte 0, 0, 0

	.org $80d

main:	jsr $e544	; clear screen

	; draw first line
	; x = 1 at this point
	dex		; x = 0	
drawline:
	lda #$b6
	
	; X = row, Y = column
	ldy #39
dloop:	pha
	jsr $e50c	; plot
	lda #$a0
	sta $d020,y	; set colors
	sta ($d1),y
	pla
	; next row?
	lsr
	bcc :+
du:	inx
	ora #$80
:	dey
	bpl dloop

	; draw second line
	ldy #$ca	; dex
	sty du
	ldx #24
	bne drawline	; always branches
