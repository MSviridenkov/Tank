package game.tank {
	import flash.display.Sprite;

	public class Gun extends Sprite {
		public function Gun() {
			var view:Gun_pic = new Gun_pic();
			addChild(view);
		}
	}
}