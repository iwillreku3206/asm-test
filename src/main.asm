.segment "ONCE"
	ldx	#$40
	jmp	loop

binhex:
	pha                   ;save byte
	and	#%00001111        ;extract LSN
	tax                   ;save it
	pla                   ;recover byte
	lsr                   ;extract...
	lsr                   ;MSN
	lsr
	lsr
	pha                   ;save MSN
	txa                   ;LSN
	jsr	binhex1		;generate ASCII LSN
	tax                   ;save
	pla                   ;get MSN & fall thru
binhex1:
	cmp	#$0a
	bcc	binhex2          ;in decimal range
	adc	#$66              ;hex compensate
binhex2:
	eor	#%00110000        ;finalize nybble
	rts                   ;done
loop:
	ldy	#$07	; read keyboard
	ldx	#$42
	jsr	$fec6
	cmp	#$00
	beq	loop

	and	#%01111111

	jsr	binhex
	jsr	$ffd2
	txa
	jsr	$ffd2

	jsr	$fec6
	jsr	$ffd2

	lda	#$0d
	jsr	$ffd2
	jmp	loop

stop:
	rts
