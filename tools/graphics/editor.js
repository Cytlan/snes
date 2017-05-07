// ------------------------------------------------------------------------------
// Tile editor
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

var canvas = document.getElementById('tile_editor');

//var terminal = document.getElementById('terminal');
function log(str)
{
	//terminal.innerHTML += str + "\n";
	console.log(str);
}

log("Started");

var pal = new Palette();

var win = new Window();
win.setCanvas(canvas);

win.addRow(1, 64);
win.addRow(3, 1);
win.addRow(1, 64);

var applicationPanel = new ApplicationPanel({float: 'top', weight: 4, width: 0, background: '#222222'});
win.attach(0, applicationPanel);

var statusPanel = new StatusPanel({float: 'bottom', weight: 3, width: 0, background: '#222222'});
win.attach(2, statusPanel);

var palettePanel = new PalettePanel({float: 'right', weight: 2, width: 600, background: '#0000FF'});
win.attach(1, palettePanel);

var chrPanel = new ChrPanel({float: 'right', weight: 1});
win.attach(1, chrPanel);

window.addEventListener('resize', function(){
	resizeWindow();
}, true);

function resizeWindow()
{
	var width = document.documentElement.clientWidth;
	var height = document.documentElement.clientHeight;
	win.rows[1].height = height - win.rows[0].height - win.rows[2].height;
	win.resize(width, height);
}
resizeWindow();

function getRender()
{
	win.renderFrame();
	window.requestAnimationFrame(getRender);
}
getRender();