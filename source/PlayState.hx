package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.ui.FlxButton;
import flixel.addons.display.FlxZoomCamera;
import flixel.FlxCamera;
import flixel.addons.editors.tiled.TiledMap;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.tile.FlxBaseTilemap;
import flixel.FlxObject;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.util.FlxStringUtil;
import flixel.util.FlxColor;
import flixel.group.FlxGroup;
import flixel.system.FlxSound;

class PlayState extends FlxState
{
	var _player: Player;
	var _zoomCam:FlxZoomCamera;
	var _map:TiledMap;
	var _mWalls:FlxTilemap;
	var myText:FlxText;
	private var timeTxt:FlxText;
    public var countdown:Float = 120;
	private var pil:FlxTypedGroup<Pillar>;
	private var swi:FlxTypedGroup<Switch>;
	private var ppl:FlxTypedGroup<PPlate>;
	public var cur_x:Int;
	public var cur_y:Int;
	public var cur_room:Int;
	public var theme:FlxSound;
	override public function create():Void
	{
		theme = FlxG.sound.load(AssetPaths.theme__wav);
		theme.looped = true;
		theme.play();
		cur_room = 0;
		pil = new FlxTypedGroup<Pillar>(10);
		swi = new FlxTypedGroup<Switch>(10);
		ppl = new FlxTypedGroup<PPlate>(10);

		FlxG.mouse.visible = false;
		_player = new Player();
		_map = new TiledMap(AssetPaths.TestTileMap1__tmx);
		_mWalls = new FlxTilemap();
		_mWalls.loadMapFromArray(cast(_map.getLayer("Tile1"), TiledTileLayer).tileArray, _map.width, _map.height, AssetPaths.everything__png, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 3);
		_mWalls.follow();
		_mWalls.setTileProperties(1, FlxObject.ANY);
		_mWalls.setTileProperties(2, FlxObject.NONE);
		_mWalls.setTileProperties(3, FlxObject.ANY);
		_mWalls.setTileProperties(4, FlxObject.ANY);

		add(_mWalls);
		var cam:FlxCamera = FlxG.camera;
		_zoomCam = new FlxZoomCamera(Std.int(cam.x), Std.int(cam.y), cam.width, cam.height, cam.zoom);
		_zoomCam.follow(_player, TOPDOWN, 1);
		FlxG.cameras.reset(_zoomCam);
		_zoomCam.targetZoom += 1;

		//FlxG.camera.follow(_player, TOPDOWN,1);
		super.create();
		//myText = new FlxText(144, 144, 500); // x, y, width
		//myText.text = "Hello World";
		//myText.setBorderStyle(OUTLINE, FlxColor.RED, 1);
		//timeTxt = new FlxText(0,0,100);
		var tmpMap:TiledObjectLayer = cast(_map.getLayer("Mech"));
		placeEntities(tmpMap);
		
		//add(tmpMap);
		add(myText);
		add(timeTxt);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		for(s in swi){
			if(FlxG.pixelPerfectOverlap(_player,s)){
				if(FlxG.keys.justPressed.E){
					s.change();
					for(p in pil){
						if(s.col == p.col){
							p.change();
						}
					}
				}
			}
		}
		if(FlxG.keys.justPressed.R){
			_player.x = cur_x;
			_player.y = cur_y;
			for(s in swi){
				if(s.up != true){
					s.change();
				}
			}
			for(p in pil){
				if(p.up != true){
					p.change();
				}
			}
		}
		FlxG.collide(_player, pil);
		FlxG.collide(_player,_mWalls);
		countdown-= FlxG.elapsed;
		//timeTxt.text = FlxStringUtil.formatTime(countdown);
	}
	
	private function placeEntities(tmp:TiledObjectLayer):Void
	{
		for(e in tmp.objects){
			var x:Int = Std.parseInt(e.xmlData.x.get("x"));
			var y:Int = Std.parseInt(e.xmlData.x.get("y"));
			if(e.type == "pillar"){
				var p = new Pillar(x,y-16);
				p.settype(e.type);
				p.setname(e.name);
				p.setroom(Std.parseInt(e.xmlData.x.get("room")));
				p.setcolor(Std.parseInt(e.xmlData.x.get("color")));
				pil.add(p);
			}
			else if(e.type == "switch"){
				var s = new Switch(x,y-13);
				s.setcolor(Std.parseInt(e.xmlData.x.get("color")));
				s.settype(e.type);
				swi.add(s);
			}
			else if(e.type == "plate"){
				var pp = new PPlate(x,y-16);
				pp.settype(e.type);
				ppl.add(pp);
			}
			else if(e.name == "Start"){
				_player.x = x;
				_player.y = y;
				cur_x = x;
				cur_y = y;
			}
		}
		for(s in swi){
			add(s);
		}
		for(p in pil){
			add(p);
		}
		for(pp in ppl){
			add(pp);
		}
		add(_player);
	}
}