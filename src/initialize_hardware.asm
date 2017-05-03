; ------------------------------------------------------------------------------
; Hardware initialization
;
; Author:  Cytlan
; License: Copyright © 2017, Shibesoft AS
;          All rights reserved
;
; ------------------------------------------------------------------------------

.autoimport	on
.include "macros.inc"

.export	InitializeHardware

.segment "Initialize"

; This procedure initializes the registers and clears all RAM
; so that we can get the hardware into a known (blank) state.
.proc InitializeHardware
	
	; Initialize registers
	ACC_8
	lda #$8f
	sta INIDISP
	stz OBJSEL

	stz OAMADDL
	stz OAMADDH
	stz BGMODE
	stz MOSAIC
	stz BG1SC
	stz BG2SC
	stz BG3SC
	stz BG4SC
	stz BG12NBA
	stz BG34NBA

	; Reset background scroll registers
	stz BG1HOFS
	stz BG1HOFS
	stz BG1VOFS
	stz BG1VOFS
	stz BG2HOFS
	stz BG2HOFS
	stz BG2VOFS
	stz BG2VOFS
	stz BG3HOFS
	stz BG3HOFS
	stz BG3VOFS
	stz BG3VOFS
	stz BG4HOFS
	stz BG4HOFS
	stz BG4VOFS
	stz BG4VOFS

	lda #$80
	sta VMAINC
	stz VMADDL
	stz VMADDH
	stz M7SEL

	; Reset Mode-7 registers
	stz M7A
	lda #$01
	sta M7A
	stz M7B
	stz M7B
	stz M7C
	stz M7C
	stz M7D
	stz M7D
	stz M7X
	stz M7X
	stz M7Y
	stz M7Y

	stz CGADD
	stz W12SEL
	stz W34SEL
	stz WOBJSEL
	stz WH0
	stz WH1
	stz WH2
	stz WH3
	stz WBGLOG
	stz WOBJLOG
	lda #$01
	sta TM
	stz TS
	stz TMW
	stz TSW
	lda #$30
	sta CGSWSEL
	stz CGADSUB
	lda #$e0
	sta COLDATA
	stz SETINI

	; CPU register initializer
	stz NMITIMEN
	lda #$ff
	sta WRIO
	stz WRMPYA
	stz WRMPYB
	stz WRDIVL
	stz WRDIVH
	stz WRDIVB
	stz HTIMEL
	stz HTIMEH
	stz VTIMEL
	stz VTIMEH
	stz MDMAEN
	stz HDMAEN
	stz MEMSEL

	; Clear memory
	ALL_16
	ldy #$8000
	stz VMADDR
	@loop:
		stz WRVMDATA
		dey
	bne @loop

	rts
.endproc

