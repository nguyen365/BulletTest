import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.math.FlxVelocity;

class Enemy extends FlxSprite 
{
	static private var dx:Float = 15;
	private var _waypoints:Array<FlxPoint>;
	private var _speed:Float = 100;

	override public function new(?X:Float=0,?Y:Float=0):Void {
		super(X,Y);

		_waypoints = new Array<FlxPoint>();

		
	}

	override public function update(elapsed:Float):Void {
		if (_waypoints[0].distanceTo(FlxPoint.weak(this.x, this.y)) <= dx) {
			_waypoints.pop();
		}
		if (_waypoints.length == 0) {
			_waypoints.push(new FlxPoint(0,0));
		}
		// add check for off-screen
		FlxVelocity.moveTowardsPoint(this, _waypoints[0], _speed);

		super.update(elapsed);
	}

}