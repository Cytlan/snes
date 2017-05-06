; ------------------------------------------------------------------------------
; sprintf
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


.autoimport on
.include "macros.inc"
.include "memory.asm"

.segment "CODE"
.export sprintf

;
; fmt string pointer in lptr1
; destination pointer in lptr2
; Arguments pushed to stack.
;
.proc sprintf
	; Local aliases
	FMT=lptr1
	DEST=lptr2
	DP=lptr3
	RETADDR=ptr1

	INDEX_8
	ACC_16
	pla
	sta RETADDR

	ACC_8
	@loop:
		lda [FMT]
		beq @loopend ; If we hit a null-terminator, end the loop

		cmp #'%'
		beq @mode
		; Not a control code, copy as-is
		@copychar:
			sta [DEST]
			ACC_16
			inc FMT
			inc DEST
			ACC_8
			jmp @loop
		@mode:
			ACC_16
			inc FMT
			ACC_8
			jmp @modeloop

	;---------------------
	; Mode decoding
	;
	@modeloop:
		lda [FMT]
		cmp #'s'
		beq @modestring
		cmp #'%'
		beq @modepercent
		;cmp #'x'
		;beq @modehexlow

		; Nothing matches, jump out
	@modeend:
		ACC_16
		inc FMT
		ACC_8
		jmp @loop

	;---------------------
	; %x mode
	;
	@modehexlow:
		; Fetch value
		;pla
		;clc
		;sbc #'0'
		;tax
		;lda str_hex_upper,x
		;sta [DEST]


		sta DP+2
		ACC_16
		pla
		sta DP

	;---------------------
	; %% mode
	;
	@modepercent:
		sta [DEST]
		ACC_16
		inc DEST
		ACC_8
		jmp @modeend

	;---------------------
	; %s mode
	;
	@modestring:
		; Fetch string pointer
		ACC_8
		pla
		sta DP+2
		ACC_16
		pla
		sta DP

		@modestringloop:
			lda [DP]
			beq @modeend
			sta [DEST]

			ACC_16
			inc DP
			inc DEST
			ACC_8
			jmp @modestringloop

	@loopend:

	lda #0
	sta [FMT]

	ACC_16
	lda RETADDR
	pha
	rts
.endproc
