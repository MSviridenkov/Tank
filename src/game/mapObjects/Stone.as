package game.mapObjects {
	import game.MapObject;
	import flash.geom.Rectangle;
	import flash.display.Sprite;

	public class Stone extends MapObject {
		private var _rect:Rectangle;
		private var _view:StoneView;
		
		public function Stone(rect:Rectangle) {
			super();
			_rect = rect;
			_view = new StoneView();
			this.x = rect.x;
			this.y = rect.y;
			this.addChild(_view);
		}
		
		private function draw():void {
			this.graphics.beginFill(0x4ff11f, .6);
			this.graphics.drawRoundRect(0, 0, _rect.width, _rect.height, _rect.width, _rect.height);
			this.graphics.endFill();
		}
	}
}
