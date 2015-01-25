package com.lizeqiangd.basebox.parser
{
	import com.lizeqiangd.basebox.component.LatLng;
	import com.lizeqiangd.basebox.component.StartTile;
	import com.lizeqiangd.basebox.config.MapSetting;
	
	/**
	 * Mapbox地图解析器
	 * 20150121
	 * @author Lizeqiangd
	 */
	public class MapBoxParser extends BaseMapParser implements iMapUrlParser
	{
		public var now_z:uint = 0
		
		private var bound_up:Number = 90
		private var bound_down:Number = -90
		private var bound_left:Number = -180
		private var bound_right:Number = 180
		
		private var map_setting:MapSetting = MapSetting.getInstant
		
		public function MapBoxParser()
		{
			//super(MapBoxParser.Mapbox_BaseUrl);		
		}
		
		public function getUrlByXYZ(_x:Number, _y:Number, _z:Number):String
		{
			var x:uint = _x
			var y:uint = _y
			var z:uint = _z
			var returnUrl:String = map_setting.Mapbox_BaseUrl + map_setting.mapbox_style + '/' + z + '/' + x + '/' + y + '.' + map_setting.mapbox_tiletype + '?access_token=' + map_setting.mapbox_token
			return returnUrl
		}
		
		public function getStartTileByLatlng(latlng:LatLng):StartTile
		{
			var st:StartTile = new StartTile
			st.tileX = getTilexByLng(latlng.lng)
			st.tileY = getTileyByLat(latlng.lat)
			st.offsetX
			st.offsetY
			return st
		}
		
		private function getTilexByLng(lng:Number):Number
		{
			return int(Math.floor((lng + 180.0) / 360.0 * now_z))
		}
		
		private function getTileyByLat(lat:Number):int
		{
			return int(Math.floor((1.0 - Math.log(Math.tan(lat) + (1.0 / Math.cos(lat))) / Math.PI) / 2.0 * now_z))
		}
	}

}