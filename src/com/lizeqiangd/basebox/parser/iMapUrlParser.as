package com.lizeqiangd.basebox.parser {
	import com.lizeqiangd.basebox.component.LatLng;
	import com.lizeqiangd.basebox.component.StartTile;	
	/**
	 * ...
	 * @author Lizeqiangd
	 */
	public interface iMapUrlParser 
	{
		function getUrlByXYZ(_x:Number, _y:Number, _z:Number):String
		function getStartTileByLatlng(latlng:LatLng):StartTile
	}
	
}