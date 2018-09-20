package;


import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxObject;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.math.FlxPoint;

class PPlate extends FlxSprite
{
    public var col:String;
    public var up:Bool;
    public var type:String;
    public var room:Int;
    public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset, C:Int)
    {
        super(X, Y, SimpleGraphic);
        loadGraphic("assets/data/FloorBottonBlack.png", true, 16, 16);
        up = true;
    }
    public function settype(s:String){
        type = s;
    }
    public function setname(s:String){
        type = s;
    }
    public function setroom(s:Int){
        type = s;
    }
    override public function update(elapsed:Float):Void{
        super.update(elapsed);
    }
}