// ------------------------------------------------------------------------------
// Tile editor - Palette panel
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

function PalettePanel()
{
	this.win = null;
	this.x = 0;
	this.y = 0;
	this.z = 0;
	this.width = 300;
	this.height = 0;

	this.palette = new Palette();
	var def = [
		// Black
			0x000000,
		// 6 Shades of Aluminium Gray
			0x2E3436, 0xEEEEEC, 0xD3D7CF, 0xBABDB6, 
			0x888A85, 0x555753,
		// Butter
			0xFCE96F, 0xEDD400,
		// Orange
			0xFCAF3E,
		// Chocolate
			0xE9B96E,
		// Chameleon
			0x8EA234, 0x73D216,
		// Sky blue
			0x729FCF,
		// Plum
			0xAD7FA8,
		// Scarlet Red
			0xEF2929,
	];
	for(var i in def)
		this.palette.color(i, def[i]);
}

PalettePanel.prototype.event = function(type, data)
{
	if(type == 'getpalette')
	{
		data.callback(this.palette);
	}
}

PalettePanel.prototype.setWindow = function(win)
{
	this.win = win;
}

PalettePanel.prototype.render = function()
{
	// Align right
	this.x = this.win.width - this.width;

	// Background
	this.win.ctx.fillStyle = "#444444";
	this.win.ctx.fillRect(this.x, this.y, this.width, this.height);

	// Title
	this.win.ctx.fillStyle = "#888888";
	this.win.ctx.font = '26px monospace';
	this.win.ctx.textAlign = 'center';
	this.win.ctx.fillText('palette', this.x + this.width / 2, this.y + 30, this.width);

	var swatchSize = this.width / 8;
	for(var i = 0; i < 16; i++)
	{
		this.win.ctx.fillStyle = "#"+this.palette.color(i).toHex();
		var x = this.x + ((i & 7) * swatchSize) + (swatchSize / 2);
		var y = this.y + 100 + (Math.floor(i / 8) * swatchSize);
		this.win.ctx.beginPath();
		this.win.ctx.arc(x, y, (swatchSize / 2) - 2, 0, 360, false);
		this.win.ctx.fill();
		//this.win.ctx.fillRect(this.x + (i * swatchSize), this.y + 100, swatchSize, swatchSize);
	}
}