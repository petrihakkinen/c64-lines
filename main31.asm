ov = $0d ; == $ff, initial value for the overflow counter

	.segment "PRG"

	.word $02e7
	.org $02e7

scroll:	lda #17
	jsr $ffd2
loop:	lda #$a0
	sta $d3e0-1,y
	sta $0400+40*24+39-$80+1,y	; incrementing rower, y finishes with value $80
	sta $0400+40*24-$7b-1,x		; decrementing rower, x finishes with value $7b
	adc ov
	sta ov
	dex
	iny
	bmi *
	bcc loop
	jmp scroll
