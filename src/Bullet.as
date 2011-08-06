package
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Bullet extends Sprite
	{
		private var _color:uint;
		private var _radius:uint;
		private var _direction:uint; //Направление
		//private var _rotation:int;
		
		private const SPEED:Number = 1;
		
		private var timer:Timer;
		
		public function Bullet(x:int, y:int, d:uint, r:int):void
		{
			var _bullet:Bullet_pic = new Bullet_pic;
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
			//this.x += (_direction == TankController.LEFT_DIR) ? -SPEED : (_direction == TankController.RIGHT_DIR) ? SPEED : 0;
			//this.y += (_direction == TankController.UP_DIR) ? -SPEED : (_direction == TankController.DOWN_DIR) ? SPEED : 0;

			if (_direction == TankController.LEFT_DIR) {
				this.x = this.x - SPEED;
			} else {
				if (_direction == TankController.RIGHT_DIR) {
					this.x = this.x + SPEED;
				}
			}
			if (_direction == TankController.UP_DIR) {
				this.y = this.y - SPEED;
			} else {
				if (_direction == TankController.DOWN_DIR) {
					this.y = this.y + SPEED;
				}
			}
			
		}
		
		/*
		_rotation == TankController.LEFT_ROT
		_rotation == TankController.RIGHT_ROT
		_rotation == TankController.UP_ROT
		_rotation == TankController.DOWN_ROT
		*/
		
		public function startMove():void {
			timer.start();
			//TweenMax.to(this, 2, {x:SPEED, y:SPEED})
		}
	}
}