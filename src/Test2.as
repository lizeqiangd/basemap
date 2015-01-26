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
			o = tile(121.4962263, 31.2398498, 17)
			//trace('**************', o.x, o.y, o.z)
			var tile_array:Object = {}
			for (var i:int = 9999; i <9999+4; i++)
			{
				tile_array[String (i)] = {}
				for (var k:int = 5000; k < 5000+4; k++)
				{
					tile_array[String (i)][String (k)] = i + ':' + k + " "
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