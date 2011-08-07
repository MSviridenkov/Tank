package game.tank
{
	import flash.display.Shape;
	import flash.display.Sprite;

	public class Target extends Shape
	{
		public function Target()
		{
			this.graphics.beginFill(0x0f0f0f);
			this.graphics.drawCircle(0, 0, 10);
			this.graphics.endFill();
		}
	}
}