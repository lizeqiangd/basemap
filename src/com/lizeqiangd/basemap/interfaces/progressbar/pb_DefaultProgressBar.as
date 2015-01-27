package com.lizeqiangd.basemap.interfaces.progressbar
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * Defualt ProgressBar
	 * 20150125
	 * @author Lizeqiangd
	 */
	public class pb_DefaultProgressBar extends BaseProgressBar
	{
		private var tx_title:TextField
		
		public function pb_DefaultProgressBar()
		{
			tx_title = new TextField
			tx_title.defaultTextFormat = new TextFormat('微软雅黑', 15, 0xff9900)
			tx_title.height = 25
			tx_title.text = '加载中,请稍后.'
			tx_title.y = -20
			tx_title.width = tx_title.textWidth + 10
			tx_title.x = this.width / 2 //- tx_title.textWidth / 2
			addChild(tx_title)
			//tx.width = 256
		}
	}

}