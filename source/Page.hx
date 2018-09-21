package;


import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxObject;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.math.FlxPoint;

class Page extends FlxSprite
{

    public var type:String;
    public var room:Int;
    public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
    {
        super(X, Y, SimpleGraphic);
        loadGraphic("assets/data/letter.png",true, 16,16);
    }
    public function settype(s:String):Void{
        type = s;
    }
    public function setroom(s:Int):Void{
        room = s;
    }
    public function get(){
        if(room == 1){
            loadGraphic("assets/data/Note1.png", true, 16, 16);
        }
        else if(room == 2){
            loadGraphic("assets/data/Note2.png", true, 16, 16);
        }
        else if(room == 3){
            loadGraphic("assets/data/Note3.png", true, 16, 16);
        }
        else if(room == 4){
            loadGraphic("assets/data/Note4.png", true, 16, 16);
        }
    }
    override public function update(elapsed:Float):Void{
        super.update(elapsed);
    }
}