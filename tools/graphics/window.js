// ------------------------------------------------------------------------------
// Tile editor - Window
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
// Window
//
function Window()
{
	this.width = 0;
	this.height = 0;
	this.canvas = null;
	this.ctx = null;
	this.objs = [];
	this.objsSorted = false;

	this.rows = [];

	this.constraints = {
		left: 0,
		right: 0,
		top: 0,
		bottom: 0,
	}
}

Window.prototype.addRow = function(columns, height)
{
	var rowId = this.rows.length;
	this.rows.push({columns: columns, height: height, objs: []});
	return rowId;
}

Window.prototype.setCanvas = function(canvas)
{
	this.canvas = canvas;
	this.ctx = canvas.getContext("2d");
}

Window.prototype.resize = function(width, height)
{
	this.width = width;
	this.height = height;
	canvas.width = width;
	canvas.height = height;
	win.render();
}

Window.prototype.attach = function(rowId, obj)
{
	obj.setWindow(this);
	this.objs.push(obj);
	this.rows[rowId].objs.push(obj);
	this.objsSorted = false;
}

Window.prototype.render = function()
{
	this.ctx.fillStyle = '#333333';
	this.ctx.fillRect(0, 0, this.width, this.height);

	var curHeight = 0;
	for(var i in this.rows)
	{
		var r = this.rows[i];
		for(var j in r.objs)
		{
			var o = r.objs[j];
			o.y = curHeight;
			o.height = r.height;
			o.render();
		}
		curHeight += r.height;
	}
}

Window.prototype.sortObjects = function()
{
	function compare(a,b) {
		if (a.weight < b.weight)
			return -1;
		if (a.weight > b.weight)
			return 1;
		return 0;
	}

	this.objs.sort(compare);

	for(var i in this.objs)
		this.objs[i].weightIndex = i;

	this.objsSorted = true;
}

Window.prototype.calculateSize = function(panel)
{
	if(this.objsSorted)
		this.sortObjects();

	var weight = panel.weight;

	var constraints = {
		left: 0,
		right: 0,
		top: 0,
		bottom: 0,
	}

	// Find restraints based on all objects wight more weight than us
	for(var i = panel.weightIndex + 1; i < this.objs.length; i++)
	{
		var o = this.objs[i];
		if(o.floatTop)
			constraints.top += o.height;
		if(o.floatBottom)
			constraints.bottom += o.height;
		if(o.floatLeft)
			constraints.left += o.width;
		if(o.floatRight)
			constraints.right += o.width;
	}

}
