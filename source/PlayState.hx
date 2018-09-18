package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.ui.FlxButton;
import flixel.addons.display.FlxZoomCamera;
import flixel.FlxCamera;
import flixel.addons.editors.tiled.TiledMap;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.tile.FlxBaseTilemap;
import flixel.FlxObject;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.util.FlxStringUtil;

class PlayState extends FlxState
{
	var _player: Player;
	//var _zoomCam:FlxZoomCamera;
	var _map:TiledMap;
	var _mWalls:FlxTilemap;
	private var timeTxt:FlxText;
    public var countdown:Float = 120;
	override public function create():Void
	{
		_player = new Player(144,144);
		_map = new TiledMap(AssetPaths.TestTileMap__tmx);
		_mWalls = new FlxTilemap();
		_mWalls.loadMapFromArray(cast(_map.getLayer("Tile1"), TiledTileLayer).tileArray, _map.width, _map.height, AssetPaths.tset__png, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 3);
		_mWalls.follow();
		_mWalls.setTileProperties(1, FlxObject.ANY);
		_mWalls.setTileProperties(2, FlxObject.NONE);
		_mWalls.setTileProperties(3, FlxObject.ANY);
		_mWalls.setTileProperties(4, FlxObject.ANY);

		add(_mWalls);
		//var cam:FlxCamera = FlxG.camera;
		//_zoomCam = new FlxZoomCamera(Std.int(cam.x), Std.int(cam.y), cam.width, cam.height, cam.zoom);
		//_zoomCam.follow(_player, TOPDOWN, 1);
		//FlxG.cameras.reset(_zoomCam);
		//_zoomCam.targetZoom += 1;

		FlxG.camera.follow(_player, TOPDOWN,1);
		super.create();
		
		timeTxt = new FlxText(0,0,100);
		add(timeTxt);
		add(_player);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		FlxG.collide(_player,_mWalls);
		countdown-= FlxG.elapsed;
		timeTxt.text = FlxStringUtil.formatTime(countdown);
	}
}