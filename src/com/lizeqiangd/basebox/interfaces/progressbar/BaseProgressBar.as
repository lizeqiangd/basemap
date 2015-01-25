package com.lizeqiangd.basebox.interfaces.progressbar {
	import flash.display.Shape;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Lizeqiangd
	 */
	public class BaseProgressBar extends Sprite
	{
		private static const ProgressBarHeight:Number = 10
		private static const ProgressBarWidth:Number = 200
		
		private var frame:Shape
		private var bar:Shape
		private var _auto_depose:Boolean = false
		
		public function BaseProgressBar(autoDepose:Boolean = true):void
		{
			_auto_depose = autoDepose
			bar = new Shape;
			frame = new Shape;
			addChild(frame)
			addChild(bar)
		}
		
		public function init():void
		{
			drawBar()
			drawFrame()
		}
		
		/**
		 * progressbar
		 * 0-1
		 */
		public function set progress(value:Number):void
		{
			value > 1 ? value = 1 : value < 0 ? value = 0 : null
			bar.width = value * ProgressBarWidth
			if (_auto_depose && value == 1)
			{
				//depose()
			}
		}
		
		public function drawBar():void
		{
			bar.graphics.clear()
			bar.graphics.beginFill(0xff9900, 1)
			bar.graphics.drawRect(0, 0, 1, ProgressBarHeight)
			bar.graphics.endFill()
		}
		
		public function drawFrame():void
		{
			frame.graphics.clear()
			frame.graphics.lineStyle(0.5, 0xff9900)
			frame.graphics.drawRect(0, 0, ProgressBarWidth, ProgressBarHeight)
		}
		
		public function depose():void
		{
			removeChild(frame)
			removeChild(bar)
			frame.graphics.clear()
			bar.graphics.clear()
			frame = null
			bar = null
			this.parent.removeChild(this)
		}
	
	}

}