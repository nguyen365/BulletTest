package;

import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.FlxObject;


class Level extends FlxGroup 
{
	static private var _bPoolSize = 500;
	static private var _ePoolSize = 50;
	private var _bullets:FlxTypedGroup<Bullet>;
	private var _enemies:FlxTypedGroup<Enemy>;
	
	override public function create():Void {
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


		super.create();
	}

	override public function draw() {
		_bullets.draw();
		_enemies.draw();
		super.draw();
	}
}