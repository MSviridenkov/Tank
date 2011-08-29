package game.mapObjects {
	import game.IControllerWithTime;
	import flash.events.EventDispatcher;
	import game.events.MineBamEvent;
	import flash.events.Event;
	import game.tank.Tank;
	import flash.geom.Point;
	import flash.display.Sprite;
	
	import game.matrix.MapMatrix;
	import game.matrix.MatrixItemIds;

	public class MapObjectsController extends EventDispatcher
																		implements IControllerWithTime{
		private var _mapMatrix:MapMatrix;
		private var _container:Sprite;
		private var _stones:Vector.<Stone>;
		private var _mines:Vector.<Mine>;
		
		private var _scaleTime:Number;
		
		public function MapObjectsController(matrix:MapMatrix, container:Sprite):void {
			super();
			_scaleTime = 1;
			_mapMatrix = matrix;
			_container = container;
			addMines();
		}
		
		/*API*/
		
		public function scaleTime(value:Number):void {
			_scaleTime = value;
			if (_mines) {
				for each (var mine:Mine in _mines) {
					mine.scaleTime(value);
				}
			}
		}
		
		public function checkReactionForTank(tank:Tank):void {
			trace("check reaction");
			const tankPoint:Point = _mapMatrix.getMatrixPoint(new Point(tank.x, tank.y));
			var minePoint:Point;
			for each (var mine:Mine in _mines) {
				if (Math.abs(tank.x - mine.x) < mine.distance &&
						Math.abs(tank.y - mine.y) < mine.distance) {
					mine.activate(_scaleTime);
				}
			}
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
		
		/* Internal functions */
		
		private function addMines():void {
			_mines = new Vector.<Mine>();
			const minesCount:int = 10;//Math.random() * 10;
			var mine:Mine;
			for (var i:int = 0; i < minesCount; ++i) {
				mine = new Mine(_mapMatrix.getRandomPoint());
				mine.addEventListener(Event.CONNECT, onMineActivate);
				_mines.push(mine);
				_container.addChild(mine);
			}
		}
		
		private function onMineActivate(event:Event):void {
			const mine:Mine = event.target as Mine;
			mine.removeEventListener(Event.CONNECT, onMineActivate);
			//_container.removeChild(mine);
			dispatchEvent(new MineBamEvent(MineBamEvent.BAM, mine.distance, new Point(mine.x, mine.y)));
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
