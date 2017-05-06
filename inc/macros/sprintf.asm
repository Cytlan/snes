; ------------------------------------------------------------------------------
; sprintf macros
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

.macro  SPRINTF_PUSH r1, r2, r3, r4, r5
	; push last argument first
	.ifblank r1
		.exitmacro
	.endif
	.if .paramcount > 1
		SPRINTF_PUSH r2, r3, r4, r5
	.endif

	; pointer
	lda #r1
	pha
	ldx #.bankbyte(r1)
	phx
.endmacro

.macro SPRINTF fmt, dest, r1, r2, r3, r4, r5
	ACC_16
	INDEX_8

	; format string pointer
	lda #fmt
	sta lptr1
	ldx #.bankbyte(fmt)
	stx lptr1+2

	; destination pointer
	lda #dest
	sta lptr2
	ldx #.bankbyte(dest)
	stx lptr2+2

	SPRINTF_PUSH r1, r2, r3, r4, r5

	jsr sprintf
.endmacro
