package game.tank {
	import flash.display.Sprite;

	public class Tank extends Sprite {
		public var gun:GunView;
		public var tankBase:TankBaseView;
		public var gunController:GunController;
		
		public function Tank() {
			gun = new GunView();
			tankBase = new TankBaseView();
			this.addChild(gun);
			this.addChild(tankBase);
			gunController = new GunController(gun, this);
		}
	}
}