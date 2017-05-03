; ------------------------------------------------------------------------------
; Register size macros
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

; 16-bit accumulator
.macro ACC_16
	rep #$20
	.a16
.endmacro

; 8-bit accumulator
.macro ACC_8
	sep #$20
	.a8
.endmacro

; 16-bit indexing
.macro INDEX_16
	rep #$10
	.i16
.endmacro

; 8-bit indexing
.macro INDEX_8
	sep #$10
	.i8
.endmacro

; 16-bit accumulator and indexing
.macro ALL_16
	rep #$30
	.a16
	.i16
.endmacro

; 8-bit accumulator and indexing
.macro ALL_8
	sep #$30
	.a8
	.i8
.endmacro
