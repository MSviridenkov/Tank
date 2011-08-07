package tank
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import matrix.MapMatrix;

	public class TankController
	{
		private var _tank:Tank;
		private var _direction:TankDirection;
		
		private var _container:Sprite;
		private var _gameController:GameController;
		
		private var _startX:Number = 50;
		private var _startY:Number = 50;
		
		private var _cellX:int;
		private var _cellY:int;
		
		public static const LEFT_ROT:int = -90;
		public static const RIGHT_ROT:int = 90;
		public static const UP_ROT:int = 0;
		public static const DOWN_ROT:int = 180;
		
		public static const MOVE_LENGHT:int = GameController.CELL;
		
		public function TankController(c:Sprite, gameController:GameController):void
		{
			
			_tank = new Tank();
			_gameController = gameController;
			_container = c;
			c.addChild(_tank);
			_cellX = _startX/GameController.CELL;
			_cellY = _startY/GameController.CELL;
			//gameController.addTankPos(_cellX, _cellY);
			_tank.x = _startX;
			_tank.y = _startY;
			_direction = new TankDirection(TankDirection.UP_DIR);
		}
		
		
		public function go(direction:uint):void {
			
			//_gameController.cleanCell(_tank.x / GameController.CELL, _tank.y / GameController.CELL);
			_direction.value = direction;
			if (!canMove()) { return; }
			const nextPoint:Point = _direction.tickPoint(new Point(_tank.x, _tank.y));
			_tank.rotation = _direction.rotation;
			_tank.x = nextPoint.x;
			_tank.y = nextPoint.y;
			//_gameController.addTankPos(_tank.x / GameController.CELL, _tank.y / GameController.CELL);
		}
		
		public function shot():void {
			var b:Bullet = new Bullet(_tank.x, _tank.y, _direction.value, _tank.rotation, _gameController.returnTarget());
			b.startMove();
			_container.addChild(b);
		}
		
		private function canMove():Boolean {
			const point:Point = _direction.tickPoint(new Point(_tank.x, _tank.y));
			
			if (point.x / GameController.CELL < 0 || point.x / GameController.CELL > MapMatrix.MATRIX_WIDTH) { return false; }
			if (point.y / GameController.CELL < 0 || point.y / GameController.CELL > MapMatrix.MATRIX_HEIGHT) { return false; }
			trace (point.x / GameController.CELL, point.y / GameController.CELL);
			return true;
		}
		
	}
}