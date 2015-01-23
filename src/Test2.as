package
{
	
	/**
	 * ...
	 * @author Lizeqiangd
	 */
	public class Test2
	{
		
		public function Test2()
		{
			trace(tile(121.4962263,31.2398498,17))
		}
		
		public function tile(lng:Number, lat:Number, zoom:Number):Object 
		{
			lat = lat / 180 * Math.PI
			var n:uint = Math.pow(2, zoom)
			var xtile :Number 
			xtile= int(Math.floor((lng + 180.0) / 360.0 * n))
			var ytile :Number
			//ytile= int(Math.floor((1.0 - Math.log(Math.tan(lat) + (1.0 / Math.cos(lat))) / Math.PI) / 2.0 * n))
			return {x:xtile, y:ytile,z: zoom}
		}
	}

}