package com.lizeqiangd.basemap.parser 
{
	/**
	 * ...
	 * @author Lizeqiangd
	 */
	public class BaseMapParser 
	{
		/** 设置地图token **/
		protected var map_token:String = '';
		private var map_prefix:String = '';
		
		public function BaseMapParser(prefix:String ) 
		{
			map_prefix=prefix
		}
		
		/**
		 * 返回地图前缀地址
		 */
		protected function get getMapPrefix():String {
			return map_prefix;
		}
		
	}

}