package game.tank {
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Transform;
	import flash.utils.Timer;
	
	
	public class Bullet extends Sprite {
		
		public function Bullet(x:int, y:int):void {
			var view:Bullet_pic = new Bullet_pic();
			addChild(view);
			this.x = x;
			this.y = y;
		}
		
	}
}