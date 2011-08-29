package game {
	import game.events.MineBamEvent;
	import game.mapObjects.MapObjectsController;
	import game.events.DrawingControllerEvent;
	import game.drawing.MouseDrawController;
	import game.matrix.MapMatrix;
	import flash.display.Sprite;
	import game.tank.BulletsController;
	import game.tank.TankController;
	import game.tank.TargetsController;

	public class GameController {
		private var _container:Sprite;
		private var _bulletsController:BulletsController;
		private var _tankController:TankController;
		private var _tankMovementListener:TankMovementListener;
		private var _targetsController:TargetsController;
		private var _mapMatrix:MapMatrix;
		private var _mapObjectsController:MapObjectsController;
		private var _mouseDrawController:MouseDrawController;
		private var _timeController:TimeController;
		
		public static const CELL:int = 40;
		
		public function GameController(c:Sprite):void {
			_container = c;
			initControllers();
			listenControllers();
		}
		
		private function initControllers():void {
			_mapMatrix = new MapMatrix(_container);
			_mapMatrix.drawMatrix();
			_mouseDrawController = new MouseDrawController(_container, _mapMatrix);
			_bulletsController = new BulletsController(_container);
			_tankController = new TankController(_container, _mapMatrix);
			_targetsController = new TargetsController(_container);
			_mapObjectsController = new MapObjectsController(_mapMatrix, _container);
			_mapObjectsController.drawObjects();
			_tankMovementListener = new TankMovementListener(_tankController, _mapObjectsController,
																												_mouseDrawController);
			_timeController = new TimeController(_container);
			initTimeController();
		}
		
		private function initTimeController():void {
			_timeController.add_controller(_tankController);
			_timeController.add_controller(_mapObjectsController);
		}
		
		private function listenControllers():void {
			_mouseDrawController.addEventListener(DrawingControllerEvent.WANT_START_DRAW, onWantStartDraw);
			_mouseDrawController.addEventListener(DrawingControllerEvent.NEW_MOVE_POINT, onNewMovePoint);
			_mouseDrawController.addEventListener(DrawingControllerEvent.DRAWING_COMPLETE, onDrawingComplete);
			_mapObjectsController.addEventListener(MineBamEvent.BAM, onMineBam);
		}
		
		private function killTank():void {
			_mouseDrawController.removeEventListener(DrawingControllerEvent.WANT_START_DRAW, onWantStartDraw);
			_mouseDrawController.removeEventListener(DrawingControllerEvent.NEW_MOVE_POINT, onNewMovePoint);
			_mouseDrawController.removeEventListener(DrawingControllerEvent.DRAWING_COMPLETE, onDrawingComplete);
			_mapObjectsController.removeEventListener(MineBamEvent.BAM, onMineBam);
		}
		
		/* event handlers */
		
		private function onMineBam(event:MineBamEvent):void {
			if (Math.abs(_tankController.tank.x - event.minePoint.x) < event.distantion &&
					Math.abs(_tankController.tank.y - event.minePoint.y) < event.distantion) {
				_tankController.bam();
				killTank();
			}
		}
		
		private function onNewMovePoint(event:DrawingControllerEvent):void {
			_tankController.addPointToMovePath(_mouseDrawController.getLastMovePoint());
		}
		
		private function onDrawingComplete(event:DrawingControllerEvent):void {
			_timeController.normalize();
		}
		
		private function onWantStartDraw(event:DrawingControllerEvent):void {
			if (_tankController.isPointOnTank(_mouseDrawController.currentMousePoint)) {
				_tankController.readyForMoving();
				_mouseDrawController.startDrawTankPath();
				_timeController.slowDown();
			}
		}
	}
}