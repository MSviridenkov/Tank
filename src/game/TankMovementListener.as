package game {
	import game.mapObjects.MapObjectsController;
	import game.events.TankEvent;
	import game.tank.TankController;
	public class TankMovementListener {
		private var _tankController:TankController;
		private var _mapObjectsController:MapObjectsController;
		
		public function TankMovementListener(tankController:TankController,
																					mapObjectsController:MapObjectsController):void {
			super();
			_tankController =  tankController;
			_mapObjectsController = mapObjectsController;
			addListeners();
		}
		
		/* Internal functions */
		private function addListeners():void {
			_tankController.addEventListener(TankEvent.COME_TO_CELL, onTankComeToCell);
		}
		
		private function onTankComeToCell(event:TankEvent):void {
			_mapObjectsController.checkReactionForTank(_tankController.tank);
		}
		
	}
}
