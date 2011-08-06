package
{
	import flash.display.Sprite;

	public class TankController
	{
		private var _tank:Tank;
		private var _direction:uint;
		
		private var _container:Sprite;
		private var _gameController:GameController;
		
		private var _startX:Number = 50;
		private var _startY:Number = 50;
		
		private var _cellX:int;
		private var _cellY:int;
		
		public static const LEFT_DIR:uint = 0;
		public static const RIGHT_DIR:uint = 1;
		public static const UP_DIR:uint = 2;
		public static const DOWN_DIR:uint = 3;
		
		public static const LEFT_ROT:int = -90;
		public static const RIGHT_ROT:int = 90;
		public static const UP_ROT:int = 0;
		public static const DOWN_ROT:int = 180;
		
		private var MOVE_LENGTH:int;
		
		public function TankController(c:Sprite, gameController:GameController):void
		{
			MOVE_LENGTH = GameController.CELL;
			
			_tank = new Tank();
			_gameController = gameController;
			_container = c;
			c.addChild(_tank);
			_cellX = _startX/GameController.CELL;
			_cellY = _startY/GameController.CELL;
			gameController.addTankPos(_cellX, _cellY);
			_tank.x = _startX;
			_tank.y = _startY;
			_direction = UP_DIR;
		}
		
		
		public function go(keyCode:uint):void {
			
			_gameController.cleanCell(_tank.x / GameController.CELL, _tank.y / GameController.CELL);
			switch(keyCode) {
					case "s".charCodeAt(0) : {
						if (canMove(_tank.x, _tank.y + MOVE_LENGTH)) {
							if (! (_direction == DOWN_DIR)) {
								_tank.rotation = DOWN_ROT;
								_direction = DOWN_DIR;
							}
							_tank.y += MOVE_LENGTH;
						}
						break;
					}
					case "a".charCodeAt(0) : {
						if (! (_direction == LEFT_DIR)) {
							_tank.rotation = LEFT_ROT;
							_direction = LEFT_DIR;
						}
						_tank.x -= MOVE_LENGTH;
						break;
					}
					case "w".charCodeAt(0) : {
						if (! (_direction == UP_DIR)) {
							_tank.rotation = UP_ROT;
							_direction = UP_DIR;
						}
						_tank.y -= MOVE_LENGTH;
						break;
					}
					case "d".charCodeAt(0) : {
						if (! (_direction == RIGHT_DIR)) {
							_tank.rotation = RIGHT_ROT;
							_direction = RIGHT_DIR;
						}
						_tank.x += MOVE_LENGTH;
					}
			}
			_gameController.addTankPos(_tank.x / GameController.CELL, _tank.y / GameController.CELL);
		}
		
		public function shot():void {
			var b:Bullet = new Bullet(_tank.x, _tank.y, _direction, _tank.rotation);
			b.startMove();
			_container.addChild(b);
		}
		
		private function canMove(x:Number, y:Number):Boolean {
			if (x / GameController.CELL < 0 || x / GameController.CELL > GameController.MATRIX_WIDTH) { return false; }
			if (y / GameController.CELL < 0 || y / GameController.CELL > GameController.MATRIX_HEIGHT) { return false; }
			trace (x / GameController.CELL, y / GameController.CELL);
			return true;
		}
		
	}
}