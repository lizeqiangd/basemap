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
					//addChild(tileslayer)
			}
		}
		
		public function init():void
		{
		
		}
		
		public function resize(w:Number, h:Number):void
		{
			maplayer_width = w
			maplayer_height = h
			sp_mask.width = maplayer_width
			sp_mask.height = maplayer_height
			getDisplayLayer.resize(maplayer_width, maplayer_height)
			//getDisplayLayer.scaleX = ge9tDisplayLayer.scaleY = 1
		}
		
		public function movement(delta_x:Number, detal_y:Number):void
		{
			getDisplayLayer.movement(delta_x, detal_y)
			//getDisplayLayer.x = delta_x
			//getDisplayLayer.y = detal_y
		}
		
		public function scale(scale_step:Number):void
		{
			//now_z_level += scale_step
			//var temp_scale:Number = (now_z_index * 100 - now_z_level) / 100 + 1
			//getDisplayLayer.scaleX = getDisplayLayer.scaleY = temp_scale
			////放大一级
			//if ((now_z_index * 100 - now_z_level) > 50)
			//{
			//removeChild(getDisplayLayer)
			//now_z_index++
			//getDisplayLayer.center(121.13131313, 31.2323)
			//getDisplayLayer.resize(maplayer_width, maplayer_height)
			//addChild(getDisplayLayer)
			//now_z_level=now_z_index * 100
			//}
			////缩小一级
			//if ((now_z_index * 100 - now_z_level) < -50)
			//{
			//removeChild(getDisplayLayer)
			//now_z_index--
			//getDisplayLayer.center(121.13131313, 31.2323)
			//getDisplayLayer.resize(maplayer_width, maplayer_height)
			//addChild(getDisplayLayer)
			//now_z_level=now_z_index * 100
			//}
			//trace(temp_scale)
			
			if (scale_step > 0)
			{
				if (now_z_index >= map_setting.max_level)
				{
					now_z_index = map_setting.max_level
					return
				}
				removeChild(getDisplayLayer)
				now_z_index++;
			}
			if (scale_step < 0)
			{
				if (now_z_index == 0)
				{
					now_z_index = 0
					return
				}
				removeChild(getDisplayLayer)
				now_z_index--;
			}
			getDisplayLayer.center(121.13131313, 31.2323)
			getDisplayLayer.resize(maplayer_width, maplayer_height)
			addChild(getDisplayLayer)
		
		}
		
		public function center(lng:Number, lat:Number, z:uint):void
		{
			now_z_index = z
			getDisplayLayer.center(lng, lat)
			addChild(getDisplayLayer)
		}
		
		public function get getDisplayLayer():TilesLayer
		{
			return arrTilesLayer[now_z_index]
		}
		
		public function showLayer(z:uint):void
		{
		
		}
	}

}