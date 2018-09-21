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
    public var name:String;
    public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
    {
        super(X, Y, SimpleGraphic);
    }
    public function settype(s:String):Void{
        type = s;
    }
    public function setname(s:String):Void{
        name = s;
    }
    public function setchange(change:String):Void{
        if(change == "rom1"){
            loadGraphic("assets/data/Note1.png", true, 401, 126);
        }
        else if(change == "rom2"){
            loadGraphic("assets/data/Note2.png", true, 16, 16);
        }
        else if(change == "rom3"){
            loadGraphic("assets/data/Note3.png", true, 16, 16);
        }
        else if(change == "rom4"){
            loadGraphic("assets/data/Note4.png", true, 16, 16);
        }
        else{
            loadGraphic("assets/data/letter.png",true, 16,16);
        }
    }

    override public function update(elapsed:Float):Void{
        super.update(elapsed);
    }
}