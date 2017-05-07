// ------------------------------------------------------------------------------
// Tile editor - Context Menu
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

function ContextMenu(options)
{
	this.width = options.width || 0;
	this.height = options.height || 0;
	this.autoWidth = this.width == 0;
	this.autoHeight = this.height == 0;
	this.x = options.x || 0;
	this.y = options.y || 0;
	this.z = options.z || 0;
	this.background = options.background || '#000000';
	this.win = null;
	this.parent = options.parent;

	this.menuItems = options.menu;
}

ContextMenu.prototype.setWindow = function(win)
{
	this.win = win;
}

ContextMenu.prototype.event = function(type, data)
{
	if(type == 'mousemove' || type == 'mouseup')
	{
		if(data.x >= this.x && data.x <= this.x + this.width)
		{
			for(var i in this.menuItems)
			{
				var mi = this.menuItems[i];
				if(!data.consumed && data.y >= mi.y && data.y <= mi.y + mi.height)
				{
					if(type == 'mouseup')
					{
						this.parent.closeMenu();
						mi.func();
					}
					else if(type == 'mousemove')
					{
						if(!mi.hover)
							this.win.dirty(this);
						mi.hover = true;
					}
					data.consumed = true;
				}
				else
				{
					if(mi.hover)
						this.win.dirty(this);
					mi.hover = false;
				}
			}
		}
		else
		{
			for(var i in this.menuItems)
			{
				var mi = this.menuItems[i];
				if(mi.hover)
					this.win.dirty(this);
				mi.hover = false;
			}
		}
	}
}

ContextMenu.prototype.render = function()
{
	var itemHeight = 32;
	var totalWidth = 0;
	this.win.ctx.font = '18px sans';
	this.win.ctx.textBaseline = 'middle';
	this.win.ctx.textAlign = 'left';
	for(var i in this.menuItems)
	{
		var mi = this.menuItems[i];
		var size = this.win.ctx.measureText(mi.text).width;
		if(size > totalWidth)
			totalWidth = size;
	}
	totalWidth += itemHeight;

	this.width = totalWidth;
	this.height = itemHeight * this.menuItems.length;
	this.win.ctx.fillStyle = "#222222";
	this.win.ctx.fillRect(this.x, this.y, this.width, this.height);

	var cy = this.y;
	for(var i in this.menuItems)
	{
		var mi = this.menuItems[i];
		if(mi.hover || mi.menuOpen)
		{
			this.win.ctx.fillStyle = "#555555";
			this.win.ctx.fillRect(this.x, cy, this.width, itemHeight);
		}

		this.win.ctx.fillStyle = "#AAAAAA";
		mi.x = this.x;
		mi.y = cy;
		mi.width = this.width;
		mi.height = itemHeight;
		this.win.ctx.fillText(mi.text, mi.x + (itemHeight / 2), cy + (itemHeight / 2));

		cy += itemHeight;
	}
}