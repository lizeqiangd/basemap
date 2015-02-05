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
		
		/**
		 * 根据瓦片xyz获取瓦片图片地址
		 * @param	_x
		 * @param	_y
		 * @param	_z
		 * @return
		 */
		public function getUrlByXYZ(_x:int, _y:int, _z:int):String
		{
			var x:uint = _x
			var y:uint = _y
			var z:uint = _z
			var returnUrl:String = map_setting.Mapbox_BaseUrl + map_setting.mapbox_style + '/' + z + '/' + x + '/' + y + '.' + map_setting.mapbox_tiletype + '?access_token=' + map_setting.mapbox_token
			return returnUrl
		}
		/**
		 * 根据latlng获取瓦片图片地址
		 * @param	latlng
		 * @return
		 */
		public function getUrlByLatlng(latlng:LatLng):String
		{
			var x:uint = getTileXByLng(latlng.lng)
			var y:uint = getTileYByLat(latlng.lat)
			var z:uint = now_z
			var returnUrl:String = map_setting.Mapbox_BaseUrl + map_setting.mapbox_style + '/' + z + '/' + x + '/' + y + '.' + map_setting.mapbox_tiletype + '?access_token=' + map_setting.mapbox_token
			return returnUrl
		}
		/**
		 * 根据latlng获取起始瓦片地址
		 * @param	latlng
		 * @return
		 */
		public function getStartTileByLatlng(latlng:LatLng):StartTile
		{
			var st:StartTile = new StartTile
			st.lat = latlng.lat
			st.lng = latlng.lng
			var n:int = Math.pow(2, now_z)
			st.tileX = getTileXByLng(latlng.lng)
			st.tileY = getTileYByLat(latlng.lat)
			var lon_deg:Number = getLngByTileX(st.tileX) // / n * 360.0 - 180.0
			var lat_deg:Number = getLatByTileY(st.tileY) //Math.atan(Math.sin(Math.PI * (1 - 2 * st.tileY / n))) / Math.PI * 180
			var tile_size:Number = MapSetting.getInstance.Mapbox_Tile_Size
			st.offsetX = (lon_deg - st.lng) * (tile_size * n) / 360
			st.offsetY = -(lat_deg - st.lat) * (tile_size * n) / 170.1022
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
		
		/**
		 * 根据 经度获取瓦块X坐标
		 * @param	lng
		 * @return
		 */
		public function getTileXByLng(lng:Number):int
		{
			return Math.floor((lng + 180.0) / 360.0 * Math.pow(2, now_z))
		}
		
		/**
		 * 根据 纬度获取瓦块Y坐标
		 * @param	lat
		 * @return
		 */
		public function getTileYByLat(lat:Number):int
		{
			return Math.floor((1.0 - Math.log(Math.tan(lat / 180 * Math.PI) + (1.0 / Math.cos(lat / 180 * Math.PI))) / Math.PI) / 2.0 * Math.pow(2, now_z))
		}
		
		/**
		 * 根据瓦块X获取经度
		 * @param	tileX
		 * @return
		 */
		public function getLngByTileX(tileX:Number):Number
		{
			return (tileX / Math.pow(2, now_z) * 360 - 180);
		}
		
		/**
		 * 根据瓦块Y获取纬度
		 * @param	tileY
		 * @return
		 */
		public function getLatByTileY(tileY:Number):Number
		{
			var x:Number = ((1 - tileY * 2 / Math.pow(2, now_z)) * Math.PI)
			return Math.atan((Math.exp(x) - Math.exp(-x)) * 0.5) / Math.PI * 180
		}
		
		/**
		 * 根据像素数获取经度数值
		 * 不可用
		 * @param	px
		 * @return
		 */
		public function getLngDegreeByPixel(px:int):Number
		{
			return 0//360*(px / map_setting.Mapbox_Tile_Size) / Math.pow(2, now_z)
		}
		
		/**
		 * 根据像素数获取纬度数值
		 * 不可用
		 * @param	px
		 * @return
		 */
		public function getLatDegreeByPixel(px:int):Number
		{
			var x:Number = ((1 - px / map_setting.Mapbox_Tile_Size * 2 / Math.pow(2, now_z)) * Math.PI)
			return 0//(-Math.atan((Math.exp(x) - Math.exp(-x)) * 0.5) + Math.atan((Math.exp( Math.PI) - Math.exp(- Math.PI)) * 0.5)) / Math.PI * 180 
		}
	}

}