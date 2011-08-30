package game {
	import game.tank.Tank;
	import game.events.TargetsControllerEvent;
	import game.events.TankShotingEvent;
	import flash.geom.Point;
	import flash.events.MouseEvent;
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
			listenStageEvents();
		}
		
		private function initControllers():void {
			_mapMatrix = new MapMatrix(_container);
			_mapMatrix.drawMatrix();
			_mouseDrawController = new MouseDrawController(_container, _mapMatrix);
			_bulletsController = new BulletsController(_container);
			_tankController = new TankController(_container, _mapMatrix);
			_targetsController = new TargetsController(_container);
			_mapObjectsController = new MapObjectsController(_mapMatrix, _container);
			initMapObjectsController();
			_tankMovementListener = new TankMovementListener(_tankController, _mapObjectsController,
																												_mouseDrawController);
			_timeController = new TimeController(_container);
			initTimeController();
		}
		
		private function initTimeController():void {
			_timeController.add_controller(_tankController);
			_timeController.add_controller(_mapObjectsController);
		}
		private function initMapObjectsController():void {
			_mapObjectsController.drawObjects();
			if(_targetsController && _targetsController.enemyTanks) {
				for each (var tank:Tank in _targetsController.enemyTanks) {
					_mapObjectsController.addEnemyTank(tank);
				}
			}
		}
		
		private function listenControllers():void {
			_mouseDrawController.addEventListener(DrawingControllerEvent.WANT_START_DRAW, onWantStartDraw);
			_mouseDrawController.addEventListener(DrawingControllerEvent.NEW_MOVE_POINT, onNewMovePoint);
			_mouseDrawController.addEventListener(DrawingControllerEvent.DRAWING_COMPLETE, onDrawingComplete);
			_mapObjectsController.addEventListener(MineBamEvent.BAM, onMineBam);
			_tankController.addEventListener(TankShotingEvent.WAS_SHOT, onTankShot);
			_targetsController.addEventListener(TargetsControllerEvent.NEW_TANK, onNewEnemyTank);
		}
		
		private function listenStageEvents():void {
			_container.addEventListener(MouseEvent.CLICK, onStageClick);
		}
		
		private function killTank():void {
			_mouseDrawController.removeEventListener(DrawingControllerEvent.WANT_START_DRAW, onWantStartDraw);
			_mouseDrawController.removeEventListener(DrawingControllerEvent.NEW_MOVE_POINT, onNewMovePoint);
			_mouseDrawController.removeEventListener(DrawingControllerEvent.DRAWING_COMPLETE, onDrawingComplete);
			_mapObjectsController.removeEventListener(MineBamEvent.BAM, onMineBam);
			_tankController.removeEventListener(TankShotingEvent.WAS_SHOT, onTankShot);
		}
		
		/* event handlers */
		
		private function onStageClick(event:MouseEvent):void {
			const point:Point = new Point(event.stageX, event.stageY);
			if (!_tankController.isPointOnTank(point)) {
				_tankController.shot(point);
			}
		}
		
		private function onMineBam(event:MineBamEvent):void {
			if (Math.abs(_tankController.tank.x - event.minePoint.x) < event.distantion &&
					Math.abs(_tankController.tank.y - event.minePoint.y) < event.distantion) {
				_tankController.bam();
				killTank();
			}
		}
		
		private function onTankShot(event:TankShotingEvent):void {
			_mapObjectsController.addBullet(event.bullet);
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
		
		private function onNewEnemyTank(event:TargetsControllerEvent):void {
			_mapObjectsController.addEnemyTank(event.tank);
		}
	}
}