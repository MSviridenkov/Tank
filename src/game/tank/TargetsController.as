package game.tank {
	import game.events.TargetsControllerEvent;
	import flash.events.EventDispatcher;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import game.matrix.MapMatrix;

	public class TargetsController extends EventDispatcher{
		private var _timer:Timer;
		private var _enemyes:Vector.<Tank>;
		private var _container:Sprite;
		
		public function TargetsController(container:Sprite) {
			_container = container;
			_enemyes = new Vector.<Tank>;
			for (var i:int = 0; i < Math.random() * 5; i++) { createTarget(); }
			initTimer();
			startTimer();
		}
		
		private function createTarget():Tank {
			var enemyTank:Tank = new Tank();
			var rndX:int = Math.random() * MapMatrix.MATRIX_WIDTH;
			var rndY:int = Math.random() * MapMatrix.MATRIX_HEIGHT;
			enemyTank.x = rndX;
			enemyTank.y = rndY;
			_enemyes.push(enemyTank);
			_container.addChild(enemyTank);
			return enemyTank;
		}
		
		private function createTargetforTimer (event:TimerEvent):void {
			if (_enemyes.length <5 && Math.random() < .5) {
				const enemyTank:Tank = createTarget();
				dispatchEvent(new TargetsControllerEvent(TargetsControllerEvent.NEW_TANK, enemyTank));
			}
		}
		
		private function initTimer():void {
			_timer = new Timer(5000);
			_timer.addEventListener(TimerEvent.TIMER, createTargetforTimer);
		}
		
		private function startTimer():void {
			_timer.start();
		}
	}
}





