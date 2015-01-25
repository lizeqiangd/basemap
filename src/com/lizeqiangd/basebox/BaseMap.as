package com.lizeqiangd.basebox
{
	import com.lizeqiangd.basebox.config.MapSetting;
	import com.lizeqiangd.basebox.layer.MapLayer;
	import com.lizeqiangd.basebox.parser.iMapUrlParser;
	import com.lizeqiangd.basebox.parser.MapBoxParser;
	import com.lizeqiangd.basebox.tile.TileLoader;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Lizeqiangd
	 */
	public class BaseMap extends Sprite
	{
		private static var instance:BaseMap		
		public static function get getInstance():BaseMap
		{
			if (instance == null)
			{
				instance = new BaseMap();
			}
			return instance;		
		}
		
		private var map_setting:MapSetting
		private var mapParser:iMapUrlParser
		//private var mask_shape:Shape
		
		private var _mapWidth:Number = 0
		private var _mapHeight:Number = 0
		
		private var map_conroller:MapController
		private var map_layer:MapLayer
		
		public function BaseMap()
		{
			if (instance != null)
			{
				throw new Error("please use getInstance method.");
			}			
		}
		
		/**
		 * 整体设置
		 * @param	value
		 */
		public function config(value:MapSetting):void
		{
			switch (value.basemap_type)
			{
				case 'mapbox': 
					mapParser = new MapBoxParser
					//mapParser.setMapToken = value.mapbox_token
					//mapP
					break;
				default: 
			}
		
			map_layer = new MapLayer
			addChild(map_layer)
			map_conroller = new MapController
			map_conroller.addMapController()
			map_conroller.setMapLayer = map_layer
			addChild(map_conroller)
		}
		
		public function set setMapWidth(value:Number):void
		{
			_mapWidth = value
			map_conroller.resize(_mapWidth, _mapHeight)
			map_layer.resize(_mapWidth, _mapHeight)
		}
		
		public function set setMapHeight(value:Number):void
		{
			_mapHeight = value
			map_conroller.resize(_mapWidth, _mapHeight)
			map_layer.resize(_mapWidth, _mapHeight)
		}
		
		/**
		 * 初始化地图
		 */
		public function init():void
		{
			if (!mapParser)
			{
				trace('BaseMap: not setMapType.');
				return
			}			
			map_layer.center(121.13131313, 31.2323, 17);
		}
		
		//
		//public function set enableMouseWheel(value:Boolean):void
		//{
		//
		//}
		//
		//public function set enableMouseDoubleClick(value:Boolean):void
		//{
		//
		//}
		
		/**
		 * 设置中心点
		 * @param	x 纬度(x)
		 * @param	y 经度(y)
		 * @param	z
		 */
		//public function centerPoint(x:Number, y:Number, z:uint = 14):void
		//{
		//
		//}
		
		//private function mapResize():void
		//{
		//mask_shape.width = mapWidth
		//mask_shape.height = mapHeight
		//}
		
		/**
		 * 设置地图token.不同地图需要重新设置.
		 */
		//public function set setToken(token:String):void
		//{
		//mapParser.setMapToken = token
		//}
		//
		//public function get MapParser():iMapUrlParser
		//{
		//return mapParser
		//}
		
		//public function get mapHeight():Number
		//{
		//return _mapHeight;
		//}
		//
		//public function set mapHeight(value:Number):void
		//{
		//_mapHeight = value;
		//mapResize()
		//}
		//
		//public function get mapWidth():Number
		//{
		//return _mapWidth;
		//}
		//
		//public function set mapWidth(value:Number):void
		//{
		//_mapWidth = value;
		//mapResize()
		//}
		
		public function get getMapController():MapController
		{
			return map_conroller
		}
		
		public function get getMapParser():iMapUrlParser
		{
			return mapParser
		}
	}

}