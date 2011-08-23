package game.mapObjects {
	import flash.geom.Point;
	import flash.display.Sprite;
	
	import game.matrix.MapMatrix;
	import game.matrix.MatrixItemIds;
	import game.tank.TankController;

	public class MapObjectsController {
		private var _mapMatrix:MapMatrix;
		private var _container:Sprite;
		private var _stones:Vector.<Stone>;
		
		public function MapObjectsController(matrix:MapMatrix, container:Sprite):void {
			super();
			_mapMatrix = matrix;
			_container = container;
		}
		
		public function drawObjects():void {
			if (!_mapMatrix || !_mapMatrix.matrix) { return; }
			
			for (var i:int = 0; i < MapMatrix.MATRIX_WIDTH; ++i) {
				for (var j:int = 0; j < MapMatrix.MATRIX_HEIGHT; ++j) {
					if (_mapMatrix.matrix[i][j] == MatrixItemIds.STONE) {
						addStone(new Point(i, j));
					}
				}
			}
		}
		
		private function addStone(mPoint:Point):void {
			var stone:Stone;
			stone = new Stone(_mapMatrix.getStageRectangle(mPoint));
			if (!_stones) { _stones = new Vector.<Stone>(); }
			_stones.push(stone);
			_container.addChild(stone);
		}
		
	}
}
