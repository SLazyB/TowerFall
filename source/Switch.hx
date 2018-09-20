package;


import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxObject;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.math.FlxPoint;

class Switch extends FlxSprite
{
    public var col:String;
    public var up:Bool;
    public var type:String;
    public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
    {
        super(X, Y, SimpleGraphic);
        loadGraphic("assets/data/switching.png", true, 16, 16);
        animation.add("mv",[0,1],10,false);
        up = true;
    }
    public function settype(s:String){
        type = s;
    }
    public function change():Void{
        if(up == true){
            animation.play("mv");
            up = false;
        }
        else{
            animation.stop();
            animation.reset();
            up = true;
        }
    }

    override public function update(elapsed:Float):Void{
        super.update(elapsed);
    }
}