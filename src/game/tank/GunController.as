package game.tank {
	import flash.display.Sprite;
	import flash.geom.Point;

	public class GunController {
		public var gunRot:int;
		
		private var _gun:GunView;
		
		public function GunController(gun:GunView) {
			_gun = gun;
		}
		
		public function gunRotation (point:Point):void {
			var _point:Point = point;
			var angle1:int = Math.asin((_point.x - _gun.x)/(Math.sqrt((_point.x - _gun.x)*(_point.x - _gun.x) + (_point.y - _gun.y)*(_point.y - _gun.y))))*180/Math.PI;
			var angle2:int = Math.asin((_point.x - _gun.x)/(Math.sqrt((_point.x - _gun.x)*(_point.x - _gun.x) + (_point.y - _gun.y)*(_point.y - _gun.y))))*180/Math.PI*(-1) + 180;
			if (_point.y < _gun.y) {
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
