package com.lizeqiangd.basemap.component
{
	
	/**
	 * 经纬度
	 * latitude==lat==y
	 * longitude=lng=x
	 * @author Lizeqiangd
	 */
	public class LatLng
	{
		public var latitude:Number = 0
		public var longitude:Number = 0
		
		public function LatLng(_lat:Number = 0, _lng:Number = 0)
		{
			latitude = lat
			longitude = lng
		}
		
		public function set x(value:Number):void
		{
			longitude = value
		}
		
		public function get x():Number
		{
			return longitude
		}
		
		public function set y(value:Number):void
		{
			latitude = value
		}
		
		public function get y():Number
		{
			return latitude
		}
		
		public function set lng(value:Number):void
		{
			longitude = value
		}
		
		public function get lng():Number
		{
			return longitude
		}
		
		public function set lat(value:Number):void
		{
			latitude = value
		}
		
		public function get lat():Number
		{
			return latitude
		}
		
		public function toString():String
		{
			return 'longitude:' + lng + ' latitude:' + lat
		}
	}

}