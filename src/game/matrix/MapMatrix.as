package game.matrix {
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import game.GameController;
	import flash.display.Sprite;
	public class MapMatrix {
		private var _matrix:Vector.<Vector.<int>>;
		private var _container:Sprite;
		
		public static const MATRIX_WIDTH:int = 15;
		public static const MATRIX_HEIGHT:int = 15;
		
		public function MapMatrix(container:Sprite) {
			createMatrix();
			_container = container;
		}
		
		public function get matrix():Vector.<Vector.<int>> {
			return _matrix;
		}
		
		public function getMatrixPoint(point:Point):Point{
			return new Point(int((point.x ) / GameController.CELL),
												int((point.y) / GameController.CELL));
		}
		
		public function getStageRectangle(point:Point):Rectangle {
			return new Rectangle (point.x * GameController.CELL, point.y * GameController.CELL,
														GameController.CELL, GameController.CELL);
		}
		
		public function drawMatrix():void {
			_container.graphics.lineStyle(1, 0x00BBFF, .1);
			for (var i:int = 0; i <= MATRIX_WIDTH; ++i) {
				_container.graphics.moveTo(i * GameController.CELL, 0);
				_container.graphics.lineTo(i * GameController.CELL, MATRIX_HEIGHT * GameController.CELL);
			}
			for (var j:int = 0; j <= MATRIX_HEIGHT; ++j) {
				_container.graphics.moveTo(0, j * GameController.CELL);
				_container.graphics.lineTo(MATRIX_WIDTH * GameController.CELL, j * GameController.CELL);
			}
		}
		
		public function cleanCell(x:int, y:int):void {
			_matrix[x][y] = MatrixItemIds.EMPTY;
		}
		
		private function createMatrix():void {
			_matrix = new Vector.<Vector.<int>>();
			for (var i:int = 0; i < MATRIX_WIDTH; ++i) {
				_matrix.push(new Vector.<int>());
			}
			
			for each (var vect:Vector.<int> in _matrix) {
				for (var j:int = 0; j < MATRIX_HEIGHT; ++j) {
					Math.random() > .1 ? vect.push(MatrixItemIds.EMPTY) :
																vect.push(MatrixItemIds.STONE);
				}
			}
		}
	}
}