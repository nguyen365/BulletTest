package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxG.keys;
import flixel.math.FlxPoint;
import flixel.FlxObject;

class PlayState extends FlxState
{
	static public var GameAreaStart:FlxPoint = new FlxPoint(20,20);
	static public var GameAreaEnd:FlxPoint = new FlxPoint(400,460);

	private var _player:Player;
	private var _HUD:HUD;

	override public function create():Void
	{
		_player = new Player(GameAreaEnd.x / 2, GameAreaEnd.y - 50);
		add(_player);
		add(_player._hitbox);
		_HUD = new HUD(Std.int(GameAreaStart.x),
			Std.int(GameAreaStart.y),
			Std.int(GameAreaEnd.x - GameAreaStart.x),
			Std.int(GameAreaEnd.y - GameAreaStart.y));
		add(_HUD);
		FlxG.camera.follow(_player,SCREEN_BY_SCREEN,1);
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		HandleInput();
		super.update(elapsed);
	}

	private function HandleInput():Void 
	{
		var _up:Bool = false;
		var _down:Bool = false;
		var _left:Bool = false;
		var _right:Bool = false;
		var _focus:Bool = false;

		_up = keys.anyPressed([UP,W]);
		_down = keys.anyPressed([DOWN,S]);
		_left = keys.anyPressed([LEFT,A]);
		_right = keys.anyPressed([RIGHT,D]);
		_focus = keys.anyPressed([SHIFT]);

		if (_up && _down) 
			_up = _down = false;
		if (_left && _right)
			_left = _right = false;

		if (_focus == true) {
			_player.focus = true;
		}
		else {
			_player.focus = false;
		}

		if (_up || _down || _left || _right) {
			var movementAngle:Float;
			if (_up) {
				if (_left) 
					movementAngle = -135;
				else if (_right) 
					movementAngle = -45;
				else
					movementAngle = -90;
			}
			else if (_down) {
				if (_left)
					movementAngle = 135;
				else if (_right)
					movementAngle = 45;
				else
					movementAngle = 90;
			}
			else if (_left) {
				movementAngle = 180;
			}
			else {
				movementAngle = 0;
			}
			if (_focus == true) {
				_player.velocity.set(_player.focus_speed,0);
			}
			else {
				_player.velocity.set(_player.speed,0);
			}
			
			_player.velocity.rotate(FlxPoint.weak(0,0), movementAngle);	
		}
	}

	static public function OutsidePlayArea(X:Float,Y:Float):Bool {
		
	}
}