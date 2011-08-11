package game.tank {
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import game.GameController;
	import game.matrix.MapMatrix;

	public class TankController {
		public var _tank:Tank;
		public var _direction:TankDirection;
		public var gunController:GunController;
		
		private var _container:Sprite;
		private var _bulletsController:BulletsController;
		
		private var _startX:Number = 300;
		private var _startY:Number = 300;
		
		private var _cellX:int;
		private var _cellY:int;
		
		private var _moving:Boolean; //true - tank moving now, false - else
		
		public static const LEFT_ROT:int = 270;
		public static const RIGHT_ROT:int = 90;
		public static const UP_ROT:int = 0;
		public static const DOWN_ROT:int = 180;
		
		public static const MOVE_LENGHT:int = GameController.CELL;
		
		public function TankController(container:Sprite, bulletsController:BulletsController):void {
			_moving = false;
			_tank = new Tank();
			_container = container;
			_bulletsController = bulletsController;
			container.addChild(_tank);
			_cellX = _startX/GameController.CELL;
			_cellY = _startY/GameController.CELL;
			_tank.x = _startX;
			_tank.y = _startY;
			_direction = new TankDirection(TankDirection.UP_DIR);
			gunController = new GunController(_tank);
		}
		
		public function go(direction:uint):void {
			_direction.value = direction;
			if (!canMove()) { return; }
			const nextPoint:Point = _direction.tickPoint(new Point(_tank.x, _tank.y));
			_tank.rotation = _direction.rotation;
			tweenToPoint(new Point(nextPoint.x, nextPoint.y));
		}
		
		public function shot(point:Point):void {
			_bulletsController.pushBullet(new Point(_tank.x, _tank.y), point);
		}
		
		private function tweenToPoint(point:Point):void {
			if (!_moving) {
				TweenMax.to(_tank, .3, {x : point.x, y:point.y, easing: null, onCompelte : function():void { _moving = false; }});
			}
		}
		
		private function canMove():Boolean {
			const point:Point = _direction.tickPoint(new Point(_tank.x, _tank.y));
			
			if (point.x / GameController.CELL < 0 || point.x / GameController.CELL > MapMatrix.MATRIX_WIDTH) { return false; }
			if (point.y / GameController.CELL < 0 || point.y / GameController.CELL > MapMatrix.MATRIX_HEIGHT) { return false; }
			return true;
		}
		
	}
}