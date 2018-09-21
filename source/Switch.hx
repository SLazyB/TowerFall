package;


import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxObject;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.system.FlxSound;

class Switch extends FlxSprite
{
    public var name:String;
    public var up:Bool;
    public var type:String;
    public var room:Int;
    private var _sndOpen:FlxSound;
    public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset){
        super(X, Y, SimpleGraphic);
        loadGraphic("assets/data/redSwitchA.png", true, 16, 16);
        animation.add("mv",[0,1],10,false);
        _sndOpen = FlxG.sound.load(AssetPaths.lever1__wav);
        up = true;
    }
    public function settype(s:String){
        type = s;
    }
    /*public function setcolor(s:Int){
        col = s;
        if(col == 1){
            loadGraphic("assets/data/redSwitchA.png", true, 16, 16);
            animation.add("mv",[0,1],10,false);
        }
        else if(col == 2){
            loadGraphic("assets/data/blueSwitchA.png", true, 16, 16);
            animation.add("mv",[0,1],10,false);
        }
        else if(col == 3){
            loadGraphic("assets/data/greenSwitchA.png", true, 16, 16);
            animation.add("mv",[0,1],10,false);
        }
        else if(col == 4){
            loadGraphic("assets/data/yellowSwitchA.png", true, 16, 16);
            animation.add("mv",[0,1],10,false);
        }
        else{
            loadGraphic("assets/data/blackSwitchA.png", true, 16, 16);
            animation.add("mv",[0,1],10,false);
        }
    }*/
    public function setname(s:String){
        name = s;
    }

    public function change():Void{
        if(up == true){
            animation.play("mv");
            _sndOpen.play();
            up = false;
        }
        else{
            animation.stop();
            animation.reset();
            _sndOpen.play();
            up = true;
        }
    }

    override public function update(elapsed:Float):Void{
        super.update(elapsed);
    }
}