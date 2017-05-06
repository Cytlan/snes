// ------------------------------------------------------------------------------
// Tile editor - Color
//
// Copyright (c) 2017, Cytlan, Shibesoft AS
//
// This is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
//
// ------------------------------------------------------------------------------

//
// Color
//
function Color()
{
	// 5 bits per channel:
	// 0bbbbbgg gggrrrrr
	this.color = 0;
}

Color.prototype.setRed = function(r)
{
	this.color &= ~0x1F;
	this.color |= (r >> 3) & 0x1F;
}

Color.prototype.setGreen = function(g)
{
	this.color &= ~(0x1F << 5);
	this.color |= ((g >> 3) & 0x1F) << 5;
}

Color.prototype.setBlue = function(b)
{
	this.color &= ~(0x1F << 10);
	this.color |= ((b >> 3) & 0x1F) << 10;
}

Color.prototype.setColor = function(c)
{
	if(typeof c == "string")
		c = parseInt(c, 16);
	var r = (c >> (16+3)) & 0x1F;
	var g = (c >> ( 8+3)) & 0x1F;
	var b = (c >>     3)  & 0x1F;

	this.color = (b << 10) + (g << 5) + r;
}

Color.prototype.to24Bit = function()
{
	var c = 0xFF / 0x1F;
	var b = (((this.color >>  10) & 0x1F) * c) & 0xFF;
	var g = (((this.color >>   5) & 0x1F) * c) & 0xFF;
	var r = (( this.color         & 0x1F) * c) & 0xFF;

	return (r << 16) + (g << 8) + b;
}

Color.prototype.toHex = function()
{
	var hex = "0123456789abcdef";
	var b = (((this.color >>  10) & 0x1F) << 3) & 0xFF;
	var g = (((this.color >>   5) & 0x1F) << 3) & 0xFF;
	var r = (( this.color         & 0x1F) << 3) & 0xFF;
	var str = 
		hex[(r >> 4) & 0xF] + hex[r & 0xF] +
		hex[(g >> 4) & 0xF] + hex[g & 0xF] +
		hex[(b >> 4) & 0xF] + hex[b & 0xF];
	return str;
}