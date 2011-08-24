package game.tank {
	import game.GameController;
	import com.greensock.TweenMax;
	import flash.geom.Point;

	public class TankDirection {
		public static const LEFT_DIR:uint = 0;
		public static const RIGHT_DIR:uint = 1;
		public static const UP_DIR:uint = 2;
		public static const DOWN_DIR:uint = 3;
		
		public var _rotation:uint;
		
		private var _value:uint;
		
		public function TankDirection(defaultDirection:uint) {
			super();
			_value = defaultDirection;
			updateRotation();
		}
		
		public function get value():uint { return _value; }
		public function set value(value:uint):void {
			_value = value;
			updateRotation();
		}
		
		public function get rotation():uint { return _rotation; }
		
		public function rotateIfNeed(tank:Tank, nPoint:Point):Boolean {
			const pPoint:Point = new Point(tank.x, tank.y);
			if (pPoint.x == nPoint.x) {
				if (pPoint.y > nPoint.y) {
					if (_value != UP_DIR) { rotateTank(tank, UP_DIR); }
				} else {
					if (_value != DOWN_DIR) { rotateTank(tank, DOWN_DIR); }
				}
			} else {
				if (pPoint.x > nPoint.x) {
					if (_value != LEFT_DIR) { rotateTank(tank, LEFT_DIR); }
				} else {
					if (_value != RIGHT_DIR) {rotateTank(tank, RIGHT_DIR); }
				}
			}
			return false;
		}
		
		private function rotateTank(tank:Tank, dir:uint):void {
			_value = dir;
			updateRotation();
			TweenMax.to(tank.tankBase, .5, {rotation : _rotation});
			
		}
		
		public function tickPoint(point:Point):Point {
			const res:Point = point;
			switch(_value) {
				case DOWN_DIR : {
					res.y += TankController.MOVE_LENGHT;
					break;
				}
				case LEFT_DIR : {
					res.x -= TankController.MOVE_LENGHT;
					break;
				}
				case UP_DIR : {
					res.y -= TankController.MOVE_LENGHT;
					break;
				}
				case RIGHT_DIR : {
					res.x += TankController.MOVE_LENGHT;
				}
			}
			return res;
		}
		
		public function getBackForTween(point:Point):Object {
			const tempPoint:Point = new Point(point.x, point.y);
			const movePoint:Point = tickPoint(tickPoint(tempPoint));
			const xOffset:Number = point.x - movePoint.x;
			const yOffset:Number = point.y - movePoint.y;
			return {x : point.x + xOffset, y : point.y + yOffset};
		}
			
		private function updateRotation():void {
			switch(_value) {
				case DOWN_DIR : {
					_rotation = TankController.DOWN_ROT;
					break;
				}
				case LEFT_DIR : {
					_rotation = TankController.LEFT_ROT;
					break;
				}
				case UP_DIR : {
					_rotation = TankController.UP_ROT;
					break;
				}
				case RIGHT_DIR : {
					_rotation = TankController.RIGHT_ROT;
				}
			}
		}
		
	}
}