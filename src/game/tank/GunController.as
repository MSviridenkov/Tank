package game.tank {
	public class GunController {
		private var _gun:Gun;
		private var _tank:Tank;
		public function GunController(tank:Tank) {
		_gun = new Gun;
		_tank = tank;
		_tank.addChild(_gun);
		}
	}
}