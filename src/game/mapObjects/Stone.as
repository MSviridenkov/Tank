package game.mapObjects {
	import flash.geom.Rectangle;
	import flash.display.Sprite;

	public class Stone extends Sprite {
		private var _rect:Rectangle;
		
		public function Stone(rect:Rectangle) {
			super();
			_rect = rect;
			this.x = rect.x;
			this.y = rect.y;
			draw();
		}
		
		private function draw():void {
			this.graphics.beginFill(0x4ff11f, .6);
			this.graphics.drawRoundRect(0, 0, _rect.width, _rect.height, _rect.width, _rect.height);
			this.graphics.endFill();
		}
	}
}
