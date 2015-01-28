package com.lizeqiangd.basemap.component
{
	
	/**
	 * 用于测距用的偏移瓦片数据
	 * @author Lizeqiangd
	 */
	public class StartTile
	{
		public var offsetX:Number
		public var offsetY:Number
		
		public var tileX:int
		public var tileY:int
		
		public var lat:Number 
		public var lng:Number 
		public function toString():String
		{
			var outputString:String  = 'StartTile: ';
			outputString += 'offestX:' + offsetX.toFixed(3)
			outputString += ' offsetY:' + offsetY.toFixed(3)
			outputString += ' tileX:' + tileX
			outputString += ' tileY:' + tileY
			outputString += ' lat:' + lat
			outputString += ' lng:' + lng
		return outputString
		}
	}

}