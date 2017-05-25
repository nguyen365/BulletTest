package;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.math.FlxRect;
using flixel.util.FlxSpriteUtil;

class HUD extends FlxTypedGroup<FlxSprite> {
	private var TileSizeX = 160;
	private var TileSizeY = 16;

	// The coor's and dimens refers to the viewbox. 
	public function new(?X_START:Int, ?Y_START:Int, 
		?WIDTH:Int, ?HEIGHT:Int) {
		super();
		fill(0, 0, FlxG.width, Y_START);
		fill(0, Y_START, X_START, HEIGHT);
		fill(X_START + WIDTH, Y_START, FlxG.width - (X_START + WIDTH), HEIGHT);
		fill(0, Y_START + HEIGHT, FlxG.width, FlxG.height - (Y_START + HEIGHT));

		forEach(function(spr:FlxSprite)
         {
             spr.scrollFactor.set(0, 0);
         });
	}

	private function fill(?X_START:Int, ?Y_START:Int,
		?WIDTH:Int, ?HEIGHT:Int):Void {
		var curr_x:Int = X_START;
		var curr_y:Int = Y_START;
		var X_END = X_START + WIDTH;
		var Y_END = Y_START + HEIGHT;
		while (curr_y < Y_END) {
			while (curr_x < X_END) {
				var tile_width:Int = 0;
				var tile_height:Int = 0;
				if (curr_x + TileSizeX < X_END) {
					tile_width = TileSizeX;
				}
				else {
					tile_width = X_END - curr_x;
				}
				if (curr_y + TileSizeY < Y_END) {
					tile_height = TileSizeY;
				}
				else {
					tile_height = Y_END - curr_y;
				}
				var tile:FlxSprite = new FlxSprite(curr_x,curr_y);
				tile.loadGraphic(AssetPaths.SidebarTile__png,false,tile_width,tile_height);
				tile.clipRect = new FlxRect(0,0,tile_width,tile_height);
				add(tile);
				curr_x = curr_x + TileSizeX;
			}
			curr_x = X_START;
			curr_y = curr_y + TileSizeY;
		}
	}
}