package com.lizeqiangd.basemap
{
	import com.lizeqiangd.basemap.parser.iMapUrlParser;
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
		private var mapParser:iMapUrlParser
		private var tileLoaderVector:Vector.<TileLoader>
		private var mask_shape:Shape
		private var _mapWidth:Number=0
		private var _mapHeight:Number=0
		
		public function BaseMap()
		{
			mask_shape = new Shape
			mask_shape.graphics.beginFill(0)
			mask_shape.graphics.drawRect(0, 0, 10, 10)
			this.mask = mask_shape
			addChild(mask_shape)
			
			tileLoaderVector = new Vector.<TileLoader>
		}
		
		public function set setMapType(map_type:String):void
		{
			switch (map_type.toLowerCase())
			{
				case 'mapbox': 
					mapParser = new MapBoxParser
					break;
				default: 
			}
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
			//tileLoaderVector
			var tiles:TileLoader
			var num_width:Number = Math.floor(	this.mapWidth / MapBoxParser.TileSize)+1
			var num_height:Number =Math.floor(this.mapHeight/MapBoxParser.TileSize)+1
			for (var i:int = 0; i < 30;i++){
				tiles = new TileLoader
				tiles.load(mapParser.getUrlByXYZ(i%num_width+54885,Math.floor(i / num_width)+26775, 16))
				tiles.x=MapBoxParser.TileSize*(i%num_width)
				tiles.y = MapBoxParser.TileSize * Math.floor(i / num_width)
				addChild(tiles)
				if ( Math.floor((i+1) / num_width) == num_height) {
					break;
				}
			}
		}
		
		public function set enableMouseWheel(value:Boolean):void
		{
		
		}
		
		public function set enableMouseDoubleClick(value:Boolean):void
		{
		
		}
		
		/**
		 * 设置中心点
		 * @param	x 纬度(x)
		 * @param	y 经度(y)
		 * @param	z
		 */
		public function centerPoint(x:Number, y:Number, z:uint = 14):void
		{
		
		}
		
		private function mapResize():void
		{
			mask_shape.width = mapWidth
			mask_shape.height = mapHeight
		}
		
		/**
		 * 设置地图token.不同地图需要重新设置.
		 */
		public function set setToken(token:String):void
		{
			mapParser.setMapToken = token
		}
		
		public function get MapParser():iMapUrlParser
		{
			return mapParser
		}
		
		public function get mapHeight():Number
		{
			return _mapHeight;
		}
		
		public function set mapHeight(value:Number):void
		{
			_mapHeight = value;
			mapResize()
		}
		
		public function get mapWidth():Number
		{
			return _mapWidth;
		}
		
		public function set mapWidth(value:Number):void
		{
			_mapWidth = value;
			mapResize()
		}
	
	}

}