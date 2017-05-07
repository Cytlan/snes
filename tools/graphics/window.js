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

	this.rows = [];
	this.objs = [];
	this.objsSorted = false;
	this.overlay = [];

	this.topZ = 0;

	this.isDirty = true;

	this.constraints = {
		left: 0,
		right: 0,
		top: 0,
		bottom: 0,
	}

	this.fileCallback = [];
	this.fileInput = null;
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

	var win = this;
	canvas.addEventListener('mousemove', function(e)
	{
		var rect = canvas.getBoundingClientRect();
		var x = e.clientX - rect.left;
		var y = e.clientY - rect.top;
		win.event('mousemove', {x: x, y: y});
	}, false);

	canvas.addEventListener('mouseout', function(e)
	{
		var x = -1;
		var y = -1;
		win.event('mousemove', {x: x, y: y});
	}, false);

	// Add event listener for `click` events.
	canvas.addEventListener('mousedown', function(e)
	{
		var rect = canvas.getBoundingClientRect();
		var x = e.clientX - rect.left;
		var y = e.clientY - rect.top;
		var button = e.button;
		win.event('mousedown', {x: x, y: y, button: button});
	}, false);

	fileInput = document.getElementById('fileInput');
	fileInput.addEventListener('change', function(e)
	{
		win.fileCallback.pop()(e);
	}, false);

}

Window.prototype.getFile = function(callback)
{
	this.fileCallback.push(function(e)
	{
		var file = e.target.files[0];
		var fo = {name: file.name, size: file.size};

		var reader = new FileReader();
		reader.onload = function(e2)
		{
			fo.data = new Uint8Array(e2.target.result);
			callback(fo);
		}
		reader.readAsArrayBuffer(file);
	})
	fileInput.click();
}

Window.prototype.renderFrame = function()
{
	if(!this.isDirty)
		return;
	this.render();
	this.isDirty = false;
}

Window.prototype.dirty = function(obj)
{
	this.isDirty = true;
}

Window.prototype.event = function(type, data)
{
	if(!this.objsSorted)
		this.sortObjects();

	data.consumed = false;
	for(var i in this.objs)
	{
		var o = this.objs[i];
		if(o.event)
			o.event(type, data);
	}
}

Window.prototype.resize = function(width, height)
{
	this.width = width;
	this.height = height;
	canvas.width = width;
	canvas.height = height;
	win.render();
}

Window.prototype.detach = function(obj)
{
	// This function sucks
	for(var i in this.rows)
	{
		for(var j in this.rows[i].objs)
		{
			if(this.rows[i].objs[j] === obj)
				delete this.rows[i].objs[j];
		}
	}
	for(var i in this.objs)
		if(this.objs[i] === obj)
			delete this.objs[i];
	for(var i in this.overlay)
		if(this.overlay[i] === obj)
			delete this.overlay[i];
	this.dirty();
}

Window.prototype.attach = function(rowId, obj)
{
	if(typeof rowId === 'number')
	{
		this.rows[rowId].objs.push(obj);
	}
	else
	{
		obj = rowId;
		this.overlay.push(obj);
	}

	obj.setWindow(this);
	this.objs.push(obj);

	this.objsSorted = false;
	if(obj.z > this.topZ)
		this.topZ = obj.z;

	this.dirty();
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

			if(o.z > this.topZ)
				this.topZ = o.z;
		}
		curHeight += r.height;
	}

	for(var i in this.overlay)
	{
		var o = this.overlay[i];
		o.render();

		if(o.z > this.topZ)
			this.topZ = o.z;
	}
}

Window.prototype.sortObjects = function()
{
	function compare(a,b) {
		if (a.z < b.z)
			return -1;
		if (a.z > b.z)
			return 1;
		return 0;
	}

	this.objs.sort(compare);

	for(var i in this.objs)
		this.objs[i].weightIndex = i;

	this.objsSorted = true;
}
