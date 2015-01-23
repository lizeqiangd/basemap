package com.lizeqiangd.basemap.tile
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	/**
	 * ...
	 * @author Lizeqiangd
	 */
	public class TileLoader extends Sprite
	{
		private var loader:Loader
		private var url:String = ''
		
		public function TileLoader()
		{
			loader = new Loader()
			loader.mouseChildren = false
			loader.mouseEnabled = false
			this.mouseChildren = false
			this.mouseEnabled = false
			
			this.loader.alpha=0.5
			this.graphics.lineStyle(1,0,.5)
			this.graphics.drawRect(0,0,256,256)
		}
		
		private function addUiListener():void
		{
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoadProgress, false, 0, true)
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete)
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoadError, false, 0, true)
			loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onLoadError, false, 0, true)
		}
		
		private function removeUiListener():void
		{
			loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onLoadProgress)
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoadComplete)
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,onLoadError)
			loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,onLoadError)
		}
		
		private function onLoadProgress(e:ProgressEvent):void
		{
			//trace(e)
		}
		
		private function onLoadError(e:*):void
		{
			removeUiListener()
			//trace('Tile:LoadError:' + url)
		}
		
		private function onLoadComplete(e:Event):void
		{
			removeUiListener()
			this.addChild(loader)
			//trace('Tile:onLoadComplete')
		}
		
		public function load(value:String):void
		{
			addUiListener()
			url = value
			trace('Tile:load')
			loader.load(new URLRequest(url), new LoaderContext(true))
			
		}
	}

}