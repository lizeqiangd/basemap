package
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Lizeqiangd
	 */
	public class Test2 extends Sprite
	{
		
		public var o:Object
		
		public function Test2()
		{
			
			var px:int = 128
			var x:Number = ((1 - px / 256 * 2 / Math.pow(2, 1)) * Math.PI)
			trace(x)
			trace((-Math.atan((Math.exp(x) - Math.exp(-x)) * 0.5) + Math.atan((Math.exp(Math.PI) - Math.exp(-Math.PI)) * 0.5)) / Math.PI * 180)
			
			$xtile = floor((($lon + 180) / 360) * pow(2, $zoom));
			$ytile = floor((1 - log(tan(deg2rad($lat)) + 1 / cos(deg2rad($lat))) / pi()) / 2 * pow(2, $zoom));
			
			$n = pow(2, $zoom);
			$lon_deg = $xtile / $n * 360.0 - 180.0;
			$lat_deg = rad2deg(atan(sinh(pi() * (1 - 2 * $ytile / $n))));
			
			return;
			o = tile(121.4962263, 31.2398498, 17)
			//trace('**************', o.x, o.y, o.z)
			var tile_array:Object = {}
			for (var i:int = 9999; i < 9999 + 4; i++)
			{
				tile_array[String(i)] = {}
				for (var k:int = 5000; k < 5000 + 4; k++)
				{
					tile_array[String(i)][String(k)] = i + ':' + k + " "
				}
			}
			delete tile_array[9999][5001]
			traceObject(tile_array)
			//trace(tile_array)
		}
		
		private function traceObject(e:Object):void
		{
			for (var i:Object in e)
			{
				trace("MainKey:" + i);
				trace(i + ":" + e[i]);
				for (var k:Object in e[i])
				{
					trace(k + ":" + e[i][k]);
				}
			}
		}
		
		public function tile(lng:Number, lat:Number, zoom:Number):Object
		{
			lat = lat / 180 * Math.PI
			var n:uint = Math.pow(2, zoom)
			var xtile:Number = int(Math.floor((lng + 180.0) / 360.0 * n))
			var ytile:Number = int(Math.floor((1.0 - Math.log(Math.tan(lat) + (1.0 / Math.cos(lat))) / Math.PI) / 2.0 * n))
			return {x: xtile, y: ytile, z: zoom}
		}
	}

}