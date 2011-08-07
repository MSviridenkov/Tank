package game.tank
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Transform;
	import flash.utils.Timer;
	
	
	public class Bullet extends Sprite
	{
		private var _target:Target;
		private var _container:Sprite;
		private var _color:uint;
		private var _radius:uint;
		private var _direction:uint;
		private var _colorInfo:ColorTransform = new ColorTransform;
		
		private const SPEED:Number = 1;
		
		private var timer:Timer;
		
		public function Bullet(x:int, y:int, d:uint, r:int, target:Target):void
		{
			var _bullet:Bullet_pic = new Bullet_pic;
			_target = target;
			addChild(_bullet);
			super();
			this.x = x;
			this.y = y;
			_direction = d;
			this.rotation = r;
			initTimer();
		}
		
		private function initTimer():void {
			timer = new Timer(1);
			timer.stop();
			timer.addEventListener(TimerEvent.TIMER, onTimer);
		}
		
		private function onTimer(event:TimerEvent):void {
			this.x += (_direction == TankDirection.LEFT_DIR) ? -SPEED : (_direction == TankDirection.RIGHT_DIR) ? SPEED : 0;
			this.y += (_direction == TankDirection.UP_DIR) ? -SPEED : (_direction == TankDirection.DOWN_DIR) ? SPEED : 0;
			if (this.hitTestObject(_target) == true){
				_target.x = Math.random() * 200;
				_target.y = Math.random() * 200;
				_colorInfo.color = Math.random() * 0xffffff;
				_target.transform.colorTransform = _colorInfo;
			}
			
		}
		
		public function startMove():void {
			timer.start();
			//TweenMax.to(this, 2, {x:SPEED, y:SPEED})
		}
	}
}