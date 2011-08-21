package game.drawing {
	import game.events.DrawingControllerEvent;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import com.greensock.TweenMax;
	import flash.utils.Timer;
	import game.GameController;
	import game.matrix.MapMatrix;
	import flash.geom.Point;
	import flash.events.MouseEvent;
	import flash.display.Sprite;

	public class MouseDrawController extends EventDispatcher{
		private var _mapMatrix:MapMatrix;
		private var _path:Vector.<Point>;
		
		private var _currentMousePoint:Point;
		
		private var _maskForRemove:DrawingMask;
		
		private var _container:Sprite;
		private var _drawingContainer:Sprite;
		private var _drawing:Boolean;
		
		private var _timer:Timer;
		
		public function MouseDrawController(container:Sprite, mapMatrix:MapMatrix) {
			_mapMatrix = mapMatrix;
			_drawing = false;
			_drawingContainer = new Sprite();
			_container = container;
			drawRectangle();
			_container.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			_container.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			_container.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			_container.addChild(_drawingContainer);
			initTimer();
		}
		
		public function get tankPath():Vector.<Point> {
			return _path;
		}
		
		public function get currentMousePoint():Point { return _currentMousePoint; }
		
		public function getLastMovePoint():Point {
			if (_path && _path.length > 0) {
				return _path[_path.length-1];
			}
			return null;
		}
		
		public function startDrawTankPath():void {
			removePreviousPath();
			_path = new Vector.<Point>();
			_path.push(_mapMatrix.getMatrixPoint(new Point(_currentMousePoint.x, 
																											_currentMousePoint.y)));
			_drawingContainer.graphics.lineStyle(2, 0x00ff00);
			_drawingContainer.graphics.moveTo(_currentMousePoint.x, _currentMousePoint.y);
			_drawing = true;
		}
		
		private function initTimer():void {
			_timer = new Timer(900);
			_timer.addEventListener(TimerEvent.TIMER, onTimer);
			_timer.stop();
		}
		
		private function drawRectangle():void {
			_container.graphics.beginFill(0xffffff, .0);
			_container.graphics.drawRect(0, 0, 
													MapMatrix.MATRIX_WIDTH*GameController.CELL,
													MapMatrix.MATRIX_HEIGHT*GameController.CELL);	
			_container.graphics.endFill();
		}
		
		private function onMouseMove(event:MouseEvent):void {
			if (_drawing) {
				const point:Point = new Point(event.stageX, event.stageY);
				drawPoint(point);
				if (newPoint(point)) {
					addPointToPath(point);
					dispatchEvent(new DrawingControllerEvent(DrawingControllerEvent.NEW_MOVE_POINT));
				}
			}
		}
		
		private function newPoint(point:Point):Boolean {
			const matrixPoint:Point = _mapMatrix.getMatrixPoint(point);
			return (matrixPoint.x != _path[_path.length-1].x ||
							matrixPoint.y != _path[_path.length-1].y);
		}
		
		private function addPointToPath(point:Point):void {
				_path.push(_mapMatrix.getMatrixPoint(point));
		}
		
		private function drawPoint(point:Point):void {
			_drawingContainer.graphics.lineTo(point.x, point.y);
		}
		
		private function removePreviousPath():void {
			if (_path) {
				_drawingContainer.graphics.clear();
				_path = null;
			}
			if (_drawingContainer.mask) { _drawingContainer.mask = null; }
			_timer.stop();
		}
		
		private function onMouseDown(event:MouseEvent):void {
			_currentMousePoint = new Point(event.stageX, event.stageY);
			dispatchEvent(new DrawingControllerEvent(DrawingControllerEvent.WANT_START_DRAW));
		}
		
		private function onMouseUp(event:MouseEvent):void {
			//dispatchEvent(new DrawingControllerEvent(DrawingControllerEvent.DRAWING_COMPLETE));
			if (_path) {
				_drawing = false;
				drawOkPath();
				_path.shift();
				_path.shift();
				createMask();
			}
		}
		
		private function drawOkPath():void {
			TweenMax.to(_drawingContainer, .08, {alpha: 0, onComplete: newPathAndShow});
		}
		
		private function newPathAndShow():void {
			if (!_path || _path.length == 0) { return; }
			_drawingContainer.graphics.clear();
			_drawingContainer.graphics.lineStyle(2, 0x00ff00);
			_drawingContainer.graphics.moveTo(_path[0].x * cellWidth + cellWidth/2, 
																				_path[0].y * cellWidth + cellWidth/2);
			for each (var point:Point in _path) {
				_drawingContainer.graphics.lineTo(point.x * cellWidth + cellWidth/2,
																					point.y * cellWidth + cellWidth/2);
			}
			TweenMax.to(_drawingContainer, .08, {alpha: 1});
		}
		
		private function createMask():void {
			_maskForRemove = new DrawingMask();
			_maskForRemove.draw(_path);
			_drawingContainer.mask = _maskForRemove;
			startTimer();
		}
		
		private function startTimer():void {
			_timer.start();
		}
		private function onTimer(event:TimerEvent):void {
			_maskForRemove.shiftLast();
			_drawingContainer.mask = _maskForRemove;
			if (_maskForRemove.empty) { _timer.stop(); }
		}
		
		private function tracePath():void {
			if (!_path) { trace("poteryalsya path"); }
			for each (var point:Point in _path) {
				trace("x: " + point.x + ", y: " + point.y);
			}
		}
		
		private function get cellWidth():int { return GameController.CELL; }

	}
}
