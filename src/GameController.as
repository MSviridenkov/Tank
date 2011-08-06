package
{
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.geom.Transform;

	public class GameController
	{
		private var _matrix:Vector.<Vector.<int>>;
		
		private var _target:Target;
		private var _container:Sprite;
		
		public static const MATRIX_WIDTH:int = 20;
		public static const MATRIX_HEIGHT:int = 20;
		
		public static const CELL:int = 10;
		
		public function ReturnTarget():Target
		{
			return _target;
		}
		
		
		public function GameController(c:Sprite):void
		{
			_container = c;
			createMatrix();
			createTarget();
		}
		
		public function addTankPos(x:int, y:int):void {
			_matrix[x][y] = MatrixItemIds.TANK;
		}
		
		public function cleanCell(x:int, y:int):void {
			_matrix[x][y] = 0;
		}
		
		private function createTarget():void {
			_target = new Target();
			var rndX:int = Math.random() * MATRIX_WIDTH;
			var rndY:int = Math.random() * MATRIX_HEIGHT;
			_target.x = rndX * CELL;
			_target.y = rndY * CELL;
			_container.addChild(_target);
			_matrix[rndX][rndY] = MatrixItemIds.TARGET;
		}
		
		private function createMatrix():void {
			_matrix = new Vector.<Vector.<int>>();
			for (var i:int = 0; i < MATRIX_WIDTH; ++i) {
				_matrix.push(new Vector.<int>());
			}
			
			for each (var vect:Vector.<int> in _matrix) {
				for (var j:int = 0; j < MATRIX_HEIGHT; ++j) {
					vect.push(0);
				}
			}
		}
	}
}