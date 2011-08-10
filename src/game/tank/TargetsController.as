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
			createTarget();
			_bulletsController = bulletsController;
			_bulletsController.addTarget(_targets);
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
		
		/*private function initTimer():void {
			_timer = new Timer(1);
			_timer.addEventListener(TimerEvent.TIMER, createTarget());
		}*/
		
		/*private function onTimer(event:TimerEvent):void {
			
			
			for each (var bullet:Bullet in _bullets) {// проходимся по всем элементам массива bullets
				bullet.x += (bullet.direction == TankDirection.LEFT_DIR) ? -SPEED : (bullet.direction == TankDirection.RIGHT_DIR) ? SPEED : 0;
				bullet.y += (bullet.direction == TankDirection.UP_DIR) ? -SPEED : (bullet.direction == TankDirection.DOWN_DIR) ? SPEED : 0;
				
				if (bullet.hitTestObject(_target) == true){
					_target.x = Math.random() * 200;
					_target.y = Math.random() * 200;
					_colorInfo.color = Math.random() * 0xffffff;
					_target.transform.colorTransform = _colorInfo;
					_container.removeChild(bullet);
					var index:int = _bullets.indexOf(bullet);
					_bullets.splice(index, 1);
				}
			}
		}
		
		private function startTimer() {
			_timer.start();
		}*/
	}
}





