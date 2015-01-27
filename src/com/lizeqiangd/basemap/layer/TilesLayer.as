package com.lizeqiangd.basemap.layer
{
	import com.lizeqiangd.basemap.BaseMap;
	import com.lizeqiangd.basemap.component.LatLng;
	import com.lizeqiangd.basemap.config.MapSetting;
	import com.lizeqiangd.basemap.parser.iMapParser;
	import com.lizeqiangd.basemap.tile.TileLoader;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * 每一个高度都是一个层
	 * @author Lizeqiangd
	 */
	
	public class TilesLayer extends Sprite
	{
		private var _tileLoader:TileLoader
		private var map_parse:iMapParser
		private var map_setting:MapSetting
		
		private var layer_width:Number = 100
		private var layer_height:Number = 100
		private var num_width:uint = 0
		private var num_height:uint = 0
		
		private var _z_index:int = 0
		private var top_left:LatLng
		private var tile_array:Object
		
		private var bound_up:int = -1
		private var bound_bottom:int = -1
		private var bound_left:int = -1
		private var bound_right:int = -1
		
		public function TilesLayer(z_index:uint = 0)
		{
			map_setting = MapSetting.getInstance
			map_parse = BaseMap.getInstance.getMapParser
			_z_index = z_index
		}
		
		public function setDisplayZoom(value:LatLng):void
		{
		
		}
		
		public function resize(w:Number, h:Number):void
		{
			layer_width = w
			layer_height = h
			
			num_width = Math.floor(this.layer_width / map_setting.tile_size) + 1
			num_height = Math.floor(this.layer_height / map_setting.tile_size) + 1
			
			update()
		}
		
		public function movement(deltaX:Number, deltaY:Number):void
		{
			var outsize:int = map_setting.tile_outsize_count * map_setting.tile_size
			var tiles:TileLoader
			var temp_tile:TileLoader
			var numChildrends:uint = this.numChildren
			var i:int = 0
			var t:String;
			var num_creates:uint = 0
			//移动算法
			for (var child_index:int = 0; child_index < numChildrends; child_index++)
			{
				temp_tile = getChildAt(child_index) as TileLoader
				temp_tile.x += deltaX
				temp_tile.y += deltaY
				//temp_tile.setInformation(i + '')
			}
			
			//消失和增加算法.
			//for (child_index = 0; child_index < numChildrends; child_index++)
			//{
			//if (child_index < 0)
			//{
			//child_index = 0
			//}
			//
			//}
			//向上移动
			if (deltaY < 0)
			{
				if (tile_array[bound_right][bound_bottom].y < (layer_height - map_setting.tile_size))
				{
					num_creates = Math.abs(bound_left - bound_right)
					for (i = 0; i <= num_creates; i++)
					{
						temp_tile = new TileLoader
						temp_tile.load(map_parse.getUrlByXYZ(bound_left + i, bound_bottom + 1, _z_index))
						temp_tile.setTilePosition(bound_left + i, bound_bottom + 1, _z_index)
						if (!tile_array[bound_left + i])
						{
							tile_array[bound_left + i] = {}
						}
						tile_array[bound_left + i][bound_bottom + 1] = temp_tile
						temp_tile.x = tile_array[bound_left + i][bound_bottom].x
						temp_tile.y = tile_array[bound_left][bound_bottom].y + map_setting.tile_size
						addChild(temp_tile)
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
			
			//向左移动
			if (deltaX < 0)
			{
				if (tile_array[bound_left][bound_up].x<  (layer_width - map_setting.tile_size))
				{
					num_creates = Math.abs(bound_bottom - bound_up)
					for (i = 0; i <= num_creates; i++)
					{
						temp_tile = new TileLoader
						temp_tile.load(map_parse.getUrlByXYZ(bound_right + 1, bound_up + i, _z_index))
						temp_tile.setTilePosition(bound_right + 1, bound_up + i, _z_index)
						if (!tile_array[bound_right + 1])
						{
							tile_array[bound_right + 1] = {}
						}
						tile_array[bound_right + 1][bound_up + i] = temp_tile
						temp_tile.x = tile_array[bound_right][bound_up].x + map_setting.tile_size
						temp_tile.y = tile_array[bound_left][bound_up + i].y
						addChild(temp_tile)
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
			
			//向下移动
			if (deltaY > 0)
			{
				if (tile_array[bound_left][bound_up].y > 0)
				{
					num_creates = Math.abs(bound_left - bound_right)
					for (i = 0; i <= num_creates; i++)
					{
						temp_tile = new TileLoader
						temp_tile.load(map_parse.getUrlByXYZ(bound_left + i, bound_up - 1, _z_index))
						temp_tile.setTilePosition(bound_left + i, bound_up - 1, _z_index)
						if (!tile_array[bound_left + i])
						{
							tile_array[bound_left + i] = {}
						}
						tile_array[bound_left + i][bound_up - 1] = temp_tile
						temp_tile.x = tile_array[bound_left + i][bound_up].x
						temp_tile.y = tile_array[bound_left][bound_up].y - map_setting.tile_size
						addChild(temp_tile)
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
			
			//向右移动
			if (deltaX > 0)
			{
				if (tile_array[bound_left][bound_up].x > 0)
				{
					num_creates = Math.abs(bound_bottom - bound_up)
					for (i = 0; i <= num_creates; i++)
					{
						temp_tile = new TileLoader
						temp_tile.load(map_parse.getUrlByXYZ(bound_left - 1, bound_up + i, _z_index))
						temp_tile.setTilePosition(bound_left - 1, bound_up + i, _z_index)
						if (!tile_array[bound_left - 1])
						{
							tile_array[bound_left - 1] = {}
						}
						tile_array[bound_left - 1][bound_up + i] = temp_tile
						temp_tile.x = tile_array[bound_left][bound_up].x - map_setting.tile_size
						temp_tile.y = tile_array[bound_left][bound_up + i].y
						addChild(temp_tile)
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
		
			//添加新的瓦片
			//tiles = new TileLoader
		
			//}
		}
		
		public function center(lng:Number, lat:Number):void
		{
		
		}
		
		private function update():void
		{
			clear()
			map_parse.setZ(_z_index)
			var centerTileX:int = map_parse.getTileXByLng(121.5068837) - num_width / 2
			var centerTileY:int = map_parse.getTileYByLat(31.2362685) - num_height / 2
			//trace(map_parse.getTileYByLat(31.2362685))
			var tiles:TileLoader
			
			bound_up = centerTileY
			bound_bottom = centerTileY + num_height - 1
			bound_left = centerTileX
			bound_right = centerTileX + num_width - 1
			
			for (var i:int = 0; i < num_height; i++)
			{
				//tile_array[centerTileX] = {}
				for (var k:int = 0; k < num_width; k++)
				{
					tiles = new TileLoader
					addChild(tiles)
					tiles.load(map_parse.getUrlByXYZ(centerTileX + k, i + centerTileY, _z_index))
					tiles.x = map_setting.tile_size * k
					tiles.y = map_setting.tile_size * i
					tiles.setTilePosition(k + centerTileX, centerTileY + i, _z_index)
					if (!tile_array[k + centerTileX])
					{
						tile_array[k + centerTileX] = {}
					}
					tile_array[k + centerTileX][centerTileY + i] = tiles
				}
			}
			//movement(-600, -600)
		}
		
		private function clear():void
		{
			this.removeChildren()
			tile_array = {}
		
			//for (var i:int = 0; i < this.numChildren; i++)
			//{
			////(this.getChildAt(0) as TileLoader).depose()
			//}
		}
		
		private function getMaxIndex():uint
		{
			return Math.pow(2, _z_index)
		}
	}
}