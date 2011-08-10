package game.tank {
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.utils.Timer;

	public class BulletsController {
		private const SPEED:Number = 4;
		
		private var _timer:Timer;
		private var _colorInfo:ColorTransform = new ColorTransform;
		private var _bullets:Vector.<Bullet>; //vector of bullets on scenes
		private var _container:Sprite; // container for bullets
		private var _targets:Vector.<Target>; //мишень, пока одна, в итоге должен быть массив мишеней
		private var _direction:uint;
		private var _rotation:uint;
		private var _p:Point;

		public function BulletsController(container:Sprite) {
			_container = container;
			_bullets = new Vector.<Bullet>();
			initTimer();
			startMove();
		}
		
		public function addTarget(targets:Vector.<Target>):void { // функция для добавления мишени в этот класс, нужно ее вызывать при создании мишени
			_targets = targets;
		}
		
		public function pushBullet(point:Point, d:uint, r:uint):void {//здесь создаем пулю и запускаем и добавляем в массив
			 _p = point;
			 _direction = d;
			 _rotation = r;
			 var bullet:Bullet = new Bullet (_p.x, _p.y, _direction, _rotation);
			 _bullets.push(bullet);
			 _container.addChild(bullet);
		}
		
		private function initTimer():void {
			_timer = new Timer(1);
			_timer.stop();
			_timer.addEventListener(TimerEvent.TIMER, onTimer);
		}
			
		private function onTimer(event:TimerEvent):void {
			for each (var bullet:Bullet in _bullets) {// проходимся по всем элементам массива bullets
				bullet.x += (bullet.direction == TankDirection.LEFT_DIR) ? -SPEED : (bullet.direction == TankDirection.RIGHT_DIR) ? SPEED : 0;
				bullet.y += (bullet.direction == TankDirection.UP_DIR) ? -SPEED : (bullet.direction == TankDirection.DOWN_DIR) ? SPEED : 0;
				
			for each (var target:Target in _targets) {
				if (bullet.hitTestObject(target) == true){
					//target.x = Math.random() * 200;
					//target.y = Math.random() * 200;
					//_colorInfo.color = Math.random() * 0xffffff;
					//target.transform.colorTransform = _colorInfo;
					_container.removeChild(bullet);
					var indexbullet:int = _bullets.indexOf(bullet);
					_bullets.splice(indexbullet, 1);
					_container.removeChild(target);
					var indextarget:int = _targets.indexOf(target);
					_targets.splice(indextarget, 1);
				}
			}
			}
		}
		
		public function startMove():void {
			_timer.start();
			//TweenMax.to(this, 2, {x:SPEED, y:SPEED}) ))
		}
	}
}