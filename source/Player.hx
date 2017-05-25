package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.group.FlxGroup;

class Player extends FlxSprite {
	public var speed:Float = 100;
	public var focus_speed:Float = 70;
	public var reload_time:Float = 0.1;
	public var is_moving:Bool;
	public var focus:Bool;
	public var _hitbox:HitBox;
	public var _shots:FlxTypedGroup<Bullet>;
	public var shot_speed:Float = 300;

	public function new(sPool:FlxTypedGroup<Bullet> ,?X:Float=0,?Y:Float=0) {
		super(X,Y);
		is_moving = false;
		focus = false;
		this.solid = false;
		loadGraphic(AssetPaths.Youmu__png,true,32,50);
		setFacingFlip(FlxObject.LEFT,false,false);
		setFacingFlip(FlxObject.RIGHT,true,false);
		animation.add("idle",[0,1,2,3], 6, true);
		animation.add("move-start",[4,5,6,7],12,false);
		animation.add("move-end", [7,6,5,4], 12, false);
		drag.x = drag.y = 2000;
		animation.play("idle");
		animation.finishCallback = animationFinished;

		_hitbox = new HitBox(getMidpoint().x,getMidpoint().y);

		_shots = sPool;
		_shots.forEach(MakeShotGraphic);
	}

	private function movement() {
		if ((velocity.x != 0 || velocity.y != 0) && is_moving == false) {
			is_moving = true;
			facing = FlxObject.UP;
			if (velocity.x < 0) {
				facing = FlxObject.LEFT;
			}
			else if (velocity.x > 0) {
				facing = FlxObject.RIGHT;
			}
			switch (facing) {
				case FlxObject.RIGHT, FlxObject.LEFT: 
				animation.play("move-start");
				case FlxObject.UP:
				animation.play("idle");
			}
		}
		else if (velocity.x == 0 && velocity.y == 0 && is_moving == true) {
			is_moving = false;
			animation.play("move-end");
		}
		_hitbox.setPositionByPoint(this.getMidpoint());
	}

	override public function update(elapsed:Float):Void {
		movement();
		if (this.focus == true) {
			this._hitbox.visible = true;
		}
		else {
			this._hitbox.visible = false;
		}
		super.update(elapsed);
	}

	public function animationFinished(name:String):Void {
		if (name == "move-start") {
			
		}
		else if (name == "move-end") {
			animation.play("idle");
		}
		else if (name == "idle") {
			
		}
	}

	public function shoot():Void {
		var shot = _shots.recycle(Bullet);
		shot.setPosition(getMidpoint().x,getMidpoint().y);
		shot.velocity.set(shot_speed,0);
		shot.velocity.rotate(FlxPoint.weak(0,0), 270);
	}

	static private function MakeShotGraphic(s:Bullet):Void {
		s.loadGraphic(AssetPaths.YoumuProjectile__png,false);
	}
}

class HitBox extends FlxSprite {
	//public var is_visible:Bool;

	public function new(?X:Float=0,?Y:Float=0) {
		super(X,Y);
		visible = false;
		loadGraphic(AssetPaths.HitBox__png,true,12,12);
		animation.add("visible", [0], 30, false);
		animation.add("hidden", [1], 30, false);

		animation.play("visible");
	}

	override public function update(elapsed:Float):Void {
		if (visible == true) {
			animation.play("visible");
		}
		else {
			animation.play("hidden");
		}
		super.update(elapsed);
	}

	public function setPositionByPoint(pos:FlxPoint):Void {
		this.x = pos.x;
		this.y = pos.y;
	}
}