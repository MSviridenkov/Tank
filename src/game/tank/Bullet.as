package game.tank {
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Transform;
	import flash.utils.Timer;
	
	
	public class Bullet extends Sprite {
		private var _radius:uint;
		
		public function Bullet(x:int, y:int, r:uint = 0):void {
			var view:Bullet_pic = new Bullet_pic();
			addChild(view);
			this.x = x;
			this.y = y;
			this.rotation = r;
		}
		
	}
}