package com.lizeqiangd.basemap.parser
{
	import com.lizeqiangd.basemap.component.LatLng;
	import com.lizeqiangd.basemap.component.StartTile;
	
	/**
	 * ...
	 * @author Lizeqiangd
	 */
	public interface iMapParser
	{
		/**
		 * 根据瓦片xyz获取瓦片图片地址
		 * @param	_x
		 * @param	_y
		 * @param	_z
		 * @return
		 */
		function getUrlByXYZ(_x:int, _y:int, _z:int):String
		/**
		 * 根据latlng获取瓦片图片地址
		 * @param	latlng
		 * @return
		 */
		function getUrlByLatlng(latlng:LatLng):String
		/**
		 * 根据latlng获取起始瓦片地址
		 * @param	latlng
		 * @return
		 */
		function getStartTileByLatlng(latlng:LatLng):StartTile
		/**
		 * 设置当前Z-Index
		 * @param	z
		 * @return
		 */
		function setZ(z:uint):uint
		/**
		 * 根据 经度获取瓦块X坐标
		 * @param	lng
		 * @return
		 */
		function getTileXByLng(lng:Number):int
		/**
		 * 根据 纬度获取瓦块Y坐标
		 * @param	lat
		 * @return
		 */
		function getTileYByLat(lat:Number):int
		/**
		 * 根据瓦块X获取经度
		 * @param	tileX
		 * @return
		 */
		function getLngByTileX(tileX:Number):Number
		/**
		 * 根据瓦块Y获取纬度
		 * @param	tileY
		 * @return
		 */
		function getLatByTileY(tileY:Number):Number
		/**
		 * 根据像素数获取经度数值
		 * @param	px
		 * @return
		 */
		function getLngDegreeByPixel(px:int):Number
		/**
		 * 根据像素数获取纬度数值
		 * @param	px
		 * @return
		 */
		function getLatDegreeByPixel(px:int):Number
	
	}

}