package game.tank {
	import com.greensock.TweenMax;
	import com.greensock.events.TweenEvent;
	
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
		private var _tPoint:Point;

		public function BulletsController(container:Sprite) {
			_container = container;
			_bullets = new Vector.<Bullet>();
			//initTimer();
			//startMove();
		}
		
		public function addTarget(targets:Vector.<Target>):void { // функция для добавления мишени в этот класс, нужно ее вызывать при создании мишени
			_targets = targets;
		}
		
		public function pushBullet(point:Point, targetPoint:Point):void {
			 _p = point;
			 _tPoint = targetPoint;
			 var bullet:Bullet = new Bullet (_p.x, _p.y, _rotation);
			 _bullets.push(bullet);
			 _container.addChild(bullet);
			 startBulletTween(bullet, targetPoint);
		}
		
		private function startBulletTween(bullet:Bullet, targetPoint:Point):void {
			TweenMax.to(bullet, 1.3, {x : targetPoint.x, y : targetPoint.y, 
																onUpdate : onBulletTweenUpdate,
																onUpdateParams : [bullet]} );
		}
		
		private function onBulletTweenUpdate(bullet:Bullet):void {
			for each (var target:Target in _targets) {
				if (bullet.hitTestObject(target) == true){
					_container.removeChild(bullet);
					var indexbullet:int = _bullets.indexOf(bullet);
					_bullets.splice(indexbullet, 1);
					_container.removeChild(target);
					var indextarget:int = _targets.indexOf(target);
					_targets.splice(indextarget, 1);
				}
			}
		}
		
		private function initTimer():void {
			_timer = new Timer(1);
			_timer.stop();
			_timer.addEventListener(TimerEvent.TIMER, onTimer);
		}
			
		private function onTimer(event:TimerEvent):void {
			for each (var bullet:Bullet in _bullets) {
				//bullet.x += (bullet.direction == TankDirection.LEFT_DIR) ? -SPEED : (bullet.direction == TankDirection.RIGHT_DIR) ? SPEED : 0;
				//bullet.y += (bullet.direction == TankDirection.UP_DIR) ? -SPEED : (bullet.direction == TankDirection.DOWN_DIR) ? SPEED : 0;
				
			for each (var target:Target in _targets) {
				if (bullet.hitTestObject(target) == true){
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