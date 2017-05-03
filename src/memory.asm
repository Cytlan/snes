; ------------------------------------------------------------------------------
; Memory
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

.segment "ZEROPAGE"

.macro MEM_RESZP label, size
   .ifdef RAM_EXPORT
      label: .res size
      .exportzp label
   .else
      .importzp label
   .endif
.endmacro

.macro MEM_RES label, size
   .ifdef RAM_EXPORT
      label: .res size
      .export label
   .else
      .import label
   .endif
.endmacro

MEM_RESZP i, 1
MEM_RESZP j, 1
MEM_RESZP k, 1
MEM_RESZP l, 1

