package game.tank {
	import game.events.TankEvent;
	import flash.geom.Point;
	import pathfinder.Pathfinder;
	import game.events.TargetsControllerEvent;
	import flash.events.EventDispatcher;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import game.matrix.MapMatrix;

	public class TargetsController extends EventDispatcher{
		private var _timer:Timer;
		private var _enemyes:Vector.<TankController>;
		private var _container:Sprite;
		private var _mapMatrix:MapMatrix;
		
		private var _playerTank:Tank;
		
		public function TargetsController(container:Sprite, mapMatrix:MapMatrix, playerTank:Tank) {
			_container = container;
			_mapMatrix = mapMatrix;
			_playerTank = playerTank;
			_enemyes = new Vector.<TankController>();
			for (var i:int = 0; i < Math.random() * 5; i++) { createTarget(); }
			initTimer();
			startTimer();
		}
		
		public function getEnemyTanks():Vector.<Tank> {
			const tanks:Vector.<Tank> = new Vector.<Tank>();
			for each (var tankController:TankController in _enemyes) {
				tanks.push(tankController.tank);
			}
			return tanks;
		}
		
		/* Internal functions */
		
		private function createTarget():void {
			var enemyTank:TankController = new TankController(_container, _mapMatrix);
			var rndX:int = Math.random() * MapMatrix.MATRIX_WIDTH;
			var rndY:int = Math.random() * MapMatrix.MATRIX_HEIGHT;
			enemyTank.tank.x = rndX;
			enemyTank.tank.y = rndY;
			enemyTank.setAutoAttack(_playerTank);
			_enemyes.push(enemyTank);
			moveEnemyTank(enemyTank);
			enemyTank.addEventListener(TankEvent.MOVING_COMPLETE, function(event:TankEvent):void {
				moveEnemyTank(enemyTank);
			});
			dispatchEvent(new TargetsControllerEvent(TargetsControllerEvent.NEW_TANK, enemyTank.tank));
		}
		
		private function moveEnemyTank(enemyTankController:TankController):void {
			const toPoint:Point = new Point(int(Math.random()*MapMatrix.MATRIX_WIDTH),
																			int(Math.random()*MapMatrix.MATRIX_HEIGHT));
			const path:Vector.<Point> = 
					Pathfinder.getPath(new Point(enemyTankController.tank.x, enemyTankController.tank.y),
															toPoint);
			addPathToEnemyTankController(path, enemyTankController);
		}
		
		private function addPathToEnemyTankController(path:Vector.<Point>,
																									enemyTankController:TankController):void {
			enemyTankController.readyForMoving();
			for each (var point:Point in path) {
				enemyTankController.addPointToMovePath(point);
			}
		}
		
		private function createTargetforTimer (event:TimerEvent):void {
			if (_enemyes.length <5 && Math.random() < .5) {
				createTarget();
			}
		}
		
		private function initTimer():void {
			_timer = new Timer(5000);
			_timer.addEventListener(TimerEvent.TIMER, createTargetforTimer);
		}
		
		private function startTimer():void {
			_timer.start();
		}
	}
}





