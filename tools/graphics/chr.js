// ------------------------------------------------------------------------------
// Tile editor - CHR
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

function CHR()
{
	this.data = null;
	this.numberOfTiles = 0;
	this.bpp = 0;

	this.win = null;

	this.width = 0;
	this.height = 0;

	this.chrmap1to1 = null;
	this.img = null;
	this.zoom = 3;
}

CHR.prototype.setWindow = function(win)
{
	this.win = win;
}

CHR.prototype.setData = function(data, bpp)
{
	var numTiles = (data.byteLength >> 3) >> bpp;
	var mask = (1 << (3 + bpp)) - 1;
	if(data.byteLength & mask)
	{
		console.log("Invalid file size");
		return;
	}
	this.data = data;
	this.bpp = bpp;
	this.numberOfTiles = numTiles;
}

CHR.prototype.renderChrmap = function(palette)
{
	var imageWidth = 8 * 16;
	var imageHeight = (this.numberOfTiles / 16) * 8;
	this.chrmap1to1 = this.win.ctx.createImageData(imageWidth, imageHeight);
	var pixeldata = this.chrmap1to1.data;

	var tileSize = 1 << (this.bpp + 3);
	var bits = 1 << this.bpp;

	var width = imageWidth * 4;

	// For all tiles
	for(var i = 0; i < this.numberOfTiles; i++)
	{
		var x = i & 0xF
		var y = i >> 4;

		// For all rows in tile
		for(var j = 0; j < 8; j++)
		{
			// Fetch all bytes that makes up 1 row
			var line = [];
			for(var k = 0; k < bits; k++)
				line.push(this.data[(i * tileSize) + (j * bits) + k]);

			// For all pixels in a row
			for(var k = 0; k < 8; k++)
			{
				var index = 0;
				for(var l = 0; l < bits; l++)
					index |= ((line[l] >> (7 - k)) & 1) << l;

				var color = palette.color(index).to24Bit();

				// Draw pixel
				var offset = ((y * width * 8) + (j * width)) + (x * 4 * 8) + (k * 4);
				pixeldata[offset + 0] = (color >> 16) & 0xFF
				pixeldata[offset + 1] = (color >> 8) & 0xFF
				pixeldata[offset + 2] = color & 0xFF;
				pixeldata[offset + 3] = 0xFF
			}
		}
	}

	this.img = this.scale();
}

CHR.prototype.scale = function()
{
	var pixels     = this.chrmap1to1.data;
	var srcWidth   = this.chrmap1to1.width;
	var srcHeight  = this.chrmap1to1.height;
	var width      = srcWidth * this.zoom;
	var height     = srcHeight * this.zoom;
	var dest       = this.win.ctx.createImageData(width, height);
	var destPixels = dest.data;

	this.width = width;
	this.height = height;

	var xFactor = srcWidth / width;
	var yFactor = srcHeight / height;
	var dstIndex = 0, srcIndex;
	var x, y, offset;

	for (y = 0; y < height; y += 1) {
		offset = ((y * yFactor) | 0) * srcWidth;

		for (x = 0; x < width; x += 1) {
			srcIndex = (offset + x * xFactor) << 2;

			destPixels[dstIndex]     = pixels[srcIndex];
			destPixels[dstIndex + 1] = pixels[srcIndex + 1];
			destPixels[dstIndex + 2] = pixels[srcIndex + 2];
			destPixels[dstIndex + 3] = pixels[srcIndex + 3];
			dstIndex += 4;
		}
	}

	return dest;
}
