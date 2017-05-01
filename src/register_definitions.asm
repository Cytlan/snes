; ------------------------------------------------------------------------------
; SNES Register Definitions
; 
; Author: Wkter/Sideways-Sanae
; Date:   03.04.2013 (DD.MM.YYYY)
;
; License: Simplified BSD 2-Clause License
;          (See License.txt)
; 
; ------------------------------------------------------------------------------

; ------------------------------------------------------------------------------
; PPU Registers ----------------------------------------------------------------
; ------------------------------------------------------------------------------
.EXPORT INIDISP   , OBJSEL    , OAMADDR   , OAMADDL   , OAMADDH   , WROAMDATA
.EXPORT BGMODE    , MOSAIC    , BG1SC     , BG2SC     , BG3SC     , BG4SC
.EXPORT BG12NBA   , BG34NBA   , BG1HOFS   , BG1VOFS   , BG2HOFS   , BG2VOFS
.EXPORT BG3HOFS   , BG3VOFS   , BG4HOFS   , BG4VOFS   , VMAINC    , VMADDR
.EXPORT VMADDL    , VMADDH    , WRVMDATA  , WRVMDATAL , WRVMDATAH , M7SEL
.EXPORT M7A       , M7B       , M7C       , M7D       , M7X       , M7Y
.EXPORT CGADD     , WRCGDATA  , W12SEL    , W34SEL    , WOBJSEL   , WH0
.EXPORT WH1       , WH2       , WH3       , WBGLOG    , WOBJLOG   , TM
.EXPORT TS        , TMW       , TSW       , CGSWSEL   , CGADSUB   , COLDATA
.EXPORT SETINI    , MPYL      , MPYM      , MPYH      , SLHV      , RDOAMDATA
.EXPORT RDVMDATA  , RDVMDATAL , RDVMDATAH , RDCGDATA  , OPHCT     , OPVCT
.EXPORT STAT77    , STAT78    , APUIO0    , APUIO1    , APUIO2    , APUIO3
.EXPORT WMDATA    , WMADDR    , WMADDL    , WMADDH

; ------------------------------------------------------------------------------
; CPU Registers ----------------------------------------------------------------
; ------------------------------------------------------------------------------
.EXPORT NMITIMEN  , WRIO      , WRMPYA    , WRMPYB    , WRDIVL    , WRDIVH
.EXPORT WRDIVB    , HTIMEL    , HTIMEH    , VTIMEL    , VTIMEH    , MDMAEN
.EXPORT HDMAEN    , MEMSEL    , RDNMI     , TIMEUP    , HVBJOY    , RDIO
.EXPORT RDDIVL    , RDDIVH    , RDMPYL    , RDMPYH    , STDCNTRL1L, STDCNTRL1H
.EXPORT STDCNTRL2L, STDCNTRL2H, STDCNTRL3L, STDCNTRL3H, STDCNTRL4L, STDCNTRL4H

; ------------------------------------------------------------------------------
; List of Abbreviations and Terms ----------------------------------------------
; ------------------------------------------------------------------------------
;    ADPCM - Adaptive Differential PCM
;    APU   - Audio Processing Unit
;    BG    - Background
;    BBR   - Bit Rate Reduction
;    CG    - Color Generator
;    CHR   - Character (Refers to graphic tiles, not in-game characters)
;    DAC   - Digital to Analog Converter (Converts the digital audio to analog)
;    DMA   - Direct Memory Access (Fast memory transfer to the PPU)
;    DSP   - Digital Signal Processor (Produces the actual digital audio)
;    H-DMA - Horizontal DMA (DMA transfer on every H-Blank)
;    H/V   - Horizontal/Vertical
;    IC    - Integrated Circuit (A microchip)
;    IPL   - Initial Program Loader (The APU bootloader ROM)
;    IRQ   - Interrupt Request
;    NMI   - Non-Maskable Interrupt (Interrupt cannot be ignored)
;    OAM   - Object Attribute Memory (Objects/Sprites are stored here)
;    OBJ   - Object (Sprites)
;    PCM   - Pulse Code Modulated (Sound samples/Waveform)
;    PPU   - Picture Processing Unit (The SNES GPU)
;    PSW   - Program Status Word
;    SC    - Screen? TODO: Find out what this really is...
;    SRAM  - Static RAM, used for battery backed RAM
;    VRAM  - Video RAM, used by the PPU
;    WRAM  - Work RAM, used by the CPU
; 
;    S-PPU        - The SNES PPU
;    S-CPU        - The SNES CPU       (Do not confuse with the Sound-CPU!)
;    Sound-CPU    - The CPU of the APU (Never written as 'S-CPU' or 'SCPU'!)
;    Scanline     - Horizontal line on the TV
;    Blanking     - PPU is not rendering a picture.
;    H-Blank      - Horizontal blank, when the beam moves to the next scanline.
;    V-Blank      - Vertical blank, time between finished frame and next frame.
;    Forced Blank - PPU is disabled by the game on runtime.
; 
; Note: VRAM, OAM and CGRAM may only be accessed during blanking.
; 
; Note: Unless otherwise specified, write twice registers are to be written in
;       the order of Low byte, then High byte.

; ------------------------------------------------------------------------------
; PPU Registers ----------------------------------------------------------------
; ------------------------------------------------------------------------------

; Screen settings
INIDISP   = $2100

; Object settings
OBJSEL    = $2101

; OAM Address
OAMADDR   = $2102
OAMADDL   = $2102
OAMADDH   = $2103

; OAM Data (Write twice for 16-bit data)
WROAMDATA = $2104

; Background mode
BGMODE    = $2105

; Mosaic effect settings
MOSAIC    = $2106

; Background address
BG1SC     = $2107
BG2SC     = $2108
BG3SC     = $2109
BG4SC     = $210A

; Background data VRAM address
BG12NBA   = $210B
BG34NBA   = $210C

; Background Horizontal/Vertical offsets
BG1HOFS   = $210D
BG1VOFS   = $210E
BG2HOFS   = $210F
BG2VOFS   = $2110
BG3HOFS   = $2111
BG3VOFS   = $2112
BG4HOFS   = $2113
BG4VOFS   = $2114

; VRAM increment mode
VMAINC    = $2115

; VRAM address
VMADDR    = $2116
VMADDL    = $2116
VMADDH    = $2117

; Data for VRAM write
WRVMDATA  = $2118
WRVMDATAL = $2118
WRVMDATAH = $2119

; Mode-7 math registers
M7SEL     = $211A
M7A       = $211B
M7B       = $211C
M7C       = $211D
M7D       = $211E
M7X       = $211F
M7Y       = $2120

; Color generator something... TODO: Fill this
CGADD     = $2121

; Data for CG-RAM write
WRCGDATA  = $2122

; Window selection and settings
W12SEL    = $2123
W34SEL    = $2124
WOBJSEL   = $2125

; Window positions
WH0       = $2126
WH1       = $2127
WH2       = $2128
WH3       = $2129

; Windows masking
WBGLOG    = $212A
WOBJLOG   = $212B

; Main screen selection
TM        = $212C

; Sub screen selection
TS        = $212D

; Main screen window selection
TMW       = $212E

; Sub screen window selection
TSW       = $212F

; Fixed color addition / Screen addition settings
CGSWSEL   = $2130

; Addition/Subtraction and subtraction for each BG
CGADSUB   = $2131

; Fixed color data for fixed addition / subtraction
COLDATA   = $2132

; Screen initial settings
SETINI    = $2133

; Multiplication result
MPYL      = $2134
MPYM      = $2135
MPYH      = $2136

; Software latch for H/V counter
SLHV      = $2137

; Read data from OAM
RDOAMDATA = $2138

; Read data from VRAM
RDVMDATA  = $2139
RDVMDATAL = $2139
RDVMDATAH = $213A

; Read data from CGRAM
RDCGDATA  = $213B

; H/V Counter data
OPHCT     = $213C
OPVCT     = $213D

; PPU Status flag and version number
STAT77    = $213E
STAT78    = $213F

; Communication port with APU
APUIO0    = $2140
APUIO1    = $2141
APUIO2    = $2142
APUIO3    = $2143

; Data to consecutively read and write to WRAM
WMDATA    = $2180

; Address to consecutively read and write WRAM
WMADDR    = $2181
WMADDL    = $2182
WMADDH    = $2183

; ------------------------------------------------------------------------------
; CPU Registers ----------------------------------------------------------------
; ------------------------------------------------------------------------------

; NMI enable, Timer enable and Standard Controller enable
NMITIMEN = $4200

; Programmable I/O Port Out
WRIO     = $4201

; Multiplier and Multiplicand by Multiplication
WRMPYA   = $4202
WRMPYB   = $4203

; Divisor and Dividend by Divide
WRDIVL   = $4204
WRDIVH   = $4205
WRDIVB   = $4206

; H-Count timer settings
HTIMEL   = $4207
HTIMEH   = $4208

; V-Count timer settings
VTIMEL   = $4209
VTIMEH   = $420A

; General purpose DMA enable flags
MDMAEN   = $420B

; H-DMA enable flags
HDMAEN   = $420C

; Fast Memory enable
MEMSEL   = $420D

; V-Blank NMI flag and CPU version number
RDNMI    = $4210

; H/V timer IRQ enable
TIMEUP   = $4211

; H/V blank flag and standard controller enable
HVBJOY   = $4212

; Programmable I/O Port In
RDIO     = $4213

; Quotient of divide result
RDDIVL   = $4214
RDDIVH   = $4215

; Product of multiplication result or remainder of divide result
RDMPYL   = $4216
RDMPYH   = $4217

; Data for standard controller 1-4
STDCNTRL1L = $4218
STDCNTRL1H = $4219
STDCNTRL2L = $421A
STDCNTRL2H = $421B
STDCNTRL3L = $421C
STDCNTRL3H = $421D
STDCNTRL4L = $421E
STDCNTRL4H = $421F

; EOF --------------------------------------------------------------------------