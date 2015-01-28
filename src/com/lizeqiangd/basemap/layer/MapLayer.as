package com.lizeqiangd.basemap.layer
{
	import com.lizeqiangd.basemap.config.MapSetting;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	/**
	 * 所有层都在本层上显示
	 * @author Lizeqiangd
	 */
	public class MapLayer extends Sprite
	{
		private var map_setting:MapSetting
		
		private var arrTilesLayer:Vector.<TilesLayer>
		private var sp_mask:Shape
		
		private var maplayer_height:Number = 0
		private var maplayer_width:Number = 0
		
		private var now_z_index:uint = 0
		
		public function MapLayer()
		{
			this.mouseChildren = false
			this.mouseEnabled = false
			arrTilesLayer = new Vector.<TilesLayer>
			sp_mask = new Shape
			sp_mask.graphics.beginFill(0, 0)
			sp_mask.graphics.drawRect(0, 0, 10, 10)
			sp_mask.graphics.endFill()
			
			map_setting = MapSetting.getInstance
			
			for (var i:uint = 0; i <= map_setting.max_level; i++)
			{
				var tileslayer:TilesLayer = new TilesLayer(i)
				arrTilesLayer[i] = tileslayer
			}
			addChild(getDisplayLayer)
		}
		
		public function init():void
		{
			getDisplayLayer.center(121.13131313, 31.2323)
		}
		
		/**
		 * 设置地图尺寸.并且只更新当前显示的地图.因此效率会高.
		 * @param	w
		 * @param	h
		 */
		public function resize(w:Number, h:Number):void
		{
			maplayer_width = w
			maplayer_height = h
			sp_mask.width = maplayer_width
			sp_mask.height = maplayer_height
			getDisplayLayer.resize(maplayer_width, maplayer_height)
			//getDisplayLayer.scaleX = ge9tDisplayLayer.scaleY = 1
		}
		
		/**
		 * 移动地图. (只需要输入相对的X.Y
		 * @param	delta_x
		 * @param	detal_y
		 */
		public function movement(delta_x:Number, detal_y:Number):void
		{
			getDisplayLayer.movement(delta_x, detal_y)
		}
		
		/**
		 * 缩放地图.目前只有加减算法
		 * @param	scale_step
		 */
		public function scale(scale_step:Number):void
		{
			var temp_z:int = now_z_index
			if (scale_step > 0)
			{
				temp_z++
			}
			if (scale_step < 0)
			{
				temp_z--
			}
			showDisplayLayerZoom(temp_z)
		
		}
		
		/**
		 * 显示居中点.
		 * @param	lng
		 * @param	lat
		 * @param	z
		 */
		public function center(lng:Number, lat:Number, z:uint):void
		{
			showDisplayLayerZoom(z)
			getDisplayLayer.center(lng, lat)
		}
		
		/**
		 * 获取当前显示的TileLayer
		 */
		public function get getDisplayLayer():TilesLayer
		{
			return arrTilesLayer[now_z_index]
		}
		
		private function showDisplayLayerZoom(z:int):void
		{
			if (z >= map_setting.max_level)
			{
				z = map_setting.max_level
			}
			if (z <= 0)
			{
				z = 0
			}
			if (z == now_z_index)
			{
				return
			}
			removeChild(getDisplayLayer)
			now_z_index = z
			addChild(getDisplayLayer)
			
			getDisplayLayer.center(121.13131313, 31.2323)
			getDisplayLayer.resize(maplayer_width, maplayer_height)
		}
	}

}