; ------------------------------------------------------------------------------
; Register size macros
;
; Author:  Cytlan
; License: Copyright © 2017, Shibesoft AS
;          All rights reserved
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
