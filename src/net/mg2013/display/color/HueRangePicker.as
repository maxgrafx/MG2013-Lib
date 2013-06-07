package net.mg2013.display.color
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import net.mg2013.utils.MGColorChart;
	import net.mg2013.vo.HSV;

	[Event(name = "change", type = "flash.events.Event")]
	public class HueRangePicker extends Sprite
	{
		//////////////
		////////////// CONSTRUCTOR ------------------------------------------------------------------------------------------- CONSTRUCTOR //////////////////////
		//////////////
		private var __bitmap:Bitmap;

		private var __color:uint = 0;

		private var __hsv:HSV = new HSV(0, 0, 0);

		private var __pixels:Vector.<uint>;

		private var __direction:String;

		private var __indicator:Shape;

		public function HueRangePicker(width:int, height:int, direction:String = MGColorChart.VERTICAL)
		{
			super();
			__direction = direction;
			__pixels = MGColorChart.fullHueRange(width, height, direction);
			buttonMode = true;
			tabChildren = tabEnabled = mouseChildren = false;
			initBitmap(__pixels, width, height);
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDownEvent, false, 0, true);
			scrollRect = new Rectangle(0, 0, width, height);
			initIndicator();
		}

		//////////////
		////////////// PUBLIC ------------------------------------------------------------------------------------------------ PUBLIC ///////////////////////////
		//////////////
		public function updatePixels(pixels:Vector.<uint>):void
		{
			__pixels = pixels;
			__bitmap.bitmapData.lock();
			__bitmap.bitmapData.setVector(new Rectangle(0, 0, width, height), pixels);
			__bitmap.bitmapData.unlock();
		}

		//////////////
		////////////// OVERRIDE PUBLIC --------------------------------------------------------------------------------------- OVERRIDE PUBLIC //////////////////
		//////////////
		//////////////
		////////////// PROTECTED --------------------------------------------------------------------------------------------- PROTECTED ////////////////////////
		//////////////
		protected function initIndicator():void
		{
			__indicator = new Shape();
			__indicator.graphics.lineStyle(1, 0xFFFFFF, 1, false);
			__indicator.graphics.drawRect(0, 0, __direction == MGColorChart.VERTICAL ? __bitmap.bitmapData.width + 2 : 6, __direction == MGColorChart.VERTICAL ? 6 : __bitmap.bitmapData.height + 2);
			addChild(__indicator);
			if (__direction == MGColorChart.VERTICAL)
			{
				__indicator.x = -1;
				__indicator.y = (__hsv.hue / 360) * __bitmap.bitmapData.height;
			}
			else
			{
				__indicator.x = (__hsv.hue / 360) * __bitmap.bitmapData.width;
				__indicator.y = -1;
			}
		}

		protected function initBitmap(pixels:Vector.<uint>, width:int, height:int):void
		{
			var bmd:BitmapData = new BitmapData(width, height, false, 0xFF000000);
			bmd.lock();
			bmd.setVector(new Rectangle(0, 0, width, height), pixels);
			bmd.unlock();
			__bitmap = new Bitmap(bmd, PixelSnapping.AUTO, true);
			addChild(__bitmap);
		}

		//////////////
		////////////// OVERRIDE PROTECTED ------------------------------------------------------------------------------------ OVERRIDE PROTECTED ///////////////
		//////////////
		//////////////
		////////////// MOUSE EVENTS ------------------------------------------------------------------------------------------ MOUSE EVENTS /////////////////////
		//////////////
		protected function mouseDownEvent(event:MouseEvent):void
		{
			addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveEvent, false, 0, true);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpEvent, false, 0, true);
			mouseMoveEvent(null);
		}

		protected function mouseUpEvent(event:MouseEvent):void
		{
			removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveEvent);
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpEvent);
		}

		protected function mouseMoveEvent(event:MouseEvent):void
		{
			__hsv.hue = (mouseY / height) * 360;
			if (__direction == MGColorChart.VERTICAL)
				__indicator.y = (__hsv.hue / 360) * __bitmap.bitmapData.height;
			else
				__indicator.x = (__hsv.hue / 360) * __bitmap.bitmapData.width;
			dispatchEvent(new Event(Event.CHANGE));
		}

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
			if (__direction == MGColorChart.VERTICAL)
				__indicator.y = (__hsv.hue / 360) * __bitmap.bitmapData.height;
			else
				__indicator.x = (__hsv.hue / 360) * __bitmap.bitmapData.width;
		}
		//////////////
		////////////// OVERRIDE GET & SET ------------------------------------------------------------------------------------ OVERRIDE GET & SET ///////////////
		//////////////
	}
}
