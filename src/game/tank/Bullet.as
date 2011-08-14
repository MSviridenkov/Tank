package game.tank {
	import flash.display.Sprite;
	
	public class Bullet extends Sprite {
		
		public function Bullet(x:int, y:int):void {
			var view:Bullet_pic = new Bullet_pic();
			addChild(view);
			this.x = x;
			this.y = y;
		}
		
	}
}