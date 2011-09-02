package game.tank {
	import com.greensock.TweenMax;
	
	import flash.geom.Point;

	public class GunController {
		public var gunRot:int;
		public var abc:Boolean;
	
		private var _t:Tank;
		private var _gun:GunView;
		
		public function GunController(gun:GunView, tank:Tank) {
			_gun = gun;
			_t = tank;
		}
		
		public function gunRotation (point:Point):void {
			var _p:Point = point;
			var angle:int = Math.asin((_p.x - _t.x)/(Math.sqrt((_p.x - _t.x)*(_p.x - _t.x) + (_p.y - _t.y)*(_p.y - _t.y))))*180/Math.PI;
			//var angle2:int = Math.acos((_p.y - _t.y)/(Math.sqrt((_p.x - _t.x)*(_p.x - _t.x) + (_p.y - _t.y)*(_p.y - _t.y))))*180/Math.PI;
			if (_p.y < _t.y) {
				gunRot = angle;
			}
			else {
				gunRot = 180 - angle;
			}
			/*if (_point.y >= _tank.y && _point.x <= _tank.x) {
				gunRot = (180 - angle1)
			}*/
			TweenMax.to(_gun, 1.3, {rotation : gunRot});
		}
		
		public function getBulletPoint(point:Point):Point {
			var angle:int = gunRot;
			var dlinaX:int;
			var dlinaY:int;
			if (-90<angle<90){
				dlinaX = Math.sin(angle/180*Math.PI) * 25;
				dlinaY = Math.cos(angle/180*Math.PI) * 25;
			}
			else{
				dlinaX = Math.sin(angle/180*Math.PI*(-1) + 180) * 25;
				dlinaY = Math.cos(angle/180*Math.PI*(-1) + 180) * 25;
			}
			return new Point(point.x + dlinaX, point.y - dlinaY);
		}
	}
}
