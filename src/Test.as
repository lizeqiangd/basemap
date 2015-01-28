package
{
	import com.lizeqiangd.basemap.BaseMap;
	import com.lizeqiangd.basemap.config.MapSetting;
	import com.lizeqiangd.basemap.parser.MapBoxParser;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.utils.setTimeout;
	
	/**
	 * BaseMap
	 * 2015.01.21
	 * @author Lizeqiangd
	 */
	public class Test extends Sprite
	{
		
		private var bm:BaseMap
		
		public function Test():void
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			trace('************************************')
			stage.scaleMode = StageScaleMode.NO_SCALE
			stage.align = StageAlign.TOP_LEFT
			
			MapSetting.getInstance.mapbox_token = 'pk.eyJ1IjoibGl6ZXFpYW5nZCIsImEiOiJKSHZ6RHNZIn0.9BZ9QpTL3MmJXeR9biD9Sw'
			MapSetting.getInstance.tile_outsize_count = 2
			MapSetting.getInstance.basemap_type = 'mapbox'
			MapSetting.getInstance.mapbox_style = 'lizeqiangd.09aab23b'
			
			bm = BaseMap.getInstance
			bm.init();
			addChild(bm)
			
			
			bm.center(120, 30, 17);
			
			stage.addEventListener(Event.RESIZE, onStageResize)
			
			setTimeout(onStageResize, 100, null)
			setTimeout(function():void
				{
					stage.addEventListener(Event.ENTER_FRAME, onEnterFrame)
				}, 500)
		}
		
		private function onEnterFrame(e:Event):void
		{
			//bm.getMapLayer.movement(1,1)
		}
		
		private function onStageResize(e:Event):void
		{
			bm.setMapSize(stage.stageWidth, stage.stageHeight)
			//bm.setMapHeight=stage.stageHeight
			//bm.setMapWidth=stage.stageWidth
		}
	
	}

}