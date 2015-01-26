package com.lizeqiangd.basemap.tile
{
	import com.lizeqiangd.basemap.config.MapSetting;
	import com.lizeqiangd.basemap.interfaces.progressbar.pb_DefaultProgressBar;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * 瓦片加载器
	 * @author Lizeqiangd
	 */
	public class TileLoader extends Sprite
	{
		private var loader:Loader
		private var url:String = ''
		private var pb:pb_DefaultProgressBar
		
		private var tile_size:Number = 256
		
		public var tile_x:int = 0
		public var tile_y:int = 0
		public var tile_z:int = 0
		
		public function TileLoader()
		{
			loader = new Loader()
			loader.mouseChildren = false
			loader.mouseEnabled = false
			this.mouseChildren = false
			this.mouseEnabled = false
			this.addChild(loader)
			//this.loader.alpha = 0.5			
			//this.graphics.lineStyle(1, 0, .5)
			//this.graphics.drawRect(0, 0, 256, 256)
			tile_size = MapSetting.getInstance.tile_size
			pb = new pb_DefaultProgressBar
			addChild(pb)
		}
		
		/**
		 * load tile
		 * @param	value
		 */
		public function load(value:String):void
		{
			this.graphics.beginFill(0x22ccff)
			this.graphics.drawRect(0, 0, tile_size, tile_size)
			this.graphics.endFill()
			
			addUiListener()
			
			url = value
			pb.init()
			pb.y = -pb.height / 2 + tile_size / 2
			pb.x = -pb.width / 2 + tile_size / 2
			loader.load(new URLRequest(url), new LoaderContext(true))
		}
		
		/**
		 * 用于调试使用的测试接口.
		 * @param	e
		 */
		public function setTilePosition(_x:Number, _y:Number, _z:Number):void
		{
			tx.defaultTextFormat = new TextFormat('微软雅黑', 15, 0x22ccff)
			tx.height = 25
			tx.width = 256
			addChild(tx)
			tile_x = _x
			tile_y = _y
			tile_z = _z
		}
		
		public	var tx:TextField = new TextField
		public function setInformation(value:String):void
		{
			
			tx.text = 'x:' + tile_x + ' y:' + tile_y + ' z:' + tile_z + ' i:' + value
			this.cacheAsBitmap=true
		}
		
		/**
		 * 把自己从世界上抹除...
		 */
		public function depose():void
		{
			this.removeEventListener(Event.ENTER_FRAME, onEnterFrameAnime)
			removeUiListener()
			this.removeChildren()
			this.loader.unload()
			this.loader = null
			//this.parent.removeChild(this)
		}
		
		private function addUiListener():void
		{
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoadProgress, false, 0, true)
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete)
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoadError, false, 0, true)
			loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onLoadError, false, 0, true)
			this.addEventListener(Event.REMOVED_FROM_STAGE, onTileRemoved)
		}
		
		private function removeUiListener():void
		{
			loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onLoadProgress)
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoadComplete)
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onLoadError)
			loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onLoadError)
		}
		
		private function onLoadProgress(e:ProgressEvent):void
		{
			pb.progress = e.bytesLoaded / e.bytesTotal;
		}
		
		private function onLoadError(e:*):void
		{
			removeUiListener()
			trace('Tile:LoadError:' + url)
		}
		
		private function onLoadComplete(e:Event):void
		{
			removeUiListener()
			loader.alpha = 0
			loader.cacheAsBitmap=true
			this.addEventListener(Event.ENTER_FRAME, onEnterFrameAnime);
		}
		
		private function onEnterFrameAnime(e:Event):void
		{
			loader.alpha += 0.2
			pb.alpha -= 0.2
			pb.x = -pb.width / 2 + tile_size / 2
			pb.y = -pb.height / 2 + tile_size / 2
			pb.height -= 2
			pb.width += 2
			if (loader.alpha >= 1)
			{
				pb.depose()
				pb = null
				this.removeEventListener(Event.ENTER_FRAME, onEnterFrameAnime)
					//trace('tile load complete')
			}
		}
		
		private function onTileRemoved(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onTileRemoved);
			depose()
		}
	}

}