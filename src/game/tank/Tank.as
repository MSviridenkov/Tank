package game.tank {
	import game.GameController;
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
		/*
		override public function set x(value:Number):void {
			super.x = value * GameController.CELL + GameController.CELL/2;
		}
		override public function set y(value:Number):void {
			super.y = value * GameController.CELL + GameController.CELL/2;
		}
		// * *
		// */
	}
}