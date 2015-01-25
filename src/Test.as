package
{
	import com.lizeqiangd.basebox.BaseMap;
	import com.lizeqiangd.basebox.BaseMap;
	import com.lizeqiangd.basebox.config.MapSetting;
	import com.lizeqiangd.basebox.parser.MapBoxParser;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	/**
	 * BaseMap
	 * 2015.01.21
	 * @author Lizeqiangd
	 */
	public class Test extends Sprite
	{
		
		public function Test():void
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private	var bm:BaseMap=BaseMap.getInstance
		private function init(e:Event = null):void
		{
			trace('************************************')
			stage.scaleMode = StageScaleMode.NO_SCALE
			stage.align = StageAlign.TOP_LEFT
			//bm.setMapType = 'mapbox'
			bm.config(new MapSetting)
			//bm.setToken = 'pk.eyJ1IjoibGl6ZXFpYW5nZCIsImEiOiJKSHZ6RHNZIn0.9BZ9QpTL3MmJXeR9biD9Sw'
			onStageResize(null)
			bm.init ();
			addChild(bm)
			//removeEventListener(Event.ADDED_TO_STAGE, init);
			//var im:Loader = new Loader
			//var p:MapBoxParser = new MapBoxParser
			//p.setMapToken = 'pk.eyJ1IjoibGl6ZXFpYW5nZCIsImEiOiJKSHZ6RHNZIn0.9BZ9QpTL3MmJXeR9biD9Sw'
			//trace(p.getUrlByXZY(0, 0, 0))
			//im.load(new URLRequest(p.getUrlByXZY(0, 0, 0)))
			//addChild(im)		
			stage.addEventListener(Event.RESIZE,onStageResize)
		}
		
		private function onStageResize(e:Event):void 
		{
			bm.setMapHeight=stage.stageHeight
			bm.setMapWidth=stage.stageWidth
		}
		
	
	}

}