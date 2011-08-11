package game.tank {
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import game.GameController;
	import game.matrix.MapMatrix;

	public class TargetsController {
		private var _timer:Timer;
		private var _targets:Vector.<Target>;
		private var _container:Sprite;
		private var _bulletsController:BulletsController;
		private var _gameController:GameController;
		
		public function TargetsController(container:Sprite, bulletsController:BulletsController) {
			_container = container;
			_targets = new Vector.<Target>;
			_bulletsController = bulletsController;
			_bulletsController.addTarget(_targets);
			for (var i:int = 0; i < Math.random() * 5; i++) {
			createTarget();
			}
			initTimer();
			startTimer();
		}
		
		private function createTarget():void {
			var _target:Target = new Target();
			var rndX:int = Math.random() * MapMatrix.MATRIX_WIDTH;
			var rndY:int = Math.random() * MapMatrix.MATRIX_HEIGHT;
			_target.x = rndX * GameController.CELL;
			_target.y = rndY * GameController.CELL;
			_targets.push(_target);
			_container.addChild(_target);
			//_matrix[rndX][rndY] = MatrixItemIds.TARGET;
		}
		
		private function createTargetforTimer (event:TimerEvent):void {
			if (_targets.length <5 && Math.random() < .5) {
			createTarget();
			}
			else {}
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





