package game.tank {
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import game.GameController;
	import game.matrix.MapMatrix;

	public class TargetsController {
		private var _timer:Timer;
		private var _targets:Vector.<Target>;
		private var _container:Sprite;
		private var _bulletsController:BulletsController;
		private var _tankController:TankController;
		
		public function TargetsController(container:Sprite, bulletsController:BulletsController, tankController:TankController) {
			_container = container;
			_targets = new Vector.<Target>;
			_bulletsController = bulletsController;
			_bulletsController.addTarget(_targets);
			_tankController = tankController;
			_tankController.addTarget(_targets);
			for (var i:int = 0; i < Math.random() * 5; i++) { createTarget(); }
			initTimer();
			startTimer();
		}
		
		private function createTarget():void {
			var _target:Target = new Target();
			var rndX:int = Math.random() * MapMatrix.MATRIX_WIDTH;
			var rndY:int = Math.random() * MapMatrix.MATRIX_HEIGHT;
			_target.x = rndX * GameController.CELL + GameController.CELL/2;
			_target.y = rndY * GameController.CELL + GameController.CELL/2;
			_targets.push(_target);
			_container.addChild(_target);
			trace (_target.x, _target.y);
			for each (var target:Target in _targets) { _tankController.addTargetPoint(new Point (target.x, target.y)) }
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





