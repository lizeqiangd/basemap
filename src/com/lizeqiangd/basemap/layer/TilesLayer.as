package com.lizeqiangd.basemap.layer
{
	import com.lizeqiangd.basemap.BaseMap;
	import com.lizeqiangd.basemap.component.LatLng;
	import com.lizeqiangd.basemap.component.StartTile;
	import com.lizeqiangd.basemap.config.MapSetting;
	import com.lizeqiangd.basemap.evnets.TileEvent;
	import com.lizeqiangd.basemap.parser.iMapParser;
	import com.lizeqiangd.basemap.tile.TileLoader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * 每一个高度都是一个层
	 * 包含瓦片移动算法,增加移除算法.
	 * @author Lizeqiangd
	 * 20150128 对tileloader赋瓦片大小.复用代码优化流程.删除
	 * 20150209 重新建立计算鼠标点位置函数.之前的想复杂了
	 * 20150214 对所有TileLoader添加加载侦听.修复逻辑错误导致庞大的错误加载
	 */
	
	public class TilesLayer extends Sprite
	{
		/**  核心工具 **/
		private var _tileLoader:TileLoader
		private var map_parse:iMapParser
		private var map_setting:MapSetting
		
		/** 本TilesLayer变量 **/
		private var layer_width:Number = 100
		private var layer_height:Number = 100
		private var _z_index:int = 0
		private var top_left:LatLng
		private var num_width:uint = 0
		private var num_height:uint = 0
		private var startTile:StartTile
		private var total_movement_x:int = 0
		private var total_movement_y:int = 0
		
		/** 计算变量 **/
		private var bound_up:int = -1
		private var bound_bottom:int = -1
		private var bound_left:int = -1
		private var bound_right:int = -1
		private var tile_array:Object
		
		//目前加载完成的数量
		private var now_completed_count:uint = 0
		//总共需要加载的数量
		private var total_need_count:uint = 0
		
		public function TilesLayer(z_index:uint = 0)
		{
			map_setting = MapSetting.getInstance
			map_parse = BaseMap.getInstance.getMapParser
			_z_index = z_index
			this.addEventListener(Event.ADDED_TO_STAGE, onAddToStage)
		}
		
		private function onRemoveFromStage(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			this.addEventListener(Event.ADDED_TO_STAGE, onAddToStage)
			clear()
			_tileLoader = null
		}
		
		private function onAddToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage)
			map_setting = MapSetting.getInstance
		}
		
		/**
		 * 移动地图,会计算移动以及瓦块本体.
		 * @param	deltaX
		 * @param	deltaY
		 */
		public function movement(deltaX:Number, deltaY:Number):void
		{
			if (deltaX > map_setting.tile_size)
			{
				movement(map_setting.tile_size, 0)
				return movement(deltaX - map_setting.tile_size, deltaY)
			}
			if (deltaY > map_setting.tile_size)
			{
				movement(0, map_setting.tile_size)
				return movement(deltaX, deltaY - map_setting.tile_size)
			}
			
			var outsize:int = map_setting.tile_outsize_count * map_setting.tile_size
			var numChildrends:uint = this.numChildren
			if (!numChildrends)
			{
				return
			}
			
			var i:int = 0
			var t:String;
			var num_creates:uint = 0
			
			total_movement_x += deltaX
			total_movement_y += deltaY
			
			//移动算法
			for (var child_index:int = 0; child_index < numChildrends; child_index++)
			{
				_tileLoader = getChildAt(child_index) as TileLoader
				_tileLoader.x += deltaX
				_tileLoader.y += deltaY
			}
			
			//向上移动
			if (deltaY < 0)
			{
				if (tile_array[bound_right][bound_bottom].y < (layer_height - map_setting.tile_size))
				{
					num_creates = Math.abs(bound_left - bound_right)
					for (i = 0; i <= num_creates; i++)
					{
						createTiles(bound_left + i, bound_bottom + 1, _z_index)
						_tileLoader.x = tile_array[bound_left + i][bound_bottom].x
						_tileLoader.y = tile_array[bound_left][bound_bottom].y + map_setting.tile_size
						addChild(_tileLoader)
					}
					bound_bottom++
				}
				if (tile_array[bound_left][bound_up].y < -outsize)
				{
					for (i = bound_left; i <= bound_right; i++)
					{
						removeChild(tile_array[i][bound_up] as TileLoader)
						child_index--
						delete tile_array[i][bound_up]
					}
					bound_up++
				}
			}
			//向下移动
			if (deltaY > 0)
			{
				if (tile_array[bound_left][bound_up].y > 0)
				{
					num_creates = Math.abs(bound_left - bound_right)
					for (i = 0; i <= num_creates; i++)
					{
						createTiles(bound_left + i, bound_up - 1, _z_index)
						_tileLoader.x = tile_array[bound_left + i][bound_up].x
						_tileLoader.y = tile_array[bound_left][bound_up].y - map_setting.tile_size
						addChild(_tileLoader)
					}
					bound_up--
				}
				
				if ((tile_array[bound_right][bound_bottom].y + map_setting.tile_size) > (outsize + layer_height))
				{
					for (i = bound_left; i <= bound_right; i++)
					{
						removeChild(tile_array[i][bound_bottom] as TileLoader)
						child_index--
						delete tile_array[i][bound_bottom]
					}
					bound_bottom--
				}
				
			}
			
			//向左移动
			if (deltaX < 0)
			{
				if (tile_array[bound_right][bound_bottom].x < (layer_width - map_setting.tile_size))
				{
					num_creates = Math.abs(bound_bottom - bound_up)
					for (i = 0; i <= num_creates; i++)
					{
						createTiles(bound_right + 1, bound_up + i, _z_index)
						_tileLoader.x = tile_array[bound_right][bound_up].x + map_setting.tile_size
						_tileLoader.y = tile_array[bound_left][bound_up + i].y
						addChild(_tileLoader)
					}
					bound_right++
				}
				
				if (tile_array[bound_left][bound_up].x < -outsize)
				{
					for (t in tile_array[bound_left])
					{
						removeChild(tile_array[bound_left][t])
						child_index--
					}
					delete tile_array[bound_left]
					bound_left++
				}
			}
			
			//向右移动
			if (deltaX > 0)
			{
				if (tile_array[bound_left][bound_up].x > 0)
				{
					num_creates = Math.abs(bound_bottom - bound_up)
					for (i = 0; i <= num_creates; i++)
					{
						createTiles(bound_left - 1, bound_up + i, _z_index)
						_tileLoader.x = tile_array[bound_left][bound_up].x - map_setting.tile_size
						_tileLoader.y = tile_array[bound_left][bound_up + i].y
						addChild(_tileLoader)
					}
					bound_left--
				}
				
				if ((tile_array[bound_right][bound_bottom].x + map_setting.tile_size) > (outsize + layer_width))
				{
					for (t in tile_array[bound_right])
					{
						removeChild(tile_array[bound_right][t])
						child_index--
					}
					delete tile_array[bound_right]
					bound_right--
				}
				
			}
		}
		
		/**
		 * 制作中心点.
		 * @param	lng
		 * @param	lat
		 */
		public function center(lng:Number, lat:Number):void
		{
			map_parse.setZ(_z_index)
			var ll:LatLng = new LatLng(lat, lng)
			startTile = map_parse.getStartTileByLatlng(ll)
			startTile.offsetX += layer_width / 2
			startTile.offsetY += layer_height / 2
			update()
			//movement(layer_width / 2 + startTile.offsetX, layer_height / 2 + startTile.offsetY)
		}
		
		/**
		 * 根据屏幕xy点获取该点的坐标
		 * 该算法是差不多算法.很烂.
		 * @param	_x
		 * @param	_y
		 * @return
		 */
		public function getLatlngByXY(_x:Number, _y:Number):LatLng
		{
			var ll:LatLng = new LatLng()
			var delta_tileY:Number = (_y - total_movement_y) / map_setting.Mapbox_Tile_Size
			var down_tile_lat:Number = map_parse.getLatByTileY(Math.floor((_y - total_movement_y) / map_setting.Mapbox_Tile_Size) + startTile.tileY + 1)
			var up_tile_lat:Number = map_parse.getLatByTileY(Math.floor((_y - total_movement_y) / map_setting.Mapbox_Tile_Size) + startTile.tileY)
			var delta_tile_lat:Number = up_tile_lat - down_tile_lat
			ll.lng = startTile.lng + 360 * ((_x + startTile.offsetX - layer_width / 2 - total_movement_x) / map_setting.Mapbox_Tile_Size) / Math.pow(2, _z_index)
			ll.lat = up_tile_lat - (delta_tileY + Math.pow(2, _z_index)) % 1 * delta_tile_lat
			//trace(ll)
			return ll
		}
		
		/**
		 * 重新绘制尺寸
		 * @param	w
		 * @param	h
		 */
		public function resize(w:Number, h:Number):void
		{
			layer_width = w
			layer_height = h
			
			num_width = Math.floor(this.layer_width / map_setting.tile_size) + 1
			num_height = Math.floor(this.layer_height / map_setting.tile_size) + 1
			if (startTile)
			{
				
			}
			update()
		}
		
		/**
		 * 更新全局画面.
		 */
		private function update():void
		{
			if (!startTile)
			{
				return
			}
			clear()
			map_parse.setZ(_z_index)
			var centerTileX:int = startTile.tileX
			var centerTileY:int = startTile.tileY
			bound_up = centerTileY
			bound_bottom = centerTileY + num_height - 1
			bound_left = centerTileX
			bound_right = centerTileX + num_width - 1
			
			for (var i:int = 0; i < num_height; i++)
			{
				for (var k:int = 0; k < num_width; k++)
				{
					createTiles(centerTileX + k, i + centerTileY)
					_tileLoader.x = map_setting.tile_size * k
					_tileLoader.y = map_setting.tile_size * i
				}
			}
			movement(startTile.offsetX, startTile.offsetY)
		}
		
		/**
		 * 自动覆盖本地的_tileLoader.方便其他操作.
		 * @param	tileX 需要显示的X
		 * @param	tileY 需要显示的Y
		 * @param	tileZ 需要显示的Z 为0的时候则获取本地的_z_index
		 * @return
		 */
		private function createTiles(tileX:int, tileY:int, tileZ:uint = 0):TileLoader
		{
			tileZ == 0 ? tileZ = _z_index : null
			_tileLoader = new TileLoader(map_setting.tile_size)
			_tileLoader.setTilePosition(tileX, tileY, tileZ)
			if (!tile_array[tileX])
			{
				tile_array[tileX] = {}
			}
			tile_array[tileX][tileY] = _tileLoader
			addChild(_tileLoader)
			addTileEventListener(_tileLoader)
			total_need_count++
			_tileLoader.load(map_parse.getUrlByXYZ(tileX, tileY, tileZ))
			return _tileLoader
		}
				
		/**
		 * 添加对瓦块加载的侦听,这样可以让全部加载完成的时候抛出事件.
		 * @param	tl
		 */
		private function addTileEventListener(tl:TileLoader):void
		{
			tl.addEventListener(TileEvent.TILE_LOAD_COMPLETE, onSingleTileLoadCompleted, false, 0, true)
			tl.addEventListener(TileEvent.TILE_LOAD_ERROR, onSingleTileLoadCompleted, false, 0, true)
		}
		
		private function onSingleTileLoadCompleted(e:TileEvent):void
		{
			now_completed_count++
			//trace('TilesLayer:[' + _z_index + ']' + now_completed_count + '/' + total_need_count)
			if (now_completed_count >= total_need_count)
			{
				now_completed_count = total_need_count = 0
				this.dispatchEvent(new TileEvent(TileEvent.TILELAYER_LOAD_COMPLETE))
			}
		}
		
		/**
		 * 清理全屏
		 */
		private function clear():void
		{
			total_movement_x = 0
			total_movement_y = 0
			this.removeChildren()
			tile_array = {}
		}
	}
}