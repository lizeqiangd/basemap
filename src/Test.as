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
			bm = BaseMap.getInstance
			bm.config(MapSetting.getInstance)
			//bm.setToken = 'pk.eyJ1IjoibGl6ZXFpYW5nZCIsImEiOiJKSHZ6RHNZIn0.9BZ9QpTL3MmJXeR9biD9Sw'
			//onStageResize(null)
			bm.init();
			addChild(bm)
			//trace(Math.floor((1.0 - Math.log(Math.tan(31.2398498 / 180 * Math.PI) + (1.0 / Math.cos(31.2398498 / 180 * Math.PI))) / Math.PI) / 2.0 * 17))
			//removeEventListener(Event.ADDED_TO_STAGE, init);
			//var im:Loader = new Loader
			//var p:MapBoxParser = new MapBoxParser
			//p.setMapToken = 'pk.eyJ1IjoibGl6ZXFpYW5nZCIsImEiOiJKSHZ6RHNZIn0.9BZ9QpTL3MmJXeR9biD9Sw'
			//trace(p.getUrlByXZY(0, 0, 0))
			//im.load(new URLRequest(p.getUrlByXZY(0, 0, 0)))
			//addChild(im)		
			stage.addEventListener(Event.RESIZE, onStageResize)
			setTimeout(onStageResize,100,null)
			//setTimeout(bm.getMapLayer.movement,300,-513,-513)
		}
		
		private function onStageResize(e:Event):void
		{
			bm.setMapSize(stage.stageWidth, stage.stageHeight)
			//bm.setMapHeight=stage.stageHeight
			//bm.setMapWidth=stage.stageWidth
		}
	
	}

}