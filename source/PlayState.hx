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
import flixel.addons.editors.ogmo.FlxOgmoLoader;

class PlayState extends FlxState
{
	var _player: Player;
	var _zoomCam:FlxZoomCamera;
	var _map:TiledMap;
	var _mWalls:FlxTilemap;
	var myText:FlxText;
	private var timeTxt:FlxText;
    public var countdown:Float = 100000;
	private var pil:FlxTypedGroup<Pillar>;
	private var swi:FlxTypedGroup<Switch>;
	private var ppl:FlxTypedGroup<PPlate>;
	private var pgs:FlxTypedGroup<Page>;
	private var ents:FlxTypedGroup<Start>;
	private var exts:FlxTypedGroup<Exit>;
	public var cur_x:Float;
	public var cur_y:Float;
	public var cur_room:Int;
	public var theme:FlxSound;
	public var p_name:String;
	private var tmppg:Page;
	private var tpexist:Bool;

	override public function create():Void
	{
		tpexist = false;
		theme = FlxG.sound.load(AssetPaths.theme__wav);
		theme.looped = true;
		theme.play();
		cur_room = 0;
		pil = new FlxTypedGroup<Pillar>(60);
		swi = new FlxTypedGroup<Switch>(20);
		ppl = new FlxTypedGroup<PPlate>(20);
		pgs = new FlxTypedGroup<Page>(5);
		ents = new FlxTypedGroup<Start>(5);
		exts = new FlxTypedGroup<Exit>(4);


		FlxG.mouse.visible = false;
		_player = new Player(640,640);
		_map = new TiledMap(AssetPaths.TestTileMap1__tmx);
		_mWalls = new FlxTilemap();
		_mWalls.loadMapFromArray(cast(_map.getLayer("Tile1"), TiledTileLayer).tileArray, _map.width, _map.height, AssetPaths.tset__png, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 3);
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
		_zoomCam.targetZoom += 0.5;

		super.create();
		var tmpMap:TiledObjectLayer = cast(_map.getLayer("Mech"));
		placeEntities(tmpMap);
		
		//add(tmpMap);
		add(myText);
		add(timeTxt);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		for(e in exts){
			if(FlxG.pixelPerfectOverlap(_player,e)){
				for(st in ents){
					if(st.room == (e.room + 1)){
						_player.x = st.x;
						_player.y = st.y;
						cur_x = st.x;
						cur_y = st.y;
					}
				}
			}
		}
		for(s in swi){
			if(FlxG.pixelPerfectOverlap(_player,s)){
				if(FlxG.keys.justPressed.E){
					s.change();
					for(p in pil){
						if(s.name == p.name){
							p.change();
						}
					}
				}
			}
		}
		for(pp in ppl){
			if(FlxG.pixelPerfectOverlap(_player,pp)){
				for(p in pil){
					if(pp.name == p.name){
						if(p.up == true){
							p.change();
							p_name = p.name;
							countdown = 100;
						}
						else{
							countdown = 100;
						}
					}
				}
			}
		}
		for(pg in pgs){
			if(FlxG.pixelPerfectOverlap(_player,pg)){
				if(FlxG.keys.justPressed.E){
					tmppg = new Page(pg.x,pg.y);
					tmppg.setchange(pg.name);
					add(tmppg);
					tpexist = true;
					pg.destroy();
					countdown = 100;
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
		if(countdown == 0){
			for(p in pil){
				if(p.name == p_name){
					if(p.up != true){
						p.change();
					}
				}
			}
			if(tpexist == true){
				tmppg.kill();
				tpexist = false;
			}
			countdown = -1;
		}
		else if(countdown > -1){
			countdown--;
		}
		for(e in exts){
			if(FlxG.pixelPerfectOverlap(_player,e)){
				FlxG.switchState(new MenuState());
			}
		}
		
		FlxG.collide(_player, pil);
		FlxG.collide(_player,_mWalls);
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
				pil.add(p);
			}
			else if(e.type == "lever"){
				var s = new Switch(x,y-14);
				s.setname(e.name);
				s.settype(e.type);
				swi.add(s);
			}
			else if(e.type == "plate"){
				var pp = new PPlate(x,y-16);
				pp.settype(e.type);
				pp.setname(e.name);
				ppl.add(pp);
			}
			else if(e.type == "page"){
				var pg = new Page(x,y);
				pg.settype(e.type);
				pg.setname(e.name);
				pg.setchange("p");
				pgs.add(pg);

			}
			else if(e.type == "entrance"){
				_player.x = e.x;
				_player.y = e.y;
			}
			else if(e.type == "exit"){
				var ext = new Exit(x,y-16);
				ext.settype(e.type);
				ext.setname(e.name);
				exts.add(ext);
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
		for(pg in pgs){
			add(pg);
		}
		add(_player);
	}
}