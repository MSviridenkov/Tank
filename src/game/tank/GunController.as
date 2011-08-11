package game.tank {
	import flash.geom.Point;

	public class GunController {
		private var _gun:Gun;
		private var _tank:Tank;
		
		public function GunController(tank:Tank) {
		_gun = new Gun;
		_tank = tank;
		_tank.addChild(_gun);
		}
		
		public function gunRotation(point:Point, rotation:uint):void {
			var _point:Point = point;
			var _rotation:uint = rotation;
			
			switch (_rotation) {
				case TankController.DOWN_ROT : {
					_gun.rotation = Math.atan2(_point.y - _tank.y, _point.x - _tank.y)*180/Math.PI + 270;;
					break;
				}
				case TankController.LEFT_ROT : {
					_gun.rotation = Math.atan2(_point.y - _tank.y, _point.x - _tank.y)*180/Math.PI + 180;
					break;
				}
				case TankController.UP_ROT : {
					_gun.rotation = Math.atan2(_point.y - _tank.y, _point.x - _tank.y)*180/Math.PI + 90;
					break;
				}
				case TankController.RIGHT_ROT : {
					_gun.rotation = Math.atan2(_point.y - _tank.y, _point.x - _tank.y)*180/Math.PI;
				}
			}
		}
	}
}
