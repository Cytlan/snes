// ------------------------------------------------------------------------------
// Tile editor - CHR panel
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

function ChrPanel()
{
	this.win = null;
	this.x = 0;
	this.y = 0;
	this.z = 0;
	this.width = 600;
	this.height = 0;

	this.zoom = 3;
	this.columns = 16;
	this.type = 1; // 0: 1bpp, 2: 2bpp, 3: 4bpp

	this.curTileX = 0;
	this.curTileY = 0;

	this.chr = null;
}

ChrPanel.prototype.event = function(type, data)
{
	if(type == 'openchr')
	{
		data.consumed = true;
		
		var numTiles = (data.file.size >> 3) >> this.type;
		var mask = (1 << (3 + this.type)) - 1;
		if(data.file.size & mask)
		{
			console.log("Invalid file size");
			return;
		}
		var that = this;
		this.win.event('getpalette', {callback: function(palette)
		{
			that.chr = new CHR();
			that.chr.setWindow(that.win);
			that.chr.setData(data.file.data, that.type);
			that.chr.renderChrmap(palette);
			that.win.dirty(that);
		}});
	}
	else if(type == 'mousemove')
	{
		if( this.chr &&
			data.x >= this.chr.x && data.x <= this.chr.x + this.chr.width &&
			data.y >= this.chr.y && data.y <= this.chr.y + this.chr.height
		)
		{
			var tilex = ((data.x - this.chr.x) / this.chr.zoom) >> 3;
			var tiley = ((data.y - this.chr.y) / this.chr.zoom) >> 3;

			if(this.curTileX != tilex || this.curTileY != tiley)
			{
				this.curTileX = tilex;
				this.curTileY = tiley;
				this.win.dirty(this);
			}
		}
		else if(this.curTileX >= 0 || this.curTileY >= 0)
		{
			this.curTileX = -1;
			this.curTileY = -1;
			this.win.dirty(this);
		}
	}
}

ChrPanel.prototype.setWindow = function(win)
{
	this.win = win;
}

ChrPanel.prototype.render = function()
{
	// Align right
	this.x = this.win.width - this.width - 300;

	// Background
	this.win.ctx.fillStyle = "#383838";
	this.win.ctx.fillRect(this.x, this.y, this.width, this.height);

	// Title
	this.win.ctx.fillStyle = "#888888";
	this.win.ctx.font = '26px monospace';
	this.win.ctx.textAlign = 'center';
	this.win.ctx.fillText('chr rom', this.x + this.width / 2, this.y + 30, this.width);

	if(this.chr)
	{
		var x = this.x + (this.width / 2) - (this.chr.width / 2);
		var y = this.y + 100;
		this.chr.x = x;
		this.chr.y = y;
		this.win.ctx.putImageData(this.chr.img, x, y);

		if(this.curTileX >= 0 || this.curTileY >= 0)
		{
			this.win.ctx.strokeStyle = '#FFFFFF';
			this.win.ctx.setLineDash([5, 5]);
			this.win.ctx.lineWidth = 1;
			this.win.ctx.strokeRect(
				this.chr.x + (this.curTileX * 8 * this.chr.zoom) - 1,
				this.chr.y + (this.curTileY * 8 * this.chr.zoom) - 1,
				(8 * this.chr.zoom) + 2,
				(8 * this.chr.zoom) + 2
			);
		}
	}
}