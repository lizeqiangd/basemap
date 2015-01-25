package com.lizeqiangd.basebox.config
{
	
	/**
	 * ...
	 * @author Lizeqiangd
	 */
	public dynamic class MapSetting extends Object
	{
		private static var instant:MapSetting
		
		public static function get getInstant():MapSetting
		{
			if (instant)
			{
				return instant
			}
			instant = new MapSetting
			return getInstant;
		}
		
		public function parse():MapSetting
		{
			return this;
		}
		
		public var map_width:Number = 100
		public var map_height:Number = 100
		public var tile_size:Number = 256
		
		/**  mapbox setting **/
		public var basemap_type:String = 'mapbox'
		
		public var mapbox_style:String = 'lizeqiangd.09aab23b';
		public var mapbox_tiletype:String = Mapbox_Type_PNG256;
		public var mapbox_token:String = 'pk.eyJ1IjoibGl6ZXFpYW5nZCIsImEiOiJKSHZ6RHNZIn0.9BZ9QpTL3MmJXeR9biD9Sw'
		public const Mapbox_BaseUrl:String = 'http://api.tiles.mapbox.com/v4/'
		public const Mapbox_Type_RETINA:String = '@2x.png'
		public const Mapbox_Type_PNG32:String = 'png32'
		public const Mapbox_Type_PNG64:String = 'png64'
		public const Mapbox_Type_PNG128:String = 'png128'
		public const Mapbox_Type_PNG256:String = 'png256'
		public const Mapbox_Type_JPG70:String = 'jpg70'
		public const Mapbox_Type_JPG80:String = 'jpg80'
		public const Mapbox_Type_JPG90:String = 'jpg90'
		public const Mapbox_Tile_Size:uint = 256
	}

}