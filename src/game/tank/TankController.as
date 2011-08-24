package game.tank {
	import game.events.TankEvent;
	import flash.events.EventDispatcher;
	import com.greensock.core.TweenCore;
	import com.greensock.easing.Linear;
	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import game.GameController;
	import game.mapObjects.MapObjectsController;
	import game.mapObjects.Stone;
	import game.matrix.MapMatrix;

	public class TankController extends EventDispatcher {
		public var tank:Tank;
		
		private var _direction:TankDirection;
		private var _container:Sprite;
		private var _targets:Vector.<Target>;
		private var _targetsPoints:Vector.<Point>;
		private var _targetPoint:Point;
		
		public var _bulletsController:BulletsController;
		private var _mapMatrix:MapMatrix;
		
		private var _startX:Number = 300;
		private var _startY:Number = 300;
		
		private var _cellX:int;
		private var _cellY:int;
		
		private var _currentPath:Vector.<Point>;
		
		private var _movingTimeline:TimelineMax;
		
		private var _moving:Boolean; //true - tank moving now, false - else
		
		public static const LEFT_ROT:int = 270;
		public static const RIGHT_ROT:int = 90;
		public static const UP_ROT:int = 0;
		public static const DOWN_ROT:int = 180;
		
		public static const MOVE_LENGHT:int = GameController.CELL;
		
		public function TankController(container:Sprite, bulletsController:BulletsController,
																		mapMatrix:MapMatrix):void {
			_moving = false;
			tank = new Tank();
			_movingTimeline = new TimelineMax();
			_container = container;
			_mapMatrix = mapMatrix;
			_bulletsController = bulletsController;
			container.addChild(tank);
			_cellX = _startX/GameController.CELL;
			_cellY = _startY/GameController.CELL;
			tank.x = _cellY;// * GameController.CELL + GameController.CELL/2;
			tank.y = _cellX;// * GameController.CELL + GameController.CELL/2;
			_direction = new TankDirection(TankDirection.UP_DIR);
			_targetsPoints = new Vector.<Point>();
		}
		
		public function xByCell(cellX:int):Number {
			return cellX * GameController.CELL + GameController.CELL/2;
		}
		public function yByCell(cellY:int):Number {
			return cellY * GameController.CELL + GameController.CELL/2;
		}
		
		public function isPointOnTank(point:Point):Boolean {
			return tank.hitTestPoint(point.x, point.y);
		}
/*		
		public function goWithPath(path:Vector.<Point>):void {
			if (!path || path.length < 2) { return; }
			_currentPath = path;
			var tween:TweenMax;
			var timeline:TimelineMax = new TimelineMax();
			for (var i:int = 1; i < path.length; ++i) {
				tween = new TweenMax(tank, .9, {x : xByCell(path[i].x), y : yByCell(path[i].y)});
				timeline.append(tween);
			}
		}
		 * 
		 */
		 
		public function readyForMoving():void {
			tank.updateSpeedup();
			_movingTimeline.kill();
			_movingTimeline = new TimelineMax();
			//_currentPath = new Vector.<Point>;
		}
		
		public function addPointToMovePath(point:Point):void {
			if (!point) { return; }
			const speedCoef:Number = _mapMatrix.getSpeedForTank(point);
			_movingTimeline.append(new TweenMax(tank, speedCoef * (.9 - tank.speedup--), 
						{x : point.x, y : point.y, 
						ease : Linear.easeNone,
						onStart : onStartMoveToPathNode,
						onStartParams : [point],
						onComplete : function():void { trace("complete"); }}));
			_movingTimeline.play();
		}
		
		private function onStartMoveToPathNode(point:Point):void {
			_direction.rotateIfNeed(tank, point);
			dispatchEvent(new TankEvent(TankEvent.COME_TO_CELL));
			//_mapMatrix.getSpeedForTank(point);
		}
/*		
		private function checkRotate(nPoint:Point, pPoint:Point):void {
			if (_direction.needRotate(nPoint, pPoint)) {
				TweenMax.to(tank.tankBase, .5, 
										_direction.getRotationTween(nPoint, pPoint));
			}
		}
		 * 
		 */
		
		public function go(direction:uint):void {
			if (_moving) { return; }
			_direction.value = direction;
			if (!canMove()) { return; }
			const nextPoint:Point = _direction.tickPoint(new Point(tank.x, tank.y));
			tank.tankBase.rotation = _direction.rotation;
			tweenToPointTank(new Point(nextPoint.x, nextPoint.y));
		}
		
		public function shot(point:Point):void {
			tank.gunController.gunRotation( _mapMatrix.getMatrixPoint((new Point(point.x, point.y))));
			_bulletsController.pushBullet(_mapMatrix.getStagePoint(new Point(tank.x, tank.y)),
																		point, tank.gunController.gunRot);
			_bulletsController.bulletRotate(tank.gunController.gunRot);
		}

		public function addTarget(targets:Vector.<Target>):void {
			_targets = targets;
		}
		
		public function addTargetPoint(tpoint:Point):void {
			_targetsPoints.unshift(tpoint);
		}
		
		private function tweenToPointTank(point:Point):void {
			if (!_moving) {
				_moving = true;
				TweenMax.to(tank, .3, {x : point.x, y:point.y,
															 ease: Linear.easeNone,
															 onComplete : function ():void { _moving = false; }});
			}
		}
		
		private function canMove():Boolean {
			const point:Point = _direction.tickPoint(new Point(tank.x, tank.y));
			
			if (point.x / GameController.CELL < 0 || point.x / GameController.CELL > MapMatrix.MATRIX_WIDTH) { return false; }
			if (point.y / GameController.CELL < 0 || point.y / GameController.CELL > MapMatrix.MATRIX_HEIGHT) { return false; }
			for each (var targetPoint:Point in _targetsPoints) {
				if (point.x == targetPoint.x && point.y == targetPoint.y) {return false;}
			}
			trace ("point:", point.x, point.y, "tank",tank.x, tank.y, "target", targetPoint.x, targetPoint.y )
			return true;
		}
	}
}