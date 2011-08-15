package game.drawing {
	import com.greensock.TweenMax;
	import flash.display.Shape;
	import flash.utils.Timer;
	import game.GameController;
	import game.matrix.MapMatrix;
	import flash.geom.Point;
	import flash.events.MouseEvent;
	import flash.display.Sprite;

	public class MouseDrawController {
		private var _mapMatrix:MapMatrix;
		private var _path:Vector.<Point>;
		
		private var _maskForRemove:Shape;
		
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
		
		private function initTimer():void {
			
		}
		
		private function drawRectangle():void {
			_container.graphics.beginFill(0x000000, .2);
			_container.graphics.drawRect(0, 0, 
													MapMatrix.MATRIX_WIDTH*GameController.CELL,
													MapMatrix.MATRIX_HEIGHT * GameController.CELL);	
			_container.graphics.endFill();
		}
		
		private function onMouseMove(event:MouseEvent):void {
			if (_drawing) {
				const point:Point = new Point(event.stageX, event.stageY);
				drawPoint(point);
				addPointToPath(point);
			}
		}
		
		private function addPointToPath(point:Point):void {
			const matrixPoint:Point = _mapMatrix.getMatrixPoint(point);
			if (matrixPoint.x != _path[_path.length-1].x ||
					matrixPoint.y != _path[_path.length-1].y) {
				_path.push(matrixPoint);
			}
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
		}
		
		private function onMouseDown(event:MouseEvent):void {
			removePreviousPath();
			_path = new Vector.<Point>();
			_path.push(_mapMatrix.getMatrixPoint(new Point(event.stageX, event.stageY)));
			_drawingContainer.graphics.lineStyle(2, 0x00ff00);
			_drawingContainer.graphics.moveTo(event.stageX, event.stageY);
			_drawing = true;
		}
		private function onMouseUp(event:MouseEvent):void {
			_drawing = false;
			tracePath();
			drawOkPath();
			createMask();
		}
		
		private function drawOkPath():void {
			TweenMax.to(_drawingContainer, .08, {alpha: 0, onComplete: newPathAndShow});
		}
		
		private function newPathAndShow():void {
			_drawingContainer.graphics.clear();
			_drawingContainer.graphics.lineStyle(2, 0x00ff00);
			_drawingContainer.graphics.moveTo(_path[0].x * GameController.CELL, 
																				_path[0].y * GameController.CELL);
			for each (var point:Point in _path) {
				_drawingContainer.graphics.lineTo(point.x * GameController.CELL, point.y * GameController.CELL);
			}
			TweenMax.to(_drawingContainer, .08, {alpha: 1});
		}
		
		private function createMask():void {
			_maskForRemove = new Shape;
			_maskForRemove.graphics.beginFill(0xffffff);
			for each (var point:Point in _path) {
				_maskForRemove.graphics.drawRect(point.x * GameController.CELL - GameController.CELL/2,
																						point.y * GameController.CELL - GameController.CELL/2,
																						GameController.CELL, GameController.CELL);
			}
			_maskForRemove.graphics.endFill();
			_drawingContainer.mask = _maskForRemove;
		}
		
		private function tracePath():void {
			if (!_path) { trace("poteryalsya path"); }
			for each (var point:Point in _path) {
				trace("x: " + point.x + ", y: " + point.y);
			}
		}

	}
}
