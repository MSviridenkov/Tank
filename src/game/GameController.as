package game
{
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.geom.Transform;
	
	import game.matrix.MapMatrix;
	import game.tank.Target;

	public class GameController
	{
		private var _target:Target;
		private var _container:Sprite;
		
		public static const CELL:int = 20;
		
		public function GameController(c:Sprite):void {
			_container = c;
			createTarget();
		}
		
		public function returnTarget():Target {
			return _target;
		}
		
		private function createTarget():void {
			_target = new Target();
			var rndX:int = Math.random() * MapMatrix.MATRIX_WIDTH;
			var rndY:int = Math.random() * MapMatrix.MATRIX_HEIGHT;
			_target.x = rndX * CELL;
			_target.y = rndY * CELL;
			_container.addChild(_target);
			//_matrix[rndX][rndY] = MatrixItemIds.TARGET;
		}
		
	}
}