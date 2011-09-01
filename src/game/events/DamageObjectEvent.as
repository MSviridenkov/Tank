package game.events {
	import game.MapObject;
	import flash.events.Event;

	public class DamageObjectEvent extends Event {
		public var object:MapObject;
		
		public static const DAMANGE_ENEMY_TANK:String = "damageEnemyTank";
		public static const DAMANGE_PLAYER_TANK:String = "damangePlayerTank";
		
		public function DamageObjectEvent(type : String, mapObject:MapObject) {
			super(type);
			object = mapObject;
		}
	}
}
