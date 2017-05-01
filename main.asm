; ------------------------------------------------------------------------------
; Entry point
;
; Author:  Cytlan
; License: Copyright © 2017, Shibesoft AS
;          All rights reserved
;
; ------------------------------------------------------------------------------

.autoimport	on

.segment "Reset"

; Default palette - Generate with GFX.js
Pal_Main:
	.word $0000 ; Black - Black
	.word $4231 ; Grey - Jumbo
	.word $0000 ; Black - Black
	.word $77bd ; White - White Smoke
	.word $675a ; Grey - Concrete
	.word $035d ; Yellow - School Bus Yellow
	.word $1ebf ; Yellow - Supernova
	.word $36fd ; Yellow - Harvest Gold
	.word $1a91 ; Green - Sushi
	.word $0b4e ; Green - Kelly Green
	.word $666e ; Blue - Seagull
	.word $5af7 ; Grey - Silver Sand
	.word $55f5 ; Violet - Bouquet
	.word $14bd ; Red - Alizarin
	.word $294a ; Grey - Mortar
	.word $18c5 ; Green - Swamp

; String data
Str_HelloWorld:
	; ASCII string with null-terminator
	.asciiz	"HELLO, WORLD!"

.export Reset
.proc Reset
	sei

	; Set native mode
	clc
	xce
	phk
	plb

	; 16-bit accumulator mode
	; 16-bit index mode
	rep	#$30
.a16
.i16

	; Set stack pointer
	ldx	#$1fff
	txs
	
	jsr	InitializeHardware

	; ???
	sep	#$20 
.a8
	lda	#$40
	sta	$2107
	stz	$210b
	
	; Load the palette
	stz	$2121
	ldy	#$0200
	ldx	#$0000
@loadpal:
	lda	Pal_Main, x
	sta	$2122
	inx
	dey
	bne	@loadpal

	; Load CHR data
	rep	#$20 ; 16-bit accumulator mode
.a16
	lda	#$0000
	sta	$2116
	ldy	#$2000
	ldx	#$0000
@loadchr:
	lda	Gfx_Text, x
	sta	$2118
	inx
	inx
	dey
	bne	@loadchr

	; Copy the "Hello, World!" string to the nametable
	; Set register
	lda	#$41a9
	sta	$2116

	; Prepare registers
	ldx	#$0000
	lda	#$0000

	; Load the string into the nametable
@loadstr:
	sep	#$20 ; 8-bit accumulator mode
.a8
	lda Str_HelloWorld, x
.a16
	rep #$20  ; Set Accumulator to be 16-bits
	sta $2118 ; Store it in the nametable
	inx       ; Increment index
	cmp #$00  ; Check if we've hit a null-terminator
	bne	@loadstr

	; ???
	lda	#$01
	sta	$212c
	stz	$212d
	lda	#$0f
	sta	$2100

	; Do nothing forever
infinite:
	jmp	infinite

.endproc
