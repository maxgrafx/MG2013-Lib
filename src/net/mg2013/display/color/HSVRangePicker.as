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
	public class HSVRangePicker extends Sprite
	{
		//////////////
		////////////// CONSTRUCTOR ------------------------------------------------------------------------------------------- CONSTRUCTOR //////////////////////
		//////////////
		private var __bitmap:Bitmap;

		private var __hsv:HSV = new HSV(0, 0, 0);

		private var __pixels:Vector.<uint>;

		private var __indicator:Shape;

		public function HSVRangePicker(hue:Number, width:int, height:int)
		{
			super();
			__hsv = new HSV(hue, 100, 100);
			__pixels = MGColorChart.tripleColorRange(width, height, 0xFFFFFF, __hsv.toHex(), 0x000000);
			buttonMode = true;
			tabChildren = tabEnabled = mouseChildren = false;
			initBitmap(__pixels, width, height);
			initIndicator();
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDownEvent, false, 0, true);
			scrollRect = new Rectangle(0, 0, width, height);
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
		protected function updateHue():void
		{
			var nhsv:HSV = new HSV(hsv.hue, 100, 100);
			__pixels = MGColorChart.tripleColorRange(__bitmap.bitmapData.width, __bitmap.bitmapData.height, 0xFFFFFF, nhsv.toHex(), 0x000000);
			__bitmap.bitmapData.lock();
			__bitmap.bitmapData.setVector(__bitmap.bitmapData.rect, __pixels);
			__bitmap.bitmapData.unlock();
			__indicator.x = (int(__bitmap.width * (__hsv.saturation / 100))) - __indicator.width / 2;
			__indicator.y = (__bitmap.height - int(__bitmap.height * (__hsv.value / 100))) - __indicator.height / 2;
		}

		protected function initIndicator():void
		{
			__indicator = new Shape();
			__indicator.graphics.lineStyle(1, 0xFFFFFF, 1, false);
			__indicator.graphics.drawCircle(4, 4, 4);
			addChild(__indicator);
			__indicator.x = int(__bitmap.width * (100 / __hsv.saturation)) - __indicator.width / 2;
			__indicator.y = int(__bitmap.height * (100 / __hsv.value)) - __indicator.height / 2;
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
			__hsv.saturation = (mouseX / __bitmap.bitmapData.width) * 100;
			__hsv.value = 100 - ((mouseY / __bitmap.bitmapData.height) * 100);
			__indicator.x = mouseX - __indicator.width / 2;
			__indicator.y = mouseY - __indicator.height / 2;
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
			updateHue();
		}
		//////////////
		////////////// OVERRIDE GET & SET ------------------------------------------------------------------------------------ OVERRIDE GET & SET ///////////////
		//////////////
	}
}
