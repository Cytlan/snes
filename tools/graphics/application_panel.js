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
	this.weight = options.weight;
	this.background = options.background || '#000000';

	this.menuItems = [
		{text: "File", size: 0, hover: false},
		{text: "Edit", size: 0, hover: false},
		{text: "View", size: 0, hover: false},
	];
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

		if(mi.hover)
		{
			this.win.ctx.fillStyle = "#555555";
			this.win.ctx.fillRect(cx, this.y, totalWidth, this.height);
		}

		this.win.ctx.fillStyle = "#AAAAAA";
		this.win.ctx.fillText(mi.text, cx + (totalWidth / 2), this.y + (this.height / 2));

		cx += totalWidth;
	}

}
