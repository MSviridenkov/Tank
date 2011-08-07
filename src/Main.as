package
{
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Transform;
	import tank.TankController;
	
	[SWF(width=600, height=600, frameRate=25)]
	public class Main extends Sprite
	{
		var container:Sprite;
		var tankController:TankController; 
		var gameController:GameController;
		
		public function Main()
		{
			container = new Sprite(); 
			this.addChild(container); 
			
			gameController = new GameController(container);
			tankController = new TankController(container, gameController);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		private function onKeyDown(event:KeyboardEvent):void {
			if (event.charCode == "s".charCodeAt(0) ||
					event.charCode == "a".charCodeAt(0) ||
					event.charCode == "d".charCodeAt(0) ||
					event.charCode == "w".charCodeAt(0)){
				tankController.go(event.charCode);
			}
			else if (event.charCode == "q".charCodeAt(0)){
				tankController.shot();
			}
			
		}
	}
}