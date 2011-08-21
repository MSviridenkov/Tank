package game.tank {
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.geom.Point;

	public class BulletsController {
		private var _bullets:Vector.<Bullet>;
		private var _container:Sprite;
		private var _targets:Vector.<Target>;
		private var _p:Point;
		private var _tPoint:Point;
		private var bullet:Bullet;

		public function BulletsController(container:Sprite) {
			_container = container;
			_bullets = new Vector.<Bullet>();
		}
		
		public function addTarget(targets:Vector.<Target>):void {
			_targets = targets;
		}
		
		public function pushBullet(point:Point, targetPoint:Point):void {
			_p = point;
			_tPoint = targetPoint;
			bullet = new Bullet (_p.x, _p.y);
			_bullets.push(bullet);
			_container.addChild(bullet);
			startMove(targetPoint);
		}
		
		public function bulletRotate(rotation:int):void {
			bullet.rotation = rotation;
		}
		
		private function startBulletTween(bullet:Bullet, targetPoint:Point):void {
			TweenMax.to(bullet, 1.3, {x : targetPoint.x, y : targetPoint.y,
																onUpdate : onBulletTweenUpdate,
																onUpdateParams : [bullet],
																onComplete : getCompleteBulletFunction(bullet)} );
		}
		
		private function getCompleteBulletFunction(bullet:Bullet):Function {
			return function ():void {
				_container.removeChild(bullet);
				removeFromVector(bullet);
			};
		}
		
		private function onBulletTweenUpdate(bullet:Bullet):void {
			for each (var target:Target in _targets) {
				if (bullet.hitTestObject(target) == true){
					removeBulletAndTarget(bullet, target);
				}
			}
		}
		
		private function removeFromVector(bullet:Bullet):void {
			var indexbullet:int = _bullets.indexOf(bullet);
			if (indexbullet != -1) { _bullets.splice(indexbullet, 1); }
		}
		
		private function removeBulletAndTarget(bullet:Bullet, target:Target):void {
			_container.removeChild(bullet);
			killTweenMax(bullet);
			removeFromVector(bullet)
			_container.removeChild(target);
			var indextarget:int = _targets.indexOf(target);
			_targets.splice(indextarget, 1);
		}
		
		private function killTweenMax(bullet:Bullet):void {
			var tweens:Array = TweenMax.getTweensOf(bullet);
			if (tweens && tweens.length > 0) {
				var tween:TweenMax = tweens[0] as TweenMax;
				tween.kill();
			}
		}
		
		private function startMove(targetPoint:Point):void {
			startBulletTween(bullet, targetPoint);
		}
	}
}