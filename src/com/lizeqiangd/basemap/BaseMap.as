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
	 * 理论上适用于各种瓦片地图的sdk
	 * 使用方法.使用getInstance获取本例的单例.(推荐,否则你就自己修改代码去)
	 * var bm:BaseMap=BaseMap.getInstance
	 * bm.config(MapSetting.getInstance)
	 * 这里你可以设置下地图参数.需要地图类型和appkey
	 * bm.init()
	 * 地图就算启动完成了..
	 * addChild(bm)
	 *
	 * @author Lizeqiangd
	 * 20150127 基本构架完成
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
		 * 初始化地图
		 */
		public function init():void
		{
			map_setting = MapSetting.getInstance
			switch (map_setting.basemap_type)
			{
				case 'mapbox': 
					//当是mapbox的时候
					map_parser = new MapBoxParser
					map_setting.tile_size = map_setting.Mapbox_Tile_Size
					map_setting.max_level = map_setting.Mapbox_Max_Level
					break;
				default: 
			}
			
			map_layer = new MapLayer
			map_conroller = new MapController
			map_conroller.addMapController()
			map_conroller.setMapLayer = map_layer
			addChild(map_layer)
			addChild(map_conroller)
		}
		
		/**
		 * 设置最新的中心点.
		 * @param	lng
		 * @param	lat
		 * @param	zoom
		 */
		public function center(lng:Number, lat:Number, zoom:uint):void
		{
			map_layer.center(lng, lat, zoom);
		}
		
		/**
		 * 同时设置宽度和高度属性.
		 * (会立刻更新内部)
		 * @param	w
		 * @param	h
		 */
		public function setMapSize(w:Number, h:Number):void
		{
			_mapWidth = w
			_mapHeight = h
			map_conroller.resize(_mapWidth, _mapHeight)
			map_layer.resize(_mapWidth, _mapHeight)
		}
		
		/**
		 * 设置地图宽度属性
		 * (会立刻更新内部)
		 */
		public function set setMapWidth(value:Number):void
		{
			_mapWidth = value
			map_conroller.resize(_mapWidth, _mapHeight)
			map_layer.resize(_mapWidth, _mapHeight)
		}
		
		/**
		 * 设置地图高度属性
		 * (会立刻更新内部)
		 */
		public function set setMapHeight(value:Number):void
		{
			_mapHeight = value
			map_conroller.resize(_mapWidth, _mapHeight)
			map_layer.resize(_mapWidth, _mapHeight)
		}
		
		/**
		 * 获取地图控制器
		 */
		public function get getMapController():MapController
		{
			return map_conroller
		}
		
		/**
		 * 获取当前地图解析器
		 */
		public function get getMapParser():iMapParser
		{
			return map_parser
		}
		
		/**
		 * 获取地图本体层.
		 */
		public function get getMapLayer():MapLayer
		{
			return map_layer
		}
	}

}