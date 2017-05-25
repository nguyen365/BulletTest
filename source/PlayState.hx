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

	private var _HUD:HUD;
	private var _CurrentLevel:Level;
	private var _lastShotTime:Float;

	override public function create():Void
	{
		_lastShotTime = 0;
		_CurrentLevel = new Level();
		_HUD = new HUD(Std.int(GameAreaStart.x),
			Std.int(GameAreaStart.y),
			Std.int(GameAreaEnd.x - GameAreaStart.x),
			Std.int(GameAreaEnd.y - GameAreaStart.y));
		//FlxG.camera.follow(_player,SCREEN_BY_SCREEN,1);
		super.create();
	}

	override public function draw():Void {
		_CurrentLevel.draw();
		_HUD.draw();
		super.draw();
	}

	override public function update(elapsed:Float):Void
	{
		HandleInput(elapsed);
		_CurrentLevel.update(elapsed);
		super.update(elapsed);
	}

	private function HandleInput(elapsed:Float):Void 
	{
		var _up:Bool = false;
		var _down:Bool = false;
		var _left:Bool = false;
		var _right:Bool = false;
		var _focus:Bool = false;
		var _shoot:Bool = false;
		var _bomb:Bool = false;

		var _player = this._CurrentLevel._player;

		_up = keys.anyPressed([UP]);
		_down = keys.anyPressed([DOWN]);
		_left = keys.anyPressed([LEFT]);
		_right = keys.anyPressed([RIGHT]);
		_focus = keys.anyPressed([SHIFT]);
		_shoot = keys.anyPressed([Z]);
		_bomb = keys.anyPressed([X]);

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

		_lastShotTime = _lastShotTime + elapsed; 
		if (_shoot && (_lastShotTime >= _player.reload_time)) {
			_lastShotTime = 0;
			_player.shoot();
		}
	}

	static public function OutsidePlayArea(X:Float,Y:Float):Bool {
		return ((X < GameAreaStart.x) || (Y < GameAreaStart.y) ||
			(X > GameAreaEnd.x) || (Y > GameAreaEnd.y));
	}
}