; ------------------------------------------------------------------------------
; Non-maskable interrupt
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

.export NMI

.proc NMI
	inc $01
	lda $01
	;cmp #$01
	;bne @skip
	ACC_16
		sec
		lda $02
		adc #$00
		sta $02
	ACC_8
	;stz $01
@skip:
	lda $02
	sta BG1HOFS
	lda $03
	sta BG1HOFS
	stz BG1VOFS
	stz BG1VOFS
	rti
.endproc
