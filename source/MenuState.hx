package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.ui.FlxButton;

class MenuState extends FlxState
{
    var _playButton : FlxButton;
	override public function create():Void
	{
		super.create();
		_playButton = new FlxButton(0,0,"Play!",clickPlay);
		_playButton.onUp.sound = FlxG.sound.load(AssetPaths.select__wav);
		_playButton.screenCenter();
		add(_playButton);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}

	function clickPlay():Void{
		FlxG.switchState(new PlayState());
	}
}