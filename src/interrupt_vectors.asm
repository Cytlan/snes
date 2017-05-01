; ------------------------------------------------------------------------------
; Interrupt vectors
;
; Author:  Cytlan
; License: Copyright © 2017, Shibesoft AS
;          All rights reserved
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
