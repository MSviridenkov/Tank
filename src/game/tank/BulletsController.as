package game.tank {
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.utils.Timer;

	public class BulletsController {
		private const SPEED:Number = 3;
		
		private var _timer:Timer;
		private var _colorInfo:ColorTransform = new ColorTransform;
		private var bullets:Vector.<Bullet>; //vector of bullets on scenes
		private var _container:Sprite; // container for bullets
		private var _target:Target; //мишень, пока одна, в итоге должен быть массив мишеней
		private var _direction:uint;
		private var _rotation:uint;
		private var p:Point;

		public function BulletsController(container:Sprite) {
			_container = container;
			bullets = new Vector.<Bullet>();
			initTimer();
			startMove();
		}
		
		public function addTarget(target:Target):void { // функция для добавления мишени в этот класс, нужно ее вызывать при создании мишени
			_target = target;
		}
		
		public function pushBullet(point:Point, d:uint, r:uint):void {//здесь создаем пулю и запускаем и добавляем в массив
			 p = point;
			 _direction = d;
			 _rotation = r;
			 var bullet:Bullet = new Bullet (p.x, p.y, _direction, _rotation);
			 bullets.push(bullet);
			 _container.addChild(bullet);
		}
		
		private function initTimer():void {
			_timer = new Timer(1);
			_timer.stop();
			_timer.addEventListener(TimerEvent.TIMER, onTimer);
		}
			
		private function onTimer(event:TimerEvent):void {
			for each (var bullet:Bullet in bullets) {// проходимся по всем элементам массива bullets
				bullet.x += (bullet.direction == TankDirection.LEFT_DIR) ? -SPEED : (bullet.direction == TankDirection.RIGHT_DIR) ? SPEED : 0;
				bullet.y += (bullet.direction == TankDirection.UP_DIR) ? -SPEED : (bullet.direction == TankDirection.DOWN_DIR) ? SPEED : 0;
			
				if (bullet.hitTestObject(_target) == true){
					_target.x = Math.random() * 200;
					_target.y = Math.random() * 200;
					_colorInfo.color = Math.random() * 0xffffff;
					_target.transform.colorTransform = _colorInfo;
					_container.removeChild(bullet);
					var index:int = bullets.indexOf(bullet);
					bullets.splice(index, 1);
				}
			}
		}
		
		public function startMove():void {
			_timer.start();
			//TweenMax.to(this, 2, {x:SPEED, y:SPEED}) ))
		}
	}
}