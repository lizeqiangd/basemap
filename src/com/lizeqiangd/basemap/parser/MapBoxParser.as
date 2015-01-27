package com.lizeqiangd.basemap.parser
{
	import com.lizeqiangd.basemap.component.LatLng;
	import com.lizeqiangd.basemap.component.StartTile;
	import com.lizeqiangd.basemap.config.MapSetting;
	
	/**
	 * Mapbox地图解析器
	 * 20150121
	 * @author Lizeqiangd
	 */
	public class MapBoxParser extends BaseMapParser implements iMapParser
	{
		public var now_z:uint = 0
		
		private var bound_up:Number = 90
		private var bound_down:Number = -90
		private var bound_left:Number = -180
		private var bound_right:Number = 180
		
		private var map_setting:MapSetting = MapSetting.getInstance
		
		public function MapBoxParser()
		{
			//super(MapBoxParser.Mapbox_BaseUrl);		
		}
		
		public function getUrlByXYZ(_x:int, _y:int, _z:int):String
		{
			var x:uint = _x
			var y:uint = _y
			var z:uint = _z
			var returnUrl:String = map_setting.Mapbox_BaseUrl + map_setting.mapbox_style + '/' + z + '/' + x + '/' + y + '.' + map_setting.mapbox_tiletype + '?access_token=' + map_setting.mapbox_token
			return returnUrl
		}
		
		public function getUrlByLatlng(latlng:LatLng):String
		{
			var x:uint = getTileXByLng(latlng.lng)
			var y:uint = getTileYByLat(latlng.lat)
			var z:uint = now_z
			var returnUrl:String = map_setting.Mapbox_BaseUrl + map_setting.mapbox_style + '/' + z + '/' + x + '/' + y + '.' + map_setting.mapbox_tiletype + '?access_token=' + map_setting.mapbox_token
			return returnUrl
		}
		
		public function getStartTileByLatlng(latlng:LatLng):StartTile
		{
			var st:StartTile = new StartTile
			st.tileX = getTileXByLng(latlng.lng)
			st.tileY = getTileYByLat(latlng.lat)
			var n:int = Math.pow(2, now_z)
			var lon_deg:Number = st.tileX / n * 360.0 - 180.0
			var lat_deg:Number = Math.atan(Math.sin(Math.PI * (1 - 2 * st.tileY / n))) / Math.PI * 180
			st.offsetX = (lon_deg - latlng.lng) * 360 / (MapSetting.getInstance.Mapbox_Tile_Size * n)
			st.offsetY = (lat_deg - latlng.lat) * 360 / (MapSetting.getInstance.Mapbox_Tile_Size * n)
			return st
		}
		
		/**
		 * 设置当前Z-Index
		 * @param	z
		 * @return
		 */
		public function setZ(z:uint):uint
		{
			return this.now_z = z
		}
		
		public function getTileXByLng(lng:Number):int
		{
			return int(Math.floor((lng + 180.0) / 360.0 * Math.pow(2, now_z)))
		}
		
		public function getTileYByLat(lat:Number):int
		{
			return int(Math.floor((1.0 - Math.log(Math.tan(lat / 180 * Math.PI) + (1.0 / Math.cos(lat / 180 * Math.PI))) / Math.PI) / 2.0 * Math.pow(2, now_z)))
		}
	}

}