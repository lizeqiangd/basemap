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
			latitude = _lat
			longitude = _lng
			adjustDegree()
		}
		
		public function set x(value:Number):void
		{
			longitude = value
			adjustDegree()
		}
		
		public function get x():Number
		{
			return longitude
		}
		
		public function set y(value:Number):void
		{
			latitude = value
			adjustDegree()
		}
		
		public function get y():Number
		{
			return latitude
		}
		
		public function set lng(value:Number):void
		{
			longitude = value
			adjustDegree()
		}
		
		public function get lng():Number
		{
			return longitude
		}
		
		public function set lat(value:Number):void
		{
			latitude = value
			adjustDegree()
		}
		
		public function get lat():Number
		{
			return latitude
		}
		
		public function toString():String
		{
			return 'longitude:' + lng + ' latitude:' + lat
		}
		
		private function adjustDegree():void
		{
			latitude = latitude % 180
			longitude = longitude % 360
		}
	}

}