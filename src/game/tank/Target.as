package game.tank
{
	import flash.display.Sprite;

	public class Target extends Sprite
	{
		public function Target()
		{
			var _tank:Tank = new Tank;
			addChild(_tank);
		}
	}
}