; ------------------------------------------------------------------------------
; Cartridge header
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

; Cartridge info
.segment "ROMHeader"
	.byte   "SS"                     ; 0xB0 - Maker code. Usually given by Nintendo.
	.byte   "SHIB"                   ; 0xB2 - Game Code. Also given by Nintendo.
	.res    7, $00                   ; 0xB6 - Always 00
	.byte   $00                      ; 0xBD - Expansion RAM size
	.byte   $00                      ; 0xBE - Special version
	.byte   $00                      ; 0xBF - Cartridge type (Sub-number)
	.byte	"SAMPLE ROM           "  ; 0xC0 - Game Title
	.byte	$20                      ; 0xD5 - Map mode: 0x01:HiRom, 0x30:FastRom(3.57MHz)
	.byte   $00                      ; 0xD6 - Cartridge type
	.byte	$09                      ; 0xD7 - ROM Size (2KByte * N)
	.byte	$00                      ; 0xD8 - RAM Size (8KByte * N)

; Chart of Destination Codes:
; +------------------------+------------------------+
; | Destination        | C | Destination        | C |
; +--------------------+---+--------------------+---+
; | 00 Japan           | J | 0B Chinese         | C |
; | 01 USA and Canada  | E | 0D Korean          | K |
; | 02 All of Europe   | P | 0E Common          | A |
; | 03 Scandinavia     | W | 0F Canada          | N |
; | 06 Europe (French) | F | 10 Brazil          | B |
; | 07 Dutch           | H | 11 Australia       | U |
; | 08 Spanish         | S | 12 Other Variation | X |
; | 09 German          | D | 13 Other Variation | Y |
; | 0A Italian         | I | 14 Other Variation | Z |
; +--------------------+---+--------------------+---+
;    Destination - The destination/language of the ROM
;    C           - The ROM recognition code (4th digit of game code)

	.byte	$0E                      ; 0xD9 - Destination code. We use Common, to indicate international ROM

	.byte	$33                      ; 0xDA - Always 33
	.byte   $00                      ; 0xDB - Mask ROM version

; Checksum is calculated by adding all bytes of the ROM, then masking that value to 0xFFFF
	.word   $0000                    ; 0xDC - Complement checksum (Inverse of checksum)
	.word   $FFFF                    ; 0xDE - Checksum

; EOF