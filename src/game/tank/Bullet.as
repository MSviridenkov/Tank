package game.tank {
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Transform;
	import flash.utils.Timer;
	
	
	public class Bullet extends Sprite {
		private var _radius:uint;
		private var _direction:uint;
		
		public function Bullet(x:int, y:int, d:uint, r:uint):void {
			var view:Bullet_pic = new Bullet_pic();
			addChild(view);
			this.x = x;
			this.y = y;
			this._direction = d;
			this.rotation = r;
		}
		
		public function get direction():uint { return _direction; }
		
	}
}