package game.events {
	import flash.events.Event;

	public class TankEvent extends Event {
		public static const COME_TO_CELL:String = "comeToCell";
		public static const MOVING_COMPLETE:String = "movingComplete";
		
		public function TankEvent(type : String) {
			super(type);
		}
	}
}
