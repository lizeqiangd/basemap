package
{
	import com.lizeqiangd.basemap.BaseMap;
	import com.lizeqiangd.basemap.config.MapSetting;
	import com.lizeqiangd.basemap.parser.MapBoxParser;
	import flash.display.Loader;
	import flash.display.Shape;
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
		private var center_mark:Shape
		
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
			
			center_mark = new Shape
			center_mark.graphics.lineStyle(1, 0x22ccff)
			center_mark.graphics.moveTo(-15, 0)
			center_mark.graphics.lineTo(15, 0)
			center_mark.graphics.moveTo(0, -15)
			center_mark.graphics.lineTo(0, 15)
			
			bm = BaseMap.getInstance
			bm.init();
			addChild(bm)
			onStageResize(null)
			bm.center(0, 0, 2);
			
			stage.addEventListener(Event.RESIZE, onStageResize)
			
			setTimeout(onStageResize, 100, null)
			setTimeout(function():void
				{
					stage.addEventListener(Event.ENTER_FRAME, onEnterFrame)
				}, 500)
			
			addChild(center_mark)
		}
		
		private function onEnterFrame(e:Event):void
		{
			//bm.getMapLayer.movement(1,1)
		}
		
		private function onStageResize(e:Event):void
		{
			bm.x = bm.y = 30
			bm.setMapSize(stage.stageWidth - 60, stage.stageHeight - 60)
			//bm.g
			center_mark.x = stage.stageWidth  / 2
			center_mark.y = stage.stageHeight/ 2
		}
	
	}

}