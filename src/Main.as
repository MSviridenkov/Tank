package
{
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Transform;
	
	import game.tank.TankController;
	import game.tank.TankDirection;
	import game.GameController;
	
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
				onMoveKey(event);
			}
			else if (event.charCode == "q".charCodeAt(0)){
				tankController.shot();
			}
		}
			
			private function onMoveKey(event:KeyboardEvent):void {
				var direction:uint;
				if (event.charCode == "s".charCodeAt(0)) { direction = TankDirection.DOWN_DIR; }
				if (event.charCode == "a".charCodeAt(0)) { direction = TankDirection.LEFT_DIR; }
				if (event.charCode == "d".charCodeAt(0)) { direction = TankDirection.RIGHT_DIR; }
				if (event.charCode == "w".charCodeAt(0)) { direction = TankDirection.UP_DIR; }
				
				tankController.go(direction);
			}
			
	}
}