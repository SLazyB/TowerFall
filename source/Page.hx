package;


import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxObject;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.math.FlxPoint;

class Pillar extends FlxSprite
{

    public var col:Int;
    public var up:Bool;
    public var type:String;
    public var room:Int;
    public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
    {
        super(X, Y, SimpleGraphic);
        up = true;
        loadGraphic("assets/data/pil_move.png", true, 16, 16);
        animation.add("mv",[0,1],10,false);
        immovable = true;

    }
    public function settype(s:String):Void{
        type = s;
    }
    public function setname(s:String):Void{
        col = s;
    }
    public function setroom(s:Int):Void{
        room = s;
    }
    public function setcolor(s:Int):Void{
        col = s;
    }
    public function change():Void{
        if(up == true){
            animation.play("mv");
            allowCollisions = FlxObject.NONE;
            up = false;
        }
        else{
            allowCollisions = FlxObject.ANY;
            animation.reset();
            animation.stop();
            up = true;
        }
    }
    override public function update(elapsed:Float):Void{
        super.update(elapsed);
    }
}