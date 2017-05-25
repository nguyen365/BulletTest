import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxObject;
import flixel.math.FlxPoint;

class Bullet extends FlxSprite 
{
	static private var DefaultBulletTypes:Map<String,Bullet->Void> = InitalizeDefaultBulletTypes();

	public var BulletType:String;

	override public function new():Void {
		super();
		BulletType = "None";
	}

	public function SetBulletType(NewType:String):Void {
		BulletType = NewType;
		if (DefaultBulletTypes.exists(NewType)) {
			(DefaultBulletTypes.get(NewType))(this);
		}
	}

	static private function InitalizeDefaultBulletTypes():Map<String,Bullet->Void> {
		var BulletTypes:Map<String,Bullet->Void> = new Map<String,Bullet->Void>();
		BulletTypes.set("FairyBulletNormal",FairyBulletNormal);
		BulletTypes.set("BossBulletNormal",BossBulletNormal);
		return BulletTypes;
	}

	static private function FairyBulletNormal(b:Bullet):Void {
		b.loadGraphic(AssetPaths.Pokeball__png,true);
	}

	static private function BossBulletNormal(b:Bullet):Void {
		b.loadGraphic(AssetPaths.MasterBall__png,true);
	}

	override public function update(elapsed:Float):Void {
		if (PlayState.OutsidePlayArea(this.x,this.y)) {
			this.kill();
		}

		super.update(elapsed);
	}
}