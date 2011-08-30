package game.mapObjects {
	import game.tank.Bullet;
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
		private var _bullets:Vector.<Bullet>;
		private var _enemyTanks:Vector.<Tank>;
		
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
			if (_bullets) {
				for each (var bullet:Bullet in _bullets) {
					bullet.scaleTime(value);
				}
			}
		}
		
		public function checkReactionForTank(tank:Tank):void {
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
		
		public function addBullet(bullet:Bullet):void {
			if (!_bullets) { _bullets = new Vector.<Bullet>(); }
			_bullets.push(bullet);
			bullet.scaleTime(_scaleTime);
			bullet.onComplete(onBulletComplete);
			bullet.onUpdate(onBulletUpdate);
		}
		
		public function addEnemyTank(tank:Tank):void {
			if (!_enemyTanks) { _enemyTanks = new Vector.<Tank>(); }
			_enemyTanks.push(tank);
		}
		
		/* Internal functions */
		
		private function addStone(mPoint:Point):void {
			var stone:Stone;
			stone = new Stone(_mapMatrix.getStageRectangle(mPoint));
			if (!_stones) { _stones = new Vector.<Stone>(); }
			_stones.push(stone);
			_container.addChild(stone);
		}
		
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
			removeMineFromList(mine);
			dispatchEvent(new MineBamEvent(MineBamEvent.BAM, mine.distance, new Point(mine.x, mine.y)));
		}
		private function removeMineFromList(mine:Mine):void {
			const mineIndex:int = _mines.indexOf(mine);
			if (mineIndex >= 0) { _mines.splice(mineIndex, 1); }
		}
		
		/* bullet functions */
		private function onBulletUpdate(bullet:Bullet):void {
			checkHitEnemyTank(bullet);
			checkHitStone(bullet);
		}
		private function checkHitEnemyTank(bullet:Bullet):void {
			if (!_enemyTanks) { return; }
			for each (var enemyTank:Tank in _enemyTanks) {
				if (bullet.hitTestObject(enemyTank)) {
					removeBullet(bullet);
					removeTank(enemyTank);
				}
			}
		}
		private function checkHitStone(bullet:Bullet):void {
			if (!_stones) { return; }
			for each (var stone:Stone in _stones) {
				if (bullet.hitTestObject(stone)) {
					removeBullet(bullet);
				}
			}
		}
		private function onBulletComplete(bullet:Bullet):void {
			removeBullet(bullet);
		}
		private function removeBullet(bullet:Bullet):void {
			if (_container.contains(bullet)) { _container.removeChild(bullet); }
			const index:int = _bullets.indexOf(bullet);
			if (index >= 0) { _bullets.splice(index, 1); }
		}
		
		/* enemy tanks functions */
		private function removeTank(tank:Tank):void {
			if (_container.contains(tank)) { _container.removeChild(tank); }
			const index:int = _enemyTanks.indexOf(tank);
			if (index >= 0) { _enemyTanks.splice(index, 1); }
		}
		
	}
}
