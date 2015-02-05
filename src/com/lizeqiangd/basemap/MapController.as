package com.lizeqiangd.basemap
{
	import com.lizeqiangd.basemap.component.LatLng;
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
		
		private var map_layer:MapLayer
		
		private var mouse_down_x:int = 0
		private var mouse_down_y:int = 0
		
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
		
		/**
		 * 鼠标按下后拖动操作.
		 * @param	e
		 */
		private function onMouseMove(e:MouseEvent):void
		{
			if (e.buttonDown)
			{
				map_layer.movement(e.localX - mouse_down_x, e.localY - mouse_down_y)
				mouse_down_x = e.localX
				mouse_down_y = e.localY
			}
		}
		
		private function onMouseUp(e:MouseEvent):void
		{
			//trace(e)
		}
		
		private function onMouseDown(e:MouseEvent):void
		{
			mouse_down_x = e.localX
			mouse_down_y = e.localY
			map_layer.getLatlngByXY(mouse_down_x, mouse_down_y)
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
			mouse_down_x = e.localX
			mouse_down_y = e.localY
			var temp_z:int = map_layer.zoom
			var ll:LatLng = map_layer.getLatlngByXY(mouse_down_x, mouse_down_y)
			if (e.delta > 0)
			{
				temp_z++
			}
			if (e.delta < 0)
			{
				temp_z--
			}
			map_layer.center(ll.lng,ll.lat,temp_z)
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
			
			if (false)
			{
				this.graphics.beginFill(0xff9900, 0.3)
				this.graphics.drawRect(0, 0, map_width, map_height)
			}
		}
	}

}