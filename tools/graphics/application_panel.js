// ------------------------------------------------------------------------------
// Tile editor - Application panel
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

function ApplicationPanel(options)
{
	this.floatLeft = options.float == 'left';
	this.floatRight = options.float == 'right';
	this.floatTop = options.float == 'top';
	this.floatBottom = options.float == 'bottom';
	this.width = options.width;
	this.height = options.height;
	this.autoWidth = this.width == 0;
	this.x = 0;
	this.y = 0;
	this.z = 0;
	this.weight = options.weight;
	this.background = options.background || '#000000';
	this.win = null;

	this.currentMenu = null;
	this.openMenuItem = null;

	this.sticky = false;

	var that = this;
	var fileMenu = [
		{text: "Open CHR", x: 0, y: 0, width: 0, height: 0, size: 0, hover: false, func: function(){ that.loadChr() }},
		{text: "Save CHR", x: 0, y: 0, width: 0, height: 0, size: 0, hover: false},
		{text: "Open Nametable", x: 0, y: 0, width: 0, height: 0, size: 0, hover: false},
	];

	var editMenu = [
		{text: "Copy",        x: 0, y: 0, width: 0, height: 0, size: 0, hover: false},
		{text: "Paste",       x: 0, y: 0, width: 0, height: 0, size: 0, hover: false},
		{text: "Swap colors", x: 0, y: 0, width: 0, height: 0, size: 0, hover: false},
		{text: "Fill",        x: 0, y: 0, width: 0, height: 0, size: 0, hover: false},
	];

	this.menuItems = [
		{text: "File", x: 0, y: 0, width: 0, height: 0, size: 0, hover: false, menuOpen: false, contextMenu: fileMenu},
		{text: "Edit", x: 0, y: 0, width: 0, height: 0, size: 0, hover: false, menuOpen: false, contextMenu: editMenu},
		{text: "View", x: 0, y: 0, width: 0, height: 0, size: 0, hover: false, menuOpen: false, contextMenu: fileMenu},
	];

}

ApplicationPanel.prototype.loadChr = function()
{
	this.closeMenu();
	var that = this;
	this.win.getFile(function(file)
	{
		that.win.event('openchr', {file: file});
	});
}

ApplicationPanel.prototype.closeMenu = function()
{
	this.openMenuItem.menuOpen = false;
	this.win.detach(this.currentMenu);
	this.currentMenu = null;
}

ApplicationPanel.prototype.event = function(type, data)
{
	if(type == 'mousemove' || type == 'mousedown' || type == 'mouseup')
	{
		if(data.y < this.height)
		{
			for(var i in this.menuItems)
			{
				var mi = this.menuItems[i];
				if(!data.consumed && data.x > mi.x && data.x < (mi.x + mi.width))
				{
					if(type == 'mouseup' || this.currentMenu)
					{
						this.sticky = true;
						data.consumed = true;
					}
					if(type == 'mousedown' || this.currentMenu)
					{
						if(!mi.menuOpen && mi.contextMenu)
						{
							if(this.currentMenu)
								this.closeMenu();
							var cm = new ContextMenu({x: mi.x, y: mi.y + mi.height, menu: mi.contextMenu, parent: this});
							mi.menuOpen = true;
							this.currentMenu = cm;
							this.openMenuItem = mi;
							this.win.attach(cm);
						}
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
		if(!data.consumed)
		{
			if(this.currentMenu && type == 'mouseup' && this.sticky && !(
				data.y >= this.currentMenu.y && data.y <= this.currentMenu.y + this.currentMenu.height &&
				data.x >= this.currentMenu.x && data.x <= this.currentMenu.x + this.currentMenu.width
			))
				this.closeMenu();
		}
	}
}

ApplicationPanel.prototype.setWindow = function(win)
{
	this.win = win;
}

ApplicationPanel.prototype.render = function()
{
	this.win.ctx.fillStyle = this.background;
	this.win.ctx.fillRect(this.x, this.y, this.win.width, this.height);

	var cx = this.x;
	for(var i in this.menuItems)
	{
		var mi = this.menuItems[i];
		this.win.ctx.font = '18px sans';
		this.win.ctx.textBaseline = 'middle';
		this.win.ctx.textAlign = 'center';
		var size = this.win.ctx.measureText(mi.text).width;
		var totalWidth = size + 32;

		if(mi.hover || mi.menuOpen)
		{
			this.win.ctx.fillStyle = "#555555";
			this.win.ctx.fillRect(cx, this.y, totalWidth, this.height);
		}

		this.win.ctx.fillStyle = "#AAAAAA";
		mi.x = cx;
		mi.width = totalWidth;
		mi.height = this.height;
		this.win.ctx.fillText(mi.text, mi.x + (totalWidth / 2), this.y + (this.height / 2));

		cx += totalWidth;
	}

}
