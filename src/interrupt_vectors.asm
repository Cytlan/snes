; ------------------------------------------------------------------------------
; Interrupt vectors
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

.import Reset
.import NMI
.segment "InterruptVectors"

	; Filler
	.word $0000
	.word $0000

	; Native mode
	.word $0000 ; COP
	.word $0000 ; BRK
	.word $0000 ; Abort
	.word NMI   ; NMI
	.word $0000 ; Unused
	.word $0000 ; IRQ

	; Filler
	.word $0000
	.word $0000

	; Emulation mode
	.word $0000 ; COP
	.word $0000 ; Unused
	.word $0000 ; Abort
	.word NMI   ; NMI
	.word Reset ; Reset
	.word $0000 ; IRQ/BRK
