package game {
	import game.matrix.MapMatrix;
	import flash.display.Sprite;
	import game.tank.BulletsController;
	import game.tank.TankController;
	import game.tank.TargetsController;

	public class GameController {
		private var _container:Sprite;
		private var _bulletsController:BulletsController;
		private var _tankController:TankController;
		private var _targetsController:TargetsController;
		private var _mapMatrix:MapMatrix;
		
		public static const CELL:int = 20;
		
		public function GameController(c:Sprite):void {
			_container = c;
			initControllers();
		}
		
		public function get tankController():TankController { return _tankController; }
		
		private function initControllers():void {
			_bulletsController = new BulletsController(_container);
			_tankController = new TankController(_container, _bulletsController);
			_targetsController = new TargetsController(_container, _bulletsController);
			_mapMatrix = new MapMatrix(_container);
			_mapMatrix.drawMatrix();
		}
	}
}