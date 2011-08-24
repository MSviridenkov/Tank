package game.tank {
	import game.GameController;
	import flash.display.Sprite;

	public class Tank extends Sprite {
		public var gun:GunView;
		public var tankBase:TankBaseView;
		public var gunController:GunController;
		
		private var _speedup:Number = 0;
		private var maxSpeedup:Number = .5;
		
		public function Tank() {
			gun = new GunView();
			tankBase = new TankBaseView();
			this.addChild(gun);
			this.addChild(tankBase);
			gunController = new GunController(gun, this);
		}
		
		public function set speedup(value:Number):void {
			if (_speedup < maxSpeedup) { _speedup+= .05; }
		}
		public function get speedup():Number { return _speedup; }
		
		public function updateSpeedup():void { _speedup = 0; }

		
		override public function set x(value:Number):void {
			super.x = value * GameController.CELL + GameController.CELL/2;
		}
		override public function set y(value:Number):void {
			super.y = value * GameController.CELL + GameController.CELL/2;
		}
		override public function get x():Number { return (super.x - GameController.CELL/2) / GameController.CELL;}
		override public function get y():Number { return (super.y - GameController.CELL/2) / GameController.CELL; }
		// * *
		// */
	}
}