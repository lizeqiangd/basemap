package com.lizeqiangd.basebox.layer
{
	import flash.display.Shape;
	import flash.display.Sprite;
	
	/**
	 * 所有层都在本层上显示
	 * @author Lizeqiangd
	 */
	public class MapLayer extends Sprite
	{
		private var arrTilesLayer:Vector.<TilesLayer>
		private var sp_mask:Shape
		
		private var now_z_index:uint = 0
		
		public function MapLayer()
		{
			this.mouseChildren = false
			this.mouseEnabled = false
			arrTilesLayer = new Vector.<TilesLayer>
			sp_mask = new Shape
			sp_mask.graphics.beginFill(0, 0)
			sp_mask.graphics.drawRect(0, 0, 10, 10)
			sp_mask.graphics.endFill()
			
			for (var i:uint = 0; i < 24; i++)
			{
				var tileslayer:TilesLayer = new TilesLayer(i)
				arrTilesLayer[i] = tileslayer
			}
		}
		
		public function init():void
		{
		
		}
		
		public function resize(w:Number, h:Number):void
		{
			sp_mask.width = w
			sp_mask.height = h
			getDisplayLayer.resize(w, h)
		}
		
		public function movement(delta_x:Number, detal_y:Number):void
		{
			getDisplayLayer.x = delta_x
			getDisplayLayer.y = detal_y
		}
		
		public function center(lng:Number, lat:Number, z:uint):void
		{
			now_z_index = z
			getDisplayLayer.center(lng, lat)
			addChild(getDisplayLayer)
		}
		
		public function get getDisplayLayer():TilesLayer
		{
			return arrTilesLayer[now_z_index]
		}
		
		public function showLayer(z:uint):void
		{
		
		}
	}

}