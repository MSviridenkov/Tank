package game.tank {
	import game.IControllerWithTime;
	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	import game.events.TankEvent;
	import game.matrix.MapMatrix;

	public class TankController extends EventDispatcher
															implements IControllerWithTime{
		public var tank:Tank;
		
		private var _scaleTime:Number;
		
		private var _direction:TankDirection;
		private var _container:Sprite;
		private var _mapMatrix:MapMatrix;
		
		private var _startX:Number = 300;
		private var _startY:Number = 300;
		
		private var _movingTimeline:TimelineMax;
		
		private var _moving:Boolean; //true - tank moving now, false - else
		
		public static const LEFT_ROT:int = -90;
		public static const RIGHT_ROT:int = 90;
		public static const UP_ROT:int = 0;
		public static const DOWN_ROT_PLUS:int = 180;
		public static const DOWN_ROT_MINUS:int =-180;
		
		public function TankController(container:Sprite, mapMatrix:MapMatrix):void {
			_moving = false;
			_scaleTime = 1;
			tank = new Tank();
			_movingTimeline = new TimelineMax();
			_direction = new TankDirection(TankDirection.UP_DIR);
			_container = container;
			_mapMatrix = mapMatrix;
			tank.x = _mapMatrix.getMatrixPoint(new Point(_startX, _startY)).x;
			tank.y = _mapMatrix.getMatrixPoint(new Point(_startX, _startY)).y;
			container.addChild(tank);
		}
		
		public function get tankTimeline():TimelineMax { return _movingTimeline; }
		
		public function scaleTime(value:Number):void {
			_scaleTime = value;
			if (_movingTimeline) {
				_movingTimeline.timeScale = value;
				trace("timeScale with existing movingTimeline");
			}
		}
		
		public function isPointOnTank(point:Point):Boolean {
			return tank.hitTestPoint(point.x, point.y);
		}
		
		public function bam():void {
			tank.bam();
			TweenMax.killTweensOf(tank);
		}
		
		public function readyForMoving():void {
			tank.updateSpeedup();
			_movingTimeline.kill();
			_movingTimeline = new TimelineMax();
			_movingTimeline.timeScale = _scaleTime;
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
		}
		
		public function shot(point:Point):void {
			tank.gunController.gunRotation( _mapMatrix.getMatrixPoint((new Point(point.x, point.y))));
			//_bulletsController.pushBullet(_mapMatrix.getStagePoint(new Point(tank.x, tank.y)),
			//															point, tank.gunController.gunRot);
			//_bulletsController.bulletRotate(tank.gunController.gunRot);
		}
		
}
}