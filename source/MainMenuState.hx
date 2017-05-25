package;

import flixel.FlxState;
import flixel.ui.FlxButton;

class MainMenuState extends FlxState
{
	private var _buttonPlay:FlxButton;

	override public function create():Void
	{
		super.create();
		_buttonPlay = new FlxButton(0,0,"Play",clickPlay);
		_buttonPlay.screenCenter();
		add(_buttonPlay);

	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}

	private function clickPlay():Void
	{
		flixel.FlxG.switchState(new PlayState());
	}
}
