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
	import flash.events.KeyboardEvent;
	import flash.net.URLRequest;
	import flash.ui.Keyboard;
	import flash.utils.setTimeout;
	
	/**
	 * BaseMap Demo Application
	 * 
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
			
			MapSetting.getInstance.basemap_type = 'mapbox'
			MapSetting.getInstance.mapbox_token = 'pk.eyJ1IjoibGl6ZXFpYW5nZCIsImEiOiJKSHZ6RHNZIn0.9BZ9QpTL3MmJXeR9biD9Sw'
			MapSetting.getInstance.mapbox_style = 'lizeqiangd.09aab23b'
			//MapSetting.getInstance.mapbox_style = 'mapbox.streets'
			MapSetting.getInstance.tile_outsize_count = 2
			
			MapSetting.getInstance.Tile_Information_enable = false
			MapSetting.getInstance.Tile_ProgressBar_enable = true
			MapSetting.getInstance.Tile_Anime_enable = true
			MapSetting.getInstance.Tile_Debug_enable = false
			
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
			
			//China Guangdong Shenzhen University
			bm.center(113.932663669586175, 22.534340149642382, 15);
			stage.addEventListener(Event.RESIZE, onStageResize)
			
			setTimeout(onStageResize, 100, null)
			setTimeout(function():void
				{
				}, 500)
			addChild(center_mark)			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown)
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			switch (e.keyCode)
			{
				case Keyboard.DOWN: 
					bm.getMapLayer.movement(0, 16)
					break;
				case Keyboard.RIGHT: 
					bm.getMapLayer.movement(16, 0)
					break;
				case Keyboard.LEFT: 
					bm.getMapLayer.movement(-16, 0)
					break;
				case Keyboard.UP: 
					bm.getMapLayer.movement(0, -16)
					break;
				default: 
			}
		}
		
		private function onEnterFrame(e:Event):void
		{
			//bm.getMapLayer.movement(1,1)
		}
		
		private function onStageResize(e:Event):void
		{
			//for test mask.
			bm.x = bm.y = 30
			bm.setMapSize(stage.stageWidth - 60, stage.stageHeight - 60)
			center_mark.x = stage.stageWidth / 2
			center_mark.y = stage.stageHeight / 2
		}
	
	}

}