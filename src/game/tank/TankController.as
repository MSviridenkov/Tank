package game.tank
{
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import game.GameController;
	import game.matrix.MapMatrix;

	public class TankController
	{
		private var _tank:Tank;
		private var _direction:TankDirection;
		
		private var _container:Sprite;
		private var _bulletsController:BulletsController;
		
		private var _startX:Number = 50;
		private var _startY:Number = 50;
		
		private var _cellX:int;
		private var _cellY:int;
		
		private var _moving:Boolean; //true - tank moving now, false - else
		
		public static const LEFT_ROT:int = 270;
		public static const RIGHT_ROT:int = 90;
		public static const UP_ROT:int = 0;
		public static const DOWN_ROT:int = 180;
		
		public static const MOVE_LENGHT:int = GameController.CELL;
		
		public function TankController(c:Sprite, bulletsController:BulletsController):void
		{
			_moving = false;
			_tank = new Tank();
			_container = c;
			_bulletsController = bulletsController;
			c.addChild(_tank);
			_cellX = _startX/GameController.CELL;
			_cellY = _startY/GameController.CELL;
			_tank.x = _startX;
			_tank.y = _startY;
			_direction = new TankDirection(TankDirection.UP_DIR);
		}
		
		
		public function go(direction:uint):void {
			_direction.value = direction;
			if (!canMove()) { return; }
			const nextPoint:Point = _direction.tickPoint(new Point(_tank.x, _tank.y));
			_tank.rotation = _direction.rotation;
			tweenToPoint(new Point(nextPoint.x, nextPoint.y));
		}
		
		public function shot():void {
			_bulletsController.pushBullet(new Point(_tank.x, _tank.y), _direction.value, _direction.rotation);
			tweenBack();
		}
		
		private function tweenToPoint(point:Point):void {
			if (!_moving) {
				TweenMax.to(_tank, .3, {x : point.x, y:point.y, easing: null, onCompelte : function():void { _moving = false; }});
			}
		}
		
		private function tweenBack():void {
			TweenMax.to(_tank, .3, _direction.getBackForTween(new Point(_tank.x, _tank.y)));
		}
		
		private function canMove():Boolean {
			const point:Point = _direction.tickPoint(new Point(_tank.x, _tank.y));
			
			if (point.x / GameController.CELL < 0 || point.x / GameController.CELL > MapMatrix.MATRIX_WIDTH) { return false; }
			if (point.y / GameController.CELL < 0 || point.y / GameController.CELL > MapMatrix.MATRIX_HEIGHT) { return false; }
			return true;
		}
		
	}
}