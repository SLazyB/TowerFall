package;


import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxObject;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.math.FlxPoint;

class Player extends FlxSprite
{
    public var speed:Float = 150;
    public var c_mA:Float = 1000;
    public var playing:Bool = false;
    public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
    {
        super(X, Y, SimpleGraphic);
        loadGraphic("assets/images/fw.png", true, 32, 32);
        animation.add("fw", [4,3,4,5,],6,true);

        drag.x = drag.y = 1250;
    }
    
    public function movement():Void{
        var _up:Bool = false;
        var _down:Bool = false;
        var _right:Bool = false;
        var _left:Bool = false;
        var mA:Float = 0;
        
        _up = FlxG.keys.anyPressed([W]);
        _down = FlxG.keys.anyPressed([S]);
        _right = FlxG.keys.anyPressed([D]);
        _left = FlxG.keys.anyPressed([A]);

        if (_up && _down)
            _up = _down = false;
        if(_left && _right)
            _left = _right = false;
        if(_up || _down || _left || _right){
            if (_up)
            {
                mA = -90;
                if (_left)
                    mA -= 45;
                else if (_right)
                    mA += 45;
                facing = FlxObject.UP;
            }
            else if (_down)
            {
                mA = 90;
                if (_left)
                    mA += 45;
                else if (_right)
                    mA -= 45;
                facing = FlxObject.DOWN;
            }
            else if (_left){
                mA = 180;
                facing = FlxObject.LEFT;
            }
            else if (_right){
                mA = 0;
                facing = FlxObject.RIGHT;
            }
            
            velocity.set(speed, 0);
            velocity.rotate(FlxPoint.weak(0, 0), mA);
        }
        if ((velocity.x != 0 || velocity.y != 0) && touching == FlxObject.NONE){
            if(!playing || c_mA != mA){
                animation.play("fw");
                c_mA = mA;
                playing = true;
            }
        }
        else{
            playing = false;
            animation.stop();
            animation.reset();
        }
    }

    override public function update(elapsed:Float):Void{
        movement();
        super.update(elapsed);
    }
}