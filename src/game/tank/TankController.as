package game.tank {
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import game.GameController;
	import game.matrix.MapMatrix;

	public class TankController {
		public var tank:Tank;
		
		private var _direction:TankDirection;
		private var _container:Sprite;
		public var _bulletsController:BulletsController;
		
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
			tank = new Tank();
			_container = container;
			_bulletsController = bulletsController;
			container.addChild(tank);
			_cellX = _startX/GameController.CELL;
			_cellY = _startY/GameController.CELL;
			tank.x = _cellY * GameController.CELL + GameController.CELL/2;
			tank.y = _cellX * GameController.CELL + GameController.CELL/2;
			_direction = new TankDirection(TankDirection.UP_DIR);
		}
		
		public function go(direction:uint):void {
			if (_moving) { return; }
			_direction.value = direction;
			if (!canMove()) { return; }
			const nextPoint:Point = _direction.tickPoint(new Point(tank.x, tank.y));
			tank.tankBase.rotation = _direction.rotation;
			tweenToPointTank(new Point(nextPoint.x, nextPoint.y));
		}
		
		public function shot(point:Point):void {
			tank.gunController.gunRotation( (new Point(point.x, point.y)));
			_bulletsController.pushBullet(new Point(tank.x, tank.y), point);
			_bulletsController.bulletRotate(tank.gunController.gunRot);
		}
		
		private function tweenToPointTank(point:Point):void {
			if (!_moving) {
				_moving = true;
				TweenMax.to(tank, .3, {x : point.x, y:point.y, ease: null, onComplete : function():void { _moving = false; }});
			}
		}
		
		private function canMove():Boolean {
			const point:Point = _direction.tickPoint(new Point(tank.x, tank.y));
			
			if (point.x / GameController.CELL < 0 || point.x / GameController.CELL > MapMatrix.MATRIX_WIDTH) { return false; }
			if (point.y / GameController.CELL < 0 || point.y / GameController.CELL > MapMatrix.MATRIX_HEIGHT) { return false; }
			return true;
		}
		
	}
}