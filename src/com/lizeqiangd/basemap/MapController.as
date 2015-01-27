package com.lizeqiangd.basemap
{
	import com.lizeqiangd.basemap.layer.MapLayer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Lizeqiangd
	 */
	public class MapController extends Sprite
	{
		private var map_width:Number = 100
		private var map_height:Number = 100
		
		private var _mousedown_x:int
		private var _mousedown_y:int
		
		private var map_layer:MapLayer
		
		public function MapController()
		{
			resize(map_width, map_height)
		}
		
		public function addMapController():void
		{
			this.addEventListener(MouseEvent.CLICK, onMouseClick)
			this.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel)
			this.addEventListener(MouseEvent.DOUBLE_CLICK, onMouseDoubleClick)
			this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown)
			this.addEventListener(MouseEvent.MOUSE_UP, onMouseUp)
			this.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove)
		}
		
		private function onMouseMove(e:MouseEvent):void
		{
			if (e.buttonDown)
			{
				//e.stageX - _mousedown_x
				//e.stageY-_mousedown_y
				//trace(e.stageX - _mousedown_x, e.stageY - _mousedown_y)
				map_layer.movement(e.stageX - _mousedown_x, e.stageY - _mousedown_y)
				_mousedown_x = e.stageX
				_mousedown_y = e.stageY
			}
		}
		
		private function onMouseUp(e:MouseEvent):void
		{
			trace(e)
		}
		
		private function onMouseDown(e:MouseEvent):void
		{
			_mousedown_x = e.stageX
			_mousedown_y = e.stageY
			trace(e)
		}
		
		private function onMouseDoubleClick(e:MouseEvent):void
		{
			//trace(e)
		
		}
		/**
		 * 鼠标滚轮操作
		 * 往下滚是负 
		 * @param	e
		 */
		private function onMouseWheel(e:MouseEvent):void
		{
			map_layer.scale(e.delta)
		}
		
		private function onMouseClick(e:MouseEvent):void
		{
			//trace(e)
		}
		
		public function removeMapController():void
		{
		
		}
		
		public function set setMapLayer(value:MapLayer):void
		{
			this.map_layer = value
		}
		
		public function resize(w:Number, h:Number):void
		{
			map_width = w
			map_height = h
			
			this.graphics.clear()
			this.graphics.beginFill(0, 0)
			this.graphics.drawRect(0, 0, map_width, map_height)
			this.graphics.endFill()
			
			if (true)
			{
				//this.graphics.beginFill(0xff9900, 0.3)
				//this.graphics.drawRect(0, 0, map_width, map_height)
			}
		}
	}

}