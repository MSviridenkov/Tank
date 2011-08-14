package game.mapObjects {
	import game.GameController;
	import flash.display.Sprite;

	public class Stone extends Sprite {
		public var mX:int;
		public var mY:int;
		
		public function Stone(mX:int, mY:int) {
			super();
			this.mX = mX;
			this.mY = mY;
			this.x = GameController.CELL * mX;
			this.y = GameController.CELL * mY;
			draw();
		}
		
		private function draw():void {
			this.graphics.beginFill(0xbabfff);
			this.graphics.drawRect(-GameController.CELL/2,
															-GameController.CELL/2,
															GameController.CELL,
															GameController.CELL);
			this.graphics.endFill();
		}
	}
}
