package game.mapObjects {
	import game.GameController;
	import flash.geom.Point;
	import flash.display.Sprite;

	public class Mine extends Sprite{
		private var _distantion:int;
		
		public function Mine(pint:Point):void {
			_distantion = 3;
			this.x = pint.x;
			this.y = pint.y;
			super();
		}
		
		override public function set x(value:Number):void {
			super.x = value * GameController.CELL + GameController.CELL/2;
		}
		override public function set y(value:Number):void {
			super.y = value * GameController.CELL + GameController.CELL/2;
		}
		override public function get x():Number { return (super.x - GameController.CELL/2) / GameController.CELL;}
		override public function get y():Number { return (super.y - GameController.CELL/2) / GameController.CELL; }
		
		/* API */
		
		public function get distance():int { return _distantion; }
		
		public function activate():void {
			this.graphics.beginFill(0xaa0f00);
			this.graphics.drawCircle(0, 0, 2);
			this.graphics.endFill();
		}
	}
}
