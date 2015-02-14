package com.lizeqiangd.basemap.tile
{
	import com.lizeqiangd.basemap.config.MapSetting;
	import com.lizeqiangd.basemap.evnets.TileEvent;
	import com.lizeqiangd.basemap.interfaces.progressbar.pb_DefaultProgressBar;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.geom.Vector3D;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * 瓦片加载器
	 * 只负责加载瓦片,对外部库只引用进度条
	 * @author Lizeqiangd
	 * 20150128 移除对map_setting依赖
	 * 20150214 考虑要不要增加加载时间过长重新加载的机制,返回加载完成机制给外部侦听.@TileEvent 修复有线的问题
	 */
	public class TileLoader extends Sprite
	{
		/**  瓦片坐标 **/
		public var vector3d:Vector3D = new Vector3D
		
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
		
		private var is_load_complete:Boolean = false
		
		//配置用
		private var use_anime:Boolean = MapSetting.getInstance.Tile_Anime_enable
		private var use_progressbar:Boolean =MapSetting.getInstance.Tile_ProgressBar_enable
		private var use_information:Boolean = MapSetting.getInstance.Tile_Information_enable
		private var use_debug:Boolean = MapSetting.getInstance.Tile_Debug_enable
		
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
			this.graphics.beginFill(0x222222,0.2)
			this.graphics.drawRect(0, 0, tile_size, tile_size)
			this.graphics.endFill()
			
			if (use_debug)
			{
				this.graphics.lineStyle(1, 0xffffff)
				this.graphics.drawRect(1, 1, tile_size - 1, tile_size - 1)
				loader.alpha = 0.5
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
			tileX = _x
			tileY = _y
			tileZ = _z
			if (use_information)
			{
				tx.text = 'x:' + tileX + ' y:' + tileY + ' z:' + tileZ
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
			this.dispatchEvent(new TileEvent(TileEvent.TILE_DISPOSED))
			if (!is_load_complete)
			{
				this.dispatchEvent(new TileEvent(TileEvent.TILE_LOAD_COMPLETE))
			}
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
				tx.text = 'x:' + tileX + ' y:' + tileY + ' z:' + tileZ + 'failed'
				this.cacheAsBitmap = true
			}
			this.dispatchEvent(new TileEvent(TileEvent.TILE_LOAD_ERROR))
		}
		
		private function onLoadComplete(e:Event):void
		{
			removeUiListener()
			if (use_anime)
			{
				use_debug ? null : loader.alpha = 0
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
			is_load_complete = true
			this.dispatchEvent(new TileEvent(TileEvent.TILE_LOAD_COMPLETE))
			
			this.x=Math.floor(this.x)
			this.y=Math.floor(this.y)
		}
		
		private function onEnterFrameAnime(e:Event):void
		{
			use_debug ? null : loader.alpha += 0.2
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
				this.cacheAsBitmap = true
			}
		}
		
		private function onTileRemoved(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onTileRemoved);
			depose()
		}
		
		public function get tileX():int
		{
			return vector3d.x;
		}
		
		public function set tileX(value:int):void
		{
			vector3d.x = value;
		}
		
		public function get tileY():int
		{
			return vector3d.y;
		}
		
		public function set tileY(value:int):void
		{
			vector3d.y = value;
		}
		
		public function get tileZ():int
		{
			return vector3d.z;
		}
		
		public function set tileZ(value:int):void
		{
			vector3d.z = value;
		}
	}

}