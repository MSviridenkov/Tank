package game.matrix {
	public class MapMatrix {
		private var _matrix:Vector.<Vector.<int>>;
		
		public static const MATRIX_WIDTH:int = 20;
		public static const MATRIX_HEIGHT:int = 20;
		
		public function MapMatrix() {
		}
		
		public function addTankPos(x:int, y:int):void {
			_matrix[x][y] = MatrixItemIds.TANK;
		}
		
		public function cleanCell(x:int, y:int):void {
			_matrix[x][y] = 0;
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