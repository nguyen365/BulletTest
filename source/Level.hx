package;

import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.FlxObject;


class Level extends FlxGroup 
{
	static private var _bPoolSize = 100;
	static private var _ePoolSize = 25;
	static private var _sPoolSize = 25;
	public var _player:Player;
	private var _bullets:FlxTypedGroup<Bullet>;
	private var _enemies:FlxTypedGroup<Enemy>;
	private var _shots:FlxTypedGroup<Bullet>;
	private var _events:Array<GameEvent>;


	override public function new():Void {
		super();

		_bullets = new FlxTypedGroup<Bullet>(_bPoolSize);
		for (i in 0..._bPoolSize) {
			var bullet = new Bullet();
			bullet.kill();
			_bullets.add(bullet);
		}

		_enemies = new FlxTypedGroup<Enemy>(_ePoolSize);
		for (i in 0..._ePoolSize) {
			var enemy = new Enemy();
			enemy.kill();
			_enemies.add(enemy);
		}

		_shots = new FlxTypedGroup<Bullet>(_sPoolSize);
		for (i in 0..._sPoolSize) {
			var shot = new Bullet();
			shot.kill();
			_shots.add(shot);
		}

		_player = new Player(_shots, PlayState.GameAreaEnd.x / 2, PlayState.GameAreaEnd.y - 50);
		add(_player);
		add(_player._hitbox);

		_events = new Array<GameEvent>();
	}

	override public function draw() {
		_shots.draw();
		_enemies.draw();
		_bullets.draw();
		super.draw();
	}

	override public function update(elapsed:Float):Void {
		_shots.update(elapsed);
		_enemies.update(elapsed);
		_bullets.update(elapsed);
		super.update(elapsed);
	}

	public function load(name:String):Bool {
		return true;
	}
}

class GameEvent {

}