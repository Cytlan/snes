; ------------------------------------------------------------------------------
; SNES Full Register Definitions
;
; Author:  Cytlan
; License: Copyright © 2017, Shibesoft AS
;          All rights reserved
;
; ------------------------------------------------------------------------------

.export INIDISP, OBJSEL , OAMADDR, OAMADDL, OAMADDH, OAMDATA, BGMODE , MOSAIC 
.export BG1SC  , BG2SC  , BG3SC  , BG4SC  , BG12NBA, BG34NBA, BG1HOFS, BG1VOFS
.export BG2HOFS, BG2VOFS, BG3HOFS, BG3VOFS, BG4HOFS, BG4VOFS, VMAINC , VMADDR
.export VMADDH , VMADDL , VMDATA , VMDATAH, VMDATAL, M7SEL

; ------------------------------------------------------------------------------
; PPU Registers
; ------------------------------------------------------------------------------

; ------------------------------------------------------------------------------
; Initial settings for screen --------------------------------------------------
; ------------------------------------------------------------------------------
INIDISP = $2100 ; 76543210
                ; B   FFFF
                ; |   +--+- Screen Brightness
                ; +-------- Forced Blanking

; ------------------------------------------------------------------------------
; Object size & object data area designation -----------------------------------
; ------------------------------------------------------------------------------
OBJSEL = $2101  ; 76543210
                ; SSSNNBBB
                ; ||||||''- Object Base Address (Upper 3 bit) (Name base addr)
                ; ||||||    Designate the segment (8K-word/segment) address 
                ; ||||||    which the OBJ data is stored in the VRAM
                ; ||||||    (See pages A-1 and A2)
                ; ||||||
                ; |||||'--- For Expansion Norm = 0 (No idea what this means...)
                ; |||''---- Object Data Area Select (Name select)
                ; |||       The upper 4K-word out of the are (8K-word) 
                ; |||       designated by "Object Base Address" is assigned as
                ; |||       the Base Area, and the area of the lower 4K-word 
                ; |||       combined with its Base Area can be selected
                ; |||       (See pages A-1 and A2)
                ; |||
                ; '''------ Object Size: Designate object size 
                ;           (See pages A-3 and A-4)
                ;          +------+--------+--------+
                ;          |D7-D5 | Small  | Large  | 
                ;          +------+--------+--------+
                ;          | 000  |  8 dot | 16 dot |
                ;          | 001  |  8 dot | 32 dot |
                ;          | 010  |  8 dot | 64 dot |
                ;          | 011  | 16 dot | 32 dot |
                ;          | 100  | 16 dot | 64 dot |
                ;          | 101  | 32 dot | 64 dot |
                ;          +------+--------+--------+

; ------------------------------------------------------------------------------
; Address for access OAM (Object Attribute Memory) -----------------------------
; ------------------------------------------------------------------------------
OAMADDR = $2102 ; (Alias of OAMADDL, meant to refer to OAMADDL-OAMADDH as one)
OAMADDL = $2102 ; 76543210
                ; ''''''''- OAM Address D7-D0
                ;
OAMADDH = $2103 ; 76543210
                ; |      '- OAM Address D8
                ; '-------- OAM Priority Rotation
                ;
                ; * This is the INITIAL ADDRESS to be set in advance when 
                ;   reading from or writing to the OAM.
                ; * To set the OBJ priority order, write "1" to D7 (OAM Priority
                ;    Rotation) of register $2103 (OAMADDH) and set the highest  
                ;   priority OBJ number (0 - 127) to D1-D7 of register $2102 
                ;   (refer to "Priority Order Shifting")
                ; * The address which has been set just before every field 
                ;   (beginning with V-BLANK) will be set again to Registers
                ;   $2102-$2103 (OAMADDR) automatically. However, the address 
                ;   cannot be set automatically during Forced Blank period.

; ------------------------------------------------------------------------------
; Data for OAM write -----------------------------------------------------------
; ------------------------------------------------------------------------------
OAMDATA = $2104 ; 76543210
                ; ''''''''- OAM Data (Low, High)
                ;
                ; * This is the OAM data to be written to any address of the OAM
                ;   (refer to page A-3).
                ; * After register $2102 (OAMADDL) or $2103 (OAMADDH) is 
                ;   accessed, the data must be written in the order of Lower 
                ;   8-bit and Upper 8-bit of register $2104 (OAMDATA). The OAM
                ;   address will be increased automatically when the OAM data is
                ;   written in the order of LOW to HIGH.
                ; * The data can only be written during a V-BLANK or FORCED 
                ;   BLANK period.

; ------------------------------------------------------------------------------
; BG Mode & Character size settings --------------------------------------------
; ------------------------------------------------------------------------------
BGMODE = $2105  ; 76543210
                ; |||||'''- BG Mode (BG Screen Mode Select)
                ; |||||     See BG screen mode summary (page A-5)
                ; ||||'---- Highest Priority Designation For BG-3
                ; ||||      Make BG3 highest priority during BG mode 0 or 1.
                ; ||||      (page A-19)
                ; ''''----- BG Size (BG Size Designation)
                ;           Designate the size for each BG Character.
                ;           (pages A-21 and A-22)
                ;           0: 8x8 character, 1: 16x16 character
                ;
                ;            16 dot
                ;           +--+--+
                ;           |00|01| In case CHR NAME of SC data is "00H"
                ;    16 dot +--+--+
                ;           |10|11| <---- Character name (HEX)
                ;           +--+--+

; ------------------------------------------------------------------------------
; Size & Screen designation for mosaic display ---------------------------------
; ------------------------------------------------------------------------------
MOSAIC = $2106  ; 76543210
                ; ||||''''- Mosaic Enable (Mosaic Mode Select)
                ; ||||      Enable/Disable mosaic per background.
                ; ||||      D3 = BG4, D0 = BG1
                ; ''''----- Mosaic Size (Mode Size Designation) (page A-7)
                ;           256 Mode: Mosaic Size = 0-16
                ;           512 Mode: Mosaic Size = 0-32

; ------------------------------------------------------------------------------
; Address for storing SC-data of each BG & SC size designation -----------------
; ------------------------------------------------------------------------------
BG1SC = $2107   ; 76543210
BG2SC = $2108   ; ||||||''- BG SC Size (Screen Size Designation)
BG3SC = $2109   ; ||||||    (pages A-21 and A-22)
BG4SC = $210A   ; ''''''--- BG SC Base Address (Background Screen Base Address)
                ;           (Upper 6-bit)
                ;           Designate the segment in which BG-SC data in the 
                ;           VRAM is stored. (1K-Word/Segment)

; ------------------------------------------------------------------------------
; BG Character Data Area Designation -------------------------------------------
; ------------------------------------------------------------------------------
BG12NBA = $210B ; 76543210
                ; ||||''''- BG1 Name Base Address  Designate the segment address
                ; ''''----- BG2 Name Base Address  in the VRAM in which BG
BG34NBA = $210C ; 76543210                         character data is stored.
                ; ||||''''- BG3 Name Base Address  (4K-Word/Segment)
                ; ''''----- BG4 Name Base Address

; ------------------------------------------------------------------------------
; H/V Scroll Value Designation For BG-1 ----------------------------------------
; ------------------------------------------------------------------------------
BG1HOFS = $210D ; BG 1 H-Offset (Low, High)
BG1VOFS = $210E ; BG 1 V-Offset (Low, High)
                ; * 10-bit maximum (0-1023) can be designated for H/V scroll 
                ;   value. (The size of 13-bit -4069 to 4095 can be designated 
                ;	in MODE-7). (pages A-10 and A-11)
                ; * By writing to the register twice, the data can be set in the
                ;   order of Low and High.

; ------------------------------------------------------------------------------
; H/V Scroll Value Designation For BG-2, 3, 4 ----------------------------------
; ------------------------------------------------------------------------------
BG2HOFS = $210F ; BG H-Offset (Low, High)
BG2VOFS = $2110 ; BG V-Offset (Low, High)
BG3HOFS = $2111 ; BG H-Offset (Low, High)
BG3VOFS = $2112 ; BG V-Offset (Low, High)
BG4HOFS = $2113 ; BG H-Offset (Low, High)
BG4VOFS = $2114 ; BG V-Offset (Low, High)
                ; * 10-bit maximum (0-1023) of the H/V scroll value can be 
                ;   designated (page A-10)
                ; * By writing to the register twice, the data can be set in the
                ;   order of Low and High.

; ------------------------------------------------------------------------------
; VRAM Address Increment Value Designation -------------------------------------
; ------------------------------------------------------------------------------
VMAINC = $2115  ; 76543210
                ; |   ||''- Sequence Mode SC Increment
                ; |   ''--- VRAM Address Full Graphics
                ; '-------- H/L INC
                ;           Designate the increment timing for the address
                ;
                ; D7   0--- The address will be incremented after the data has
                ;  |   |    been written to register $2118 (VMDATAL) or the data 
                ;  '---|    has been read from register $2139 (TODO)
                ;      |
                ;      1--- Same as above, except with register $2119 (VMDATAH)
                ;           and register $213A (TODO)

; ------------------------------------------------------------------------------
; Address For VRAM Read and Write ----------------------------------------------
; ------------------------------------------------------------------------------
VMADDR = $2116  ; (Alias of VMADDL, meant to refer to VMADDL-VMADDH as one)
VMADDL = $2116  ; VRAM Address (Low)
VMADDH = $2117  ; VRAM Address (High)
                ; * This is the initial address for reading from the VRAM or
                ;   writing to the VRAM.
                ; * The data is read or written by the address set initially,
                ;   and every time the data is read or written, the address will
                ;   be increased automatically.
                ; * The value to be increased is determined by "SC INCREMENT" of
                ;   register $2115 (VMAINC) and the setting value of the 
                ;   "FULL GRAPHIC."

; ------------------------------------------------------------------------------
; Data For VRAM Write ----------------------------------------------------------
; ------------------------------------------------------------------------------
VMDATA  = $2118 ; (Alias of VMADDL, meant to refer to VMADDL-VMADDH as one)
VMDATAL = $2118 ; VRAM Data (Low)
VMDATAH = $2119 ; VRAM Data (High)
                ; * This is the screen data and character data (BG & OBJ), which
                ;   can be written to any address in the VRAM.
                ; * According to the setting or register $2115 (VMAINC) 
                ;   "H/L INC", the data can be written to the VRAM as follows:
                ; +---------+-------------------+-----------------------------+
                ; | H/L INC | Write To Register |           Operation         |
                ; +---------+-------------------+-----------------------------+
                ; |         |                   | The data will be written to |
                ; |    0    |   Write to $2118  | lower 8-bit of the VRAM and |
                ; |         |   (VMDATAL) only  |     the address will be     |
                ; |         |                   |   increased automatically.  |
                ; +---------+-------------------+-----------------------------+
                ; |         |                   | The data will be written to |
                ; |    1    |   Write to $2119  | upper 8-bit of the VRAM and |
                ; |         |   (VMDATAH) only  |     the address will be     |
                ; |         |                   |   increased automatically.  |
                ; +---------+-------------------+-----------------------------+
                ; |         |   Write to $2119  | When the data is set in the |
                ; |    0    | (VMDATAH) then to | order of upper then lower,  |
                ; |         |  $2118 (VMDATAL)  |     the address will be     |
                ; |         |       only        |          increased.         |
                ; +---------+-------------------+-----------------------------+
                ; |         |   Write to $2118  | When the data is set in the |
                ; |    1    | (VMDATAL) then to | order of lower then upper,  |
                ; |         |  $2119 (VMDATAH)  |     the address will be     |
                ; |         |       only        |          increased.         |
                ; +---------+-------------------+-----------------------------+
                ; NOTE: The data can be written only during V-BLANk or 
                ;       FORCED BLANK period.

; ------------------------------------------------------------------------------
; Initial Setting In Screen MODE-7 ---------------------------------------------
; ------------------------------------------------------------------------------
M7SEL = $211A   ; 76543210
                ; ||    VH
                ; ||    ''- Screen FLip, Horizontal/Vertical Flip:
                ; ||        H-FLIP/C-FLIP in the Screen MODE-7
                ; ||                                   +---+---+--------------+
                ; ||                                   | V | H | DISPLAY      |
                ; ''- Screen Over                      +---+---+--------------+
                ;     The following process it made if | 0 | 0 | Normal       |
                ;     the screen to be displayed is    | 0 | 1 | H flip only  |
                ;     outside the screen area:         | 1 | 0 | V flip only  |
                ;     +----+--------------------------+| 1 | 1 | Both H & V   |
                ;     |    | PROCESS OUT OF AREA      |+----------------------+
                ;     +----+--------------------------+
                ;     | 00 | Screen repetition        |
                ;     | 10 | Back Drop Screen color   |
                ;     | 11 | Character #0 repetition  |
                ;     +----+--------------------------+

; ------------------------------------------------------------------------------
; Rotation/Enlargment/Reduction in MODE-7, Center Coordinate Settings ----------
; & Multiplicant/Multiplier Settings Of Complementary Multiplication -----------
; ------------------------------------------------------------------------------
M7A = $211B     ; Matrix Parameter A (Low, High)
M7B = $211C     ; Matrix Parameter B (Low, High)
M7C = $211D     ; Matrix Parameter C (Low, High)
M7D = $211E     ; Matrix Parameter D (Low, High)
                ; * The 8-bit data should be written twice in the order of lower
                ;   and upper. Then, the parameter of rotation, enlargement and
                ;   reduction should be set by its 16-bit data.
                ; * The value down to a decimal point should be set to the lower
                ;   8-bit. The most significant bit of the upper 8-bit is for 
                ;   the signed bit. (MP15 is the signed bit. There is a decimal
                ;   between M7 & M8.)
                ; * FORMULA FOR ROTATION/ENLARGMENT/REDUCTION (Refer to 
                ;   Rotation/Enlargment/Reduction in Appendix A.).
                ; 
                ; (See the 2-27-9 page for the math stuff....)
                ;
                ; * Set the value of "A" to the register $211B (M7A). In the 
                ;   same way, set "B-D" to the register $211C-$211E (M7B-M7D)
                ; * The complementary multiplication (16-bit x 8-bit) can be 
                ;   done by using registers $211B (M7A) $211C (M7B). When 
                ;   setting 16-bit data to register $221B (M7A) (must be written
                ;   twice) and 8-bit data to register $211C (M7B) (must be 
                ;   written only once), the multiplication result can be 
                ;   indicated rapidly by reading registers $2134 (TODO) - $2136
                ;   (TODO)
M7X = $211F     ; Center Position X (Low, High)
M7Y = $2120     ; Center Position Y (Low, High)
                ; * The center coordinate (X0 Y0) for Rotation/Enlargment/
                ;   Reduction can be designated be this register.
                ; * The coordinate value of X0 & Y0 can be designated by 13-bit 
                ;   (complement of 2)
                ; * This register requires that the lower 8-bit set first and 
                ;   the upper 5.bit is set. Therefore, 13-bit data in total can 
                ;   be set.

; ------------------------------------------------------------------------------
; Address for CG-RAM read and write --------------------------------------------
; ------------------------------------------------------------------------------
CGADD = $2121   ; CG-Ram Data (Low, High)
                ; * This is the color generator to be written at any address of
                ;   the CG-Ram
                ; * The mapping of BG1 - BG4 and OBJ data in the CG-Ram will be 
                ;   determined, which is performed by every mode selected  by "BG
                ;   MODE" of register $2105 (BGMODE). (See page A-17)
                ; * There are the color  data  of 8 palettes for each screen of 
                ;   BG1-BG4. The palette selection is determined by 3-bit of the
                ;   SC data "COLOR." (Refer to page A-10)
                ; * Because the CG-RAM data is 15-bit/word, it is necessary to
                ;   set lower 8-bit first to this register and then upper 7-bit 
                ;   should be set, the address will be increased by 1 
                ;   automatically.
                ;
                ;   NOTE: After the address is set, the data should be written
                ;         in the order of low, then high. This is similar to the
                ;         OAM Data register.
                ;   NOTE: The data can be written during H/V BLANK or FORCED
                ;         BLANK period.

; ------------------------------------------------------------------------------
; Window Mask Setting ----------------------------------------------------------
; ------------------------------------------------------------------------------
                ;    7654      |    3210
W12SEL = $2123  ; BG2 Window   | BG1 Window
W34SEL = $2124  ; BG4 Window   | BG3 Window
WOBJSEL = $2125 ; Color Window | OBJ Window
                ; +------+------+------+------+------+------+------+------+
                ; |  7   |  6   |  5   |  4   |  3   |  2   |  1   |  0   |
                ; +------+------+------+------+------+------+------+------+
                ; |W2 EN |IN/OUT|W1 EN |IN/OUT|W2 EN |IN/OUT|W1 EN |IN/OUT|
                ; +------+------+------+------+------+------+------+------+
                ; W2 EN  - WINDOW-2 ENABLE: Window-2 ON/OFF (0: Off)
                ; W1 EN  - WINDOW-1 ENABLE: Window-1 ON/OFF (1: On )
                ; IN/OUT - WINDOW IN/OUT: The window mask area can be designated
                ;                         whether inside or outside of the frame
                ;                         designated by the window position.
                ;                                       IN             OUT
                ;                         0: In    +---+---+---+  +---+---+---+
                ;                         1: Out   | * |###| * |  |###| * |###|
                ;                                  |   |###|   |  |###|   |###|
                ;                  *: DISPLAY AREA +---+---+---+  +---+---+---+
                ;                               |    ^       ^
                ;                               +----+-------+
                ; The COLOR WINDOW is a window for main and sub screen. (It is
                ; related to the register $2130 (TODO)).
                ;

; ------------------------------------------------------------------------------
; Window Position Designation (Refer to page A-18) -----------------------------
; ------------------------------------------------------------------------------
WH0 = $2126     ; Window-1 Left Position Designation.  (0-255)
WH1 = $2127     ; Window-1 Right Position Designation. (0-255)
WH2 = $2128     ; Window-2 Left Position Designation.  (0-255)
WH3 = $2129     ; Window-2 Right Position Designation. (0-255)
                ; 
                ; NOTE: If 'LEFT POSITION SETTING VALUE> RIGHT POSITION VALUE"
                ;       is assumed, there will be no range of the window.

; ------------------------------------------------------------------------------
; Mask Logic Setting For Window-1 & 2 On Each Screen ---------------------------
; ------------------------------------------------------------------------------
