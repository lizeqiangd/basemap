package com.lizeqiangd.basemap.parser
{	
	/**
	 * Mapbox地图解析器
	 * 20150121
	 * @author Lizeqiangd
	 */
	public class MapBoxParser extends BaseMapParser implements iMapUrlParser
	{
		private static const Mapbox_BaseUrl :String = 'http://api.tiles.mapbox.com/v4/'		
		public static const Mapbox_Type_RETINA:String = '@2x.png'
		public static const Mapbox_Type_PNG32:String = 'png32'
		public static const Mapbox_Type_PNG64:String = 'png64'
		public static const Mapbox_Type_PNG128:String = 'png128'
		public static const Mapbox_Type_PNG256:String = 'png256'
		public static const Mapbox_Type_JPG70:String = 'jpg70'
		public static const Mapbox_Type_JPG80:String = 'jpg80'
		public static const Mapbox_Type_JPG90:String = 'jpg90'
		public static const TileSize:uint=256
				
		public static var map_style:String = 'lizeqiangd.09aab23b';
		public var mapbox_maptype:String = MapBoxParser.Mapbox_Type_PNG256;		
		public var now_z:uint = 0
		
		private var bound_up:Number = 90
		private var bound_down:Number = -90
		private var bound_left:Number = -180
		private var bound_right:Number = 180
		
		
		public function MapBoxParser()
		{
			super(MapBoxParser.Mapbox_BaseUrl);
		
		}
		public function getTilexByLng(lng:Number ):Number {
			return 0
		}
		public function getTileyByLat(lat:Number ):Number {
			return 0
		}
		public function getUrlByXYZ(_x:Number, _y:Number, _z:Number):String
		{
			var x:uint = _x
			var y:uint = _y
			var z:uint = _z			
			var returnUrl:String = getMapPrefix + map_style + '/' + z + '/' + x + '/' + y + '.' + mapbox_maptype + '?access_token=' + map_token
			return returnUrl
		}
		/**
		 * 设置地图token
		 */
		public function set setMapToken(token:String ):void {
			map_token=token
		}
		/**
		 * 设置mapbox地图样式
		 * @param	style_name
		 */
		public function setMapStyle(style_name:String):void
		{
			map_style = style_name;
		}
	}

}