; ------------------------------------------------------------------------------
; Entry point
;
; Copyright (c) 2017, Cytlan, Shibesoft AS
;
; This is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.
;
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.
;
; You should have received a copy of the GNU General Public License
; along with this program.  If not, see <http://www.gnu.org/licenses/>.
;
; ------------------------------------------------------------------------------

.autoimport	on
.include "macros.inc"

.export Reset

; ------------------------------------------------------------------------------
; Data
; ------------------------------------------------------------------------------
; Include CHR data
.segment "Graphics"
CHR:
	.incbin	"res/chr/text.chr"

CHR2:
	.byte %10000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %01000000
	.byte %00000000
	.byte %00000000
	.byte %00000000

	.byte %00100000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00010000
	.byte %00000000
	.byte %00000000
	.byte %00000000

	.byte %00001000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000100
	.byte %00000000
	.byte %00000000
	.byte %00000000

	.byte %00000010
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000001
	.byte %00000000
	.byte %00000000
	.byte %00000000

.segment "Reset"

; Include the palette
Palette:

	.word $0000 ; Black - Black
	.word $294a ; Grey - Mortar
	.word $035d ; Yellow - School Bus Yellow
	.word $77bd ; White - White Smoke
	.word $1ebf ; Yellow - Supernova
	.word $36fd ; Yellow - Harvest Gold
	.word $1a91 ; Green - Sushi
	.word $0b4e ; Green - Kelly Green
	.word $666e ; Blue - Seagull
	.word $55f5 ; Violet - Bouquet
	.word $14bd ; Red - Alizarin
	.word $5af7 ; Grey - Silver Sand
	.word $4231 ; Grey - Jumbo
	.word $675a ; Grey - Concrete
	.word $18c5 ; Green - Swamp
	.word $0000 ; Black - Black
PaletteSize = $2000

; String data
Str_HelloWorld:
	; ASCII string with null-terminator
	;.asciiz	"0123456789ABCDEF0123456789ABCDEF"
	.asciiz "0123456789ABCDEFGHIJKLMNOPQRSTUV"

Str_2:
	.asciiz "WXYZabcdefghijklmnopqrstuvwxyz!^"

; ------------------------------------------------------------------------------
; Code
; ------------------------------------------------------------------------------

; A: VRAM addr
; X: Data addr
.proc WriteString
	.a16
	.i16
	sta VMADDR
	stx $04

	; Prepare registers
	ldy #$0000
	lda #$0000

	; Load the string into the nametable
	@loadstr:
		ACC_8
		lda ($04),y  ; Load an 8-bit ASCII charater
		ACC_16
		sta VMDATA ; Store it in the nametable
		iny          ; Increment index
		cmp #$00     ; Check if we've hit a null-terminator
	bne	@loadstr
	rts
.endproc

.proc Reset
	sei

	; Set native mode
	clc ; Clear carry
	xce ; Move carry to emulation bit
	phk ; 
	plb ; Databank 0

	; Set stack pointer
	ALL_16
	ldx #$1FFF
	txs

	; Reset registers
	jsr InitializeHardware

	; Turn on high speed
	ACC_8
	lda #$01
	sta MEMSEL

	; Long-jump to ourselves
	; This causes the program bank to change, and we should be in a bank > $80
	; This is needed to enter fast mode
	jml @self
	@self:

	; Select BG
	lda #$41  ; 2 screens: $0800*2 bytes
	sta BG1SC ; Tilemap at $4000 in VRAM
	stz BG12NBA

	; Load palettes
	stz CGADD
	ldy #$0200
	ldx #$0000
	@loadpal:
		lda Palette, x
		sta WRCGDATA
		inx
		dey
	bne @loadpal

	; Load CHR data
	ACC_16
	lda #$0000
	sta VMADDR
	ldy #$2000
	ldx #$0000
	@loadchr:
		lda CHR,x
		sta VMDATA
		inx
		inx
		dey
	bne @loadchr

	; Copy the "Hello, World!" string to the nametable
	; Set register
	;lda	#$41A9
	lda #($4000+($20*$4))
	ldx #.loword(Str_HelloWorld)
	jsr WriteString
	lda #($4400+($20*$4))
	ldx #.loword(Str_2)
	jsr WriteString

	; Main screen selection
	lda #$01
	sta TM

	; Sub screen selection
	stz TS

	; Enable NMI
	lda #$81
	sta NMITIMEN

	; Allow rendering
	lda #$0F
	sta INIDISP

	; Do nothing forever
infinite:
	jmp infinite

.endproc
