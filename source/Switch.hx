package;


import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxObject;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.math.FlxPoint;

class Switch extends FlxSprite
{
    public var col:Int;
    public var up:Bool;
    public var type:String;
    public var room:Int;
    public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
    {
        super(X, Y, SimpleGraphic);
        up = true;
    }
    public function settype(s:String){
        type = s;
    }
    public function setcolor(s:Int){
        col = s;
        if(col == 1){
            loadGraphic("assets/data/redSwitch.png", true, 16, 16);
            animation.add("mv",[0,1],10,false);
        }
        else if(col == 2){
            loadGraphic("assets/data/blueSwitch.png", true, 16, 16);
            animation.add("mv",[0,1],10,false);
        }
        else if(col == 3){
            loadGraphic("assets/data/greenSwitch.png", true, 16, 16);
            animation.add("mv",[0,1],10,false);
        }
        else if(col == 4){
            loadGraphic("assets/data/yellowSwitch.png", true, 16, 16);
            animation.add("mv",[0,1],10,false);
        }
        else{
            loadGraphic("assets/data/blackSwitch.png", true, 16, 16);
            animation.add("mv",[0,1],10,false);
        }
    }
    public function setroom(s:Int){
        room = s;
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