package com.lizeqiangd.basemap.parser {
	import com.lizeqiangd.basemap.component.LatLng;
	import com.lizeqiangd.basemap.component.StartTile;	
	/**
	 * ...
	 * @author Lizeqiangd
	 */
	public interface iMapParser 
	{
		function getUrlByXYZ(_x:int, _y:int, _z:int):String
		function getUrlByLatlng(latlng:LatLng):String 
		function getStartTileByLatlng(latlng:LatLng):StartTile
		function setZ(z:uint):uint
		function getTileXByLng(lng:Number ):int 
		function getTileYByLat(lat:Number ):int 
	}
	
}