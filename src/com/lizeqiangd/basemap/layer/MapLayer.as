package com.lizeqiangd.basemap.layer
{
	import com.lizeqiangd.basemap.component.LatLng;
	import com.lizeqiangd.basemap.config.MapSetting;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	/**
	 * 所有层都在本层上显示
	 * @author Lizeqiangd
	 * 20150129 缩放交给控制器操作.本类只负责显示所需部分和获取数据
	 */
	public class MapLayer extends Sprite
	{
		private var map_setting:MapSetting
		
		private var arrTilesLayer:Vector.<TilesLayer>
		private var sp_mask:Shape
		
		private var maplayer_height:Number = 0
		private var maplayer_width:Number = 0
		
		private var now_z_index:int =0
		
		public function MapLayer()
		{
			this.mouseChildren = false
			this.mouseEnabled = false
			arrTilesLayer = new Vector.<TilesLayer>
			sp_mask = new Shape
			sp_mask.graphics.beginFill(0, 0)
			sp_mask.graphics.drawRect(0, 0, 10, 10)
			sp_mask.graphics.endFill()
			addChild(sp_mask)
			map_setting = MapSetting.getInstance
			
			for (var i:uint =0; i <= map_setting.max_level; i++)
			{
				var tileslayer:TilesLayer = new TilesLayer(i)
				arrTilesLayer[i] = tileslayer
			}
			addChild(getDisplayLayer)
			getDisplayLayer.mask = sp_mask
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
		 * 根据屏幕xy点获取该点的坐标
		 * @param	_x
		 * @param	_y
		 * @return
		 */
		public function getLatlngByXY(_x:Number, _y:Number):LatLng
		{
			return getDisplayLayer.getLatlngByXY(_x, _y)
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
		
		/**
		 * 获取当前缩放
		 */
		public function get zoom():uint
		{
			return now_z_index
		}
		
		/**
		 * 显示新瓦片层,需要再调用一次center
		 * @param	z
		 */
		private function showDisplayLayerZoom(z:int):void
		{
			if (z >= map_setting.max_level)
			{
				z = map_setting.max_level
			}
			if (z <= map_setting.min_level)
			{
				z = 1
			}
			if (z == now_z_index)
			{
				return
			}
			removeChild(getDisplayLayer)
			now_z_index = z
			addChild(getDisplayLayer)
			getDisplayLayer.resize(maplayer_width, maplayer_height)
			getDisplayLayer.mask = sp_mask
		}
	}

}