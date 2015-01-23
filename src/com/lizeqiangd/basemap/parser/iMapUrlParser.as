package com.lizeqiangd.basemap.parser 
{
	
	/**
	 * ...
	 * @author Lizeqiangd
	 */
	public interface iMapUrlParser 
	{
		function getUrlByXYZ(_x:Number, _y:Number, _z:Number):String
		function set setMapToken(token:String ):void
	}
	
}