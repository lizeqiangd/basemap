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
		
		private var _z_index:uint = 17
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
			
			for (var child_index:int = 0; child_index < this.numChildren; child_index++)
			{
				if (child_index < 0)
				{
					child_index = 0
				}
				temp_tile = getChildAt(child_index) as TileLoader
				temp_tile.x += deltaX
				temp_tile.y += deltaY
				temp_tile.setInformation(i + '')
				var i:int = 0
				var t:String
				//向上移动
				if (deltaY < 0 && tile_array[bound_left][bound_up].y < -outsize)
				{
					for (i = bound_left; i < bound_right; i++)
					{
						removeChild(tile_array[i][bound_up] as TileLoader)
						child_index--
						delete tile_array[i][bound_up]
					}
					bound_up++
				}
					//
					////向左移动
					//if (deltaX < 0 && tile_array[bound_left][bound_up].x < -outsize)
					//{
					//for (t in tile_array[bound_left])
					//{
					//removeChild(tile_array[bound_left][t])
					//child_index--
					//}
					//delete tile_array[bound_left]
					//bound_left++
					//}
					//
					////向下移动
					//if (deltaY > 0 && tile_array[bound_right][bound_bottom].y > outsize)
					//{
					//for (i = bound_left; i < bound_right; i++)
					//{
					//removeChild(tile_array[i][bound_bottom] as TileLoader)
					//child_index--
					//delete tile_array[i][bound_bottom]
					//}
					//bound_bottom--
					//}
					//
					////向右移动
					//if (deltaX > 0 && tile_array[bound_right][bound_bottom].x > outsize)
					//{
					//for (t in tile_array[bound_right])
					//{
					//removeChild(tile_array[bound_right][t])
					//child_index--
					//}
					//delete tile_array[bound_right]
					//bound_right--
					//}
				
					//if (deltaY > 0 && tile_array[bound_right][bound_bottom].y > outsize)
					//{
					//for (var tl:TileLoader in tile_array[bound_up])
					//{
					//removeChild(tl)
					//}
					//delete tile_array[up_bound]
					//}
					//
					//if (deltaX > 0 && tile_array[bound_right][bound_bottom].x > outsize)
					//{
					//for (var tl:TileLoader in tile_array[up_bound])
					//{
					//removeChild(tl)
					//}
					//delete tile_array[up_bound]
					//}
				
					//if (temp_tile.x > (this.layer_width + outsize) || temp_tile.x < -outsize || temp_tile.y < -outsize || temp_tile.y > (this.layer_height + outsize))
					//{
					//if (this.numChildren > 1)
					//{
					//removeChild(temp_tile)
					//delete tile_array[temp_tile.tile_x][temp_tile.tile_y]
					//var bol:Boolean = false;
					//for (var key:Object in tile_array[temp_tile.tile_x])
					//{
					//bol = true;
					//}
					//if (!bol)
					//{
					//delete tile_array[temp_tile.tile_x]
					//}
					//i--
					//}
					//}
					//
					//if (bound_right > 0 || !tile_array[temp_tile.tile_x + 1])
					//{
					//bound_right = temp_tile.tile_x
					//temp_tile.setInformation('→')
					//}
					//
					//if (this.layer_width > (temp_tile.x + map_setting.tile_size) && this.layer_width < (this.x + temp_tile.x + map_setting.tile_size * 2))
					//{
					////trace(this.x + temp_tile.x + map_setting.tile_size)
					////tiles = new TileLoader
					////addChild(tiles)
					////tiles.load(map_parse.getUrlByXYZ(temp_tile.tile_x + 1, temp_tile.tile_y, temp_tile.tile_z))
					////tiles.x = temp_tile.x + map_setting.tile_size
					////tiles.y = temp_tile.y
					////tiles.setTilePosition(temp_tile.tile_x + 1, temp_tile.tile_y, temp_tile.tile_z)
					//}
				
			}
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