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
	this.width = 600;
	this.height = 300;

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
}