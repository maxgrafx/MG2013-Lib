package net.mg2013.display.color
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import net.mg2013.vo.HSV;

	public class HSVDisplay extends Sprite
	{
		//////////////
		////////////// CONSTRUCTOR ------------------------------------------------------------------------------------------- CONSTRUCTOR //////////////////////
		//////////////
		private var __hsv:HSV;

		private var __bitmap:Bitmap;

		private var __width:int;

		private var __height:int;

		public function HSVDisplay(hsv:HSV, width:int, height:int)
		{
			super();
			__hsv = hsv;
			__width = width;
			__height = height;
			initDisplay();
		}

		protected function initDisplay():void
		{
			var bmd:BitmapData = new BitmapData(width, height, false, __hsv.toHex());
			__bitmap = new Bitmap(bmd, PixelSnapping.AUTO, true);
			addChild(__bitmap);
		}

		//////////////
		////////////// PUBLIC ------------------------------------------------------------------------------------------------ PUBLIC ///////////////////////////
		//////////////
		//////////////
		////////////// OVERRIDE PUBLIC --------------------------------------------------------------------------------------- OVERRIDE PUBLIC //////////////////
		//////////////
		//////////////
		////////////// PROTECTED --------------------------------------------------------------------------------------------- PROTECTED ////////////////////////
		//////////////
		protected function changeSize():void
		{
			var bmd:BitmapData = new BitmapData(width, height, false, __hsv.toHex());
			__bitmap.bitmapData.dispose();
			__bitmap.bitmapData = bmd;
		}

		//////////////
		////////////// OVERRIDE PROTECTED ------------------------------------------------------------------------------------ OVERRIDE PROTECTED ///////////////
		//////////////
		//////////////
		////////////// MOUSE EVENTS ------------------------------------------------------------------------------------------ MOUSE EVENTS /////////////////////
		//////////////
		//////////////
		////////////// OVERRIDE MOUSE EVENTS --------------------------------------------------------------------------------- OVERRIDE MOUSE EVENTS ////////////
		//////////////
		//////////////
		////////////// EVENTS ------------------------------------------------------------------------------------------------ EVENTS ///////////////////////////
		//////////////
		//////////////
		////////////// OVERRIDE EVENTS --------------------------------------------------------------------------------------- OVERRIDE EVENTS //////////////////
		//////////////
		//////////////
		////////////// GET & SET --------------------------------------------------------------------------------------------- GET & SET ////////////////////////
		//////////////
		public function get hsv():HSV
		{
			return __hsv;
		}

		public function set hsv(value:HSV):void
		{
			__hsv = value;
			__bitmap.bitmapData.lock();
			__bitmap.bitmapData.fillRect(__bitmap.bitmapData.rect, __hsv.toHex());
			__bitmap.bitmapData.unlock();
		}

		//////////////
		////////////// OVERRIDE GET & SET ------------------------------------------------------------------------------------ OVERRIDE GET & SET ///////////////
		//////////////
		override public function get height():Number
		{
			return __height;
		}

		override public function set height(value:Number):void
		{
			__height = value;
			changeSize();
		}

		override public function get width():Number
		{
			return __width;
		}

		override public function set width(value:Number):void
		{
			__width = value;
			changeSize();
		}
	}
}
