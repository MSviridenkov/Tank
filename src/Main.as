package {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import game.GameController;
	
	[SWF(width=600, height=600, frameRate=25)]
	public class Main extends Sprite {
		private var container:Sprite; 
		public var gameController:GameController;
		
		public function Main() {
			container = new Sprite(); 
			this.addChild(container);
			
			gameController = new GameController(container);
			
			stage.addEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		private function onMouseClick(event:MouseEvent):void {
			//if (gameController && gameController.tankController) {
			//	gameController.tankController.shot(new Point(event.stageX, event.stageY));
			//}
		}
	
	}
}