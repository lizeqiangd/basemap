package com.lizeqiangd.basemap.tile
{
	//import com.lizeqiangd.basemap.config.MapSetting;
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
	 * 只负责加载瓦片,对外部库只引用进度条
	 * @author Lizeqiangd
	 * 20150128 移除对map_setting依赖
	 */
	public class TileLoader extends Sprite
	{
		public var tile_x:int = 0
		public var tile_y:int = 0
		public var tile_z:int = 0
		
		/**  瓦片loader **/
		private var loader:Loader
		/** 当前url **/
		private var url:String = ''
		/** 加载进度条  **/
		private var pb:pb_DefaultProgressBar
		/** 文本框  **/
		private var tx:TextField
		/** 瓦片大小 **/
		private var tile_size:Number = 256
		
		private var use_anime:Boolean = true
		private var use_progressbar:Boolean = true
		private var use_information:Boolean = true
		
		private var use_debug:Boolean =true
		public function TileLoader(_tile_size:Number)
		{
			loader = new Loader()
			loader.mouseChildren = false
			loader.mouseEnabled = false
			this.mouseChildren = false
			this.mouseEnabled = false
			this.addChild(loader)
						
			tile_size = _tile_size
			pb = new pb_DefaultProgressBar
			if (use_progressbar)
			{
				addChild(pb)
			}
			if (use_information)
			{
				tx = new TextField
				tx.defaultTextFormat = new TextFormat('微软雅黑', 15, 0x22ccff)
				tx.height = 25
				tx.width = tile_size
				addChild(tx)
			}
		}
		
		/**
		 * load tile
		 * @param	value
		 */
		public function load(value:String):void
		{
			url = value
			this.graphics.beginFill(0x222222)
			this.graphics.drawRect(0, 0, tile_size, tile_size)
			this.graphics.endFill()			
			
			if (use_debug) {
				this.graphics.lineStyle(1, 0xffffff)
				this.graphics.drawRect(0, 0, tile_size, tile_size)
				loader.alpha=0.5
			}
			
			addUiListener()			
			if (use_progressbar)
			{
				pb.init()
				pb.y = -pb.height / 2 + tile_size / 2
				pb.x = -pb.width / 2 + tile_size / 2
			}
			if (url)
			{
				loader.load(new URLRequest(url), new LoaderContext(true))
			}
			else
			{
				onLoadError(null)
			}
		}
		
		/**
		 * 用于调试使用的测试接口.
		 * @param	e
		 */
		public function setTilePosition(_x:Number, _y:Number, _z:Number):void
		{
			tile_x = _x
			tile_y = _y
			tile_z = _z
			if (use_information)
			{
				tx.text = 'x:' + tile_x + ' y:' + tile_y + ' z:' + tile_z
				this.cacheAsBitmap = true
			}
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
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.NETWORK_ERROR, onLoadError, false, 0, true)
			loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onLoadError, false, 0, true)
			this.addEventListener(Event.REMOVED_FROM_STAGE, onTileRemoved)
		}
		
		private function removeUiListener():void
		{
			loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onLoadProgress)
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoadComplete)
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onLoadError)
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.NETWORK_ERROR, onLoadError)
			loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onLoadError)
		}
		
		private function onLoadProgress(e:ProgressEvent):void
		{
			if (use_progressbar)
			{
				pb.progress = e.bytesLoaded / e.bytesTotal;
			}
		}
		
		private function onLoadError(e:*):void
		{
			removeUiListener()
			trace('Tile:LoadError:' + url)
			if (use_information)
			{
				tx.text = 'x:' + tile_x + ' y:' + tile_y + ' z:' + tile_z + 'failed'
				this.cacheAsBitmap = true
			}
		}
		
		private function onLoadComplete(e:Event):void
		{
			removeUiListener()
			if (use_anime)
			{
				use_debug?null:loader.alpha =0
				this.addEventListener(Event.ENTER_FRAME, onEnterFrameAnime);
			}
			else
			{
				loader.cacheAsBitmap = true
				if (use_progressbar)
				{
					pb.depose()
					pb = null
				}
			}
		}
		
		private function onEnterFrameAnime(e:Event):void
		{
		use_debug?null:	loader.alpha += 0.2
			if (use_progressbar)
			{
				pb.alpha -= 0.2
				pb.x = -pb.width / 2 + tile_size / 2
				pb.y = -pb.height / 2 + tile_size / 2
				pb.height -= 2
				pb.width += 2
			}
			if (loader.alpha >= 1)
			{
				if (use_progressbar)
				{
					pb.depose()
					pb = null
				}
				this.removeEventListener(Event.ENTER_FRAME, onEnterFrameAnime)
				loader.cacheAsBitmap = true
			}
		}
		
		private function onTileRemoved(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onTileRemoved);
			depose()
		}
	}

}