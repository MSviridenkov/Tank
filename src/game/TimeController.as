package game {
	import com.bit101.components.PushButton;
	import flash.events.MouseEvent;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import game.tank.TankController;
	public class TimeController {
		private var _tankController:TankController;
		private var _container:Sprite;
		
		/* minimal components */
		private var _buttonTimeScale:PushButton;
		
		public function TimeController(container:Sprite, tankController:TankController):void {
			super();
			_tankController = tankController;
			_container = container;
			addButton();
		}
		
		/* Internal functions */
		
		private function addButton():void {
			_buttonTimeScale = new PushButton(_container, 100, 20, "timeScale", onButtonClick);
		}
		
		private function onButtonClick(event:MouseEvent):void {
			if (_tankController.tankTimeline.timeScale > 1) {
				trace("timescale < 1");
				_tankController.tankTimeline.timeScale = 1;
			} else {
				_tankController.tankTimeline.timeScale = 2.3;
			}
		}
	}
}
