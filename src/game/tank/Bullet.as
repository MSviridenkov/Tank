package game.tank {
	import flash.geom.Point;
	import com.greensock.TweenMax;
	import flash.display.Sprite;
	
	public class Bullet extends Sprite {
		private var _tween:TweenMax;
		
		public function Bullet(point:Point, rotation:Number):void {
			var view:BulletView = new BulletView();
			addChild(view);
			this.rotation = rotation;
			this.x = point.x;
			this.y = point.y;
		}
		
		public function moveTo(point:Point):void {
			_tween = new TweenMax(this, 1.3, {x : point.x, y : point.y
																//onUpdate : onBulletTweenUpdate,
																//onUpdateParams : [bullet],
																//onComplete : getCompleteBulletFunction(bullet)
																} );
		}
		
		public function onComplete(onComplete:Function):void {
			if (_tween) {
				_tween.vars["onComplete"] = onComplete;
				_tween.vars["onCompleteParams"] = [this];
			}
		}
		
		public function onUpdate(onUpdate:Function):void {
			if (_tween) {
				_tween.vars["onUpdate"] = onUpdate;
				_tween.vars["onUpdateParams"] = [this];
			}
		}
		
		public function scaleTime(value:Number):void {
			if (_tween) { _tween.timeScale = value; }
		}
		
	}
}