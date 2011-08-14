package game.tank {
	import flash.geom.Point;

	public class GunController {
		public var gunRot:int;
	
		private var _tank:Tank;
		private var _gun:GunView;
		
		public function GunController(gun:GunView, tank:Tank) {
			_gun = gun;
			_tank = tank;
		}
		
		public function gunRotation (point:Point):void {
			var _point:Point = point;
			var angle1:int = Math.asin((_point.x - _tank.x)/(Math.sqrt((_point.x - _tank.x)*(_point.x - _tank.x) + (_point.y - _tank.y)*(_point.y - _tank.y))))*180/Math.PI;
			var angle2:int = Math.asin((_point.x - _tank.x)/(Math.sqrt((_point.x - _tank.x)*(_point.x - _tank.x) + (_point.y - _tank.y)*(_point.y - _tank.y))))*180/Math.PI*(-1) + 180;
			if (_point.y < _tank.y) {
				gunRot = angle1;
			}
			else {
				gunRot = angle2;
			}
			_gun.rotation = gunRot;
			//_gun.rotation = Math.atan2(_point.y - _gun.y, _point.x - _gun.y)*180/Math.PI + 90;
		}
	}
}
