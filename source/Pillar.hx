package;


import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxObject;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.system.FlxSound;

class Pillar extends FlxSprite
{

    public var col:Int;
    public var up:Bool;
    public var type:String;
    public var room:Int;
    public var name:String;
    private var _sndUp:FlxSound;
    public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
    {
        super(X, Y, SimpleGraphic);
        up = true;
        immovable = true;
        _sndUp = FlxG.sound.load(AssetPaths.lever1__wav);

    }
    public function settype(s:String):Void{
        type = s;
    }
    public function setname(s:String):Void{
        name = s;
    }
    public function setroom(s:Int):Void{
        room = s;
    }
    public function setcolor(s:Int){
        col = s;
        if(col == 1){
            loadGraphic("assets/data/redPillarA.png", true, 16, 16);
            animation.add("mv",[0,1],10,false);
        }
        else if(col == 2){
            loadGraphic("assets/data/bluePillarA.png", true, 16, 16);
            animation.add("mv",[0,1],10,false);
        }
        else if(col == 3){
            loadGraphic("assets/data/greenPillarA.png", true, 16, 16);
            animation.add("mv",[0,1],10,false);
        }
        else if(col == 4){
            loadGraphic("assets/data/yellowPillarA.png", true, 16, 16);
            animation.add("mv",[0,1],10,false);
        }
        else{
            loadGraphic("assets/data/blackPillarA.png", true, 16, 16);
            animation.add("mv",[0,1],10,false);
        }
    }
    public function change():Void{
        if(up == true){
            animation.play("mv");
            _sndUp.play();
            allowCollisions = FlxObject.NONE;
            up = false;
        }
        else{
            allowCollisions = FlxObject.ANY;
            animation.reset();
            animation.stop();
            _sndUp.play();
            up = true;
        }
    }
    override public function update(elapsed:Float):Void{
        super.update(elapsed);
    }
}