package com.lizeqiangd.basemap.evnets
{
	import flash.events.Event;
	
	/**
	 * 瓦片加载器对外事件
	 * @author Lizeqiangd
	 * @email i@acgs.me
	 */
	public class TileEvent extends Event
	{
		public static const TILE_LOAD_COMPLETE:String = 'tile_load_complete';
		public static const TILE_LOAD_ERROR:String = 'tile_load_error'
		public static const TILE_DISPOSED:String = 'tile_disposed'
		
		public static const TILELAYER_LOAD_COMPLETE:String = 'tilelayer_load_complete'
		
		public function TileEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
		public override function clone():Event
		{
			return new TileEvent(type, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("TileLoaderEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
	
	}

}