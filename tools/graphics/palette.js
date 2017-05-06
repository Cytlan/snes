// ------------------------------------------------------------------------------
// Tile editor - Palette
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
// Palette
//
function Palette()
{
	this.colors = [];
	for(var i = 0; i < 16; i++)
		this.colors[i] = new Color();
}

Palette.prototype.setColor = function(index, color)
{
	this.colors[index].setColor(color);
	return this.colors[index];
}

Palette.prototype.getColor = function(index)
{
	return this.colors[index];
}

Palette.prototype.color = function(index, color)
{
	if(color === undefined || color === null)
		return this.getColor(index);
	else
		return this.setColor(index, color);
}
