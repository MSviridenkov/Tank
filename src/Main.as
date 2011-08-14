package {
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Transform;
	
	import game.GameController;
	import game.tank.TankController;
	import game.tank.TankDirection;
	
	[SWF(width=600, height=600, frameRate=25)]
	public class Main extends Sprite {
		private var container:Sprite; 
		public var gameController:GameController;
		
		public function Main() {
			container = new Sprite(); 
			this.addChild(container); 
			
			gameController = new GameController(container);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		private function onMouseClick(event:MouseEvent):void {
			gameController.tankController.shot(new Point(event.stageX, event.stageY));
			gameController.tankController.tank.gunController.gunRotation( (new Point(event.stageX, event.stageY)));
			gameController.tankController._bulletsController.bulletRotate(gameController.tankController.tank.gunController.gunRot);
		}
		
		private function onKeyDown(event:KeyboardEvent):void {
			if (event.charCode == "s".charCodeAt(0) ||
					event.charCode == "a".charCodeAt(0) ||
					event.charCode == "d".charCodeAt(0) ||
					event.charCode == "w".charCodeAt(0)){
				onMoveKey(event);
			}
			//else if (event.charCode == "q".charCodeAt(0)){
			//	gameController.tankController.shot();
			//}
		}
			
			private function onMoveKey(event:KeyboardEvent):void {
				var direction:uint;
				if (event.charCode == "s".charCodeAt(0)) { direction = TankDirection.DOWN_DIR; }
				if (event.charCode == "a".charCodeAt(0)) { direction = TankDirection.LEFT_DIR; }
				if (event.charCode == "d".charCodeAt(0)) { direction = TankDirection.RIGHT_DIR; }
				if (event.charCode == "w".charCodeAt(0)) { direction = TankDirection.UP_DIR; }
				
				gameController.tankController.go(direction);
			}
			
	}
}