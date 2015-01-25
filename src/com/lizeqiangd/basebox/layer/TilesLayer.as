package com.lizeqiangd.basebox.layer
{
	import com.lizeqiangd.basebox.BaseMap;
	import com.lizeqiangd.basebox.component.LatLng;
	import com.lizeqiangd.basebox.config.MapSetting;
	import com.lizeqiangd.basebox.parser.iMapUrlParser;
	import com.lizeqiangd.basebox.tile.TileLoader;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * 每一个高度都是一个层
	 * @author Lizeqiangd
	 */
	
	public class TilesLayer extends Sprite
	{
		private var _tileLoader:TileLoader
		private var mapParse:iMapUrlParser
		private var map_setting:MapSetting
		
		private var layer_width:Number = 100
		private var layer_height:Number = 100
		private var num_width:uint = 0
		private var num_height:uint = 0
		
		private var _z_index:uint = 0
		private var top_left:LatLng
		
		public function TilesLayer(z_index:uint = 0)
		{
			map_setting = MapSetting.getInstant
			mapParse = BaseMap.getInstance.getMapParser			
			_z_index = z_index
		}
		
		public function setDisplayZome(value:LatLng):void
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
		public function center(lng:Number , lat:Number ):void {
			
		}
		private function update():void
		{
			var tiles:TileLoader
			for (var i:int = 0; i < num_width * num_height; i++)
			{
				tiles = new TileLoader
				addChild(tiles)
				tiles.load(mapParse.getUrlByXYZ(i % num_width + 54885 + 10, Math.floor(i / num_width) + 26775 + 10, 16))
				tiles.x = map_setting.tile_size * (i % num_width)
				tiles.y = map_setting.tile_size * Math.floor(i / num_width)
				
				if (Math.floor((i + 1) / num_width) == num_height)
				{
					break;
				}
			}
		}
		
		private function getMaxIndex():uint
		{
			return Math.pow(2, _z_index)
		}
	
	}

}