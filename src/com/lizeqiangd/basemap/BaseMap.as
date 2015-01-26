package com.lizeqiangd.basemap
{
	import com.lizeqiangd.basemap.config.MapSetting;
	import com.lizeqiangd.basemap.layer.MapLayer;
	import com.lizeqiangd.basemap.parser.iMapParser;
	import com.lizeqiangd.basemap.parser.MapBoxParser;
	import com.lizeqiangd.basemap.tile.TileLoader;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Lizeqiangd
	 */
	public class BaseMap extends Sprite
	{
		/**  单例模式 **/
		private static var instance:BaseMap
		
		public static function get getInstance():BaseMap
		{
			if (instance == null)
			{
				instance = new BaseMap();
			}
			return instance;
		}
		
		//private var mask_shape:Shape
		
		private var _mapWidth:Number = 0
		private var _mapHeight:Number = 0
		
		/**   地图核心单例 **/
		private var map_conroller:MapController
		private var map_layer:MapLayer
		private var map_setting:MapSetting
		private var map_parser:iMapParser
		
		public function BaseMap()
		{
			if (instance != null)
			{
				throw new Error("please use getInstance method.");
			}
		}
		
		/**
		 * 整体设置 设置后全局直接开始初始化. 之后可能考虑其他方式.
		 * @param	value
		 */
		public function config(value:MapSetting):void
		{
			switch (value.basemap_type)
			{
				case 'mapbox': 
					map_parser = new MapBoxParser
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
		
		/**
		 * 初始化地图
		 */
		public function init():void
		{
			if (!map_parser)
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
		public function setMapSize(w:Number, h:Number):void
		{
			_mapWidth = w
			_mapHeight = h
			map_conroller.resize(_mapWidth, _mapHeight)
			map_layer.resize(_mapWidth, _mapHeight)
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
		
		public function get getMapController():MapController
		{
			return map_conroller
		}
		
		public function get getMapParser():iMapParser
		{
			return map_parser
		}
		
		public function get getMapLayer():MapLayer
		{
			return map_layer
		}
	}

}