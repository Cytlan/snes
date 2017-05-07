// ------------------------------------------------------------------------------
// Tile editor - Status panel
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

function StatusPanel(options)
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
}

StatusPanel.prototype.setWindow = function(win)
{
	this.win = win;
}

StatusPanel.prototype.render = function()
{
	this.win.ctx.fillStyle = this.background;
	this.win.ctx.fillRect(this.x, this.y, this.win.width, this.height);
}
