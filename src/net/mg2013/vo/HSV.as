package net.mg2013.vo
{
	import net.mg2013.utils.MGColorUtil;

	public class HSV
	{
		//////////////
		////////////// CONSTRUCTOR ------------------------------------------------------------------------------------------- CONSTRUCTOR //////////////////////
		//////////////
		private var __hue:Number;

		private var __saturation:Number;

		private var __value:Number;

		/**
		 *
		 * @param hue: 0 - 360
		 * @param saturation: 0 - 100;
		 * @param value: 0 - 100;
		 *
		 */
		public function HSV(hue:Number = 0, saturation:Number = 100, value:Number = 100)
		{
			hue %= 360;
			__hue = hue < 0 ? 0 : hue;
			__saturation = saturation > 100 ? 100 : saturation < 0 ? 0 : saturation;
			__value = value > 100 ? 100 : value < 0 ? 0 : value;
		}

		//////////////
		////////////// PUBLIC ------------------------------------------------------------------------------------------------ PUBLIC ///////////////////////////
		//////////////
		public function clone():HSV
		{
			return new HSV(__hue, __saturation,__value);
		}
		public function toString():String
		{
			return "net.mg2013.vo.HSV: hue: " + hue + ", saturation: " + saturation + ", value: " + value;
		}

		/**
		 *
		 * @param color
		 *
		 */
		public function fromHex(color:uint):void
		{
			var hsv:HSV = MGColorUtil.Hex2HSV(color);
			
			hue = hsv.hue;
			saturation = hsv.saturation;
			value = hsv.value;
			hsv = null;
		}

		public function toHex():uint
		{
			return MGColorUtil.HSV2RGB(hue, saturation, value)
		}

		//////////////
		////////////// OVERRIDE PUBLIC --------------------------------------------------------------------------------------- OVERRIDE PUBLIC //////////////////
		//////////////
		//////////////
		////////////// PROTECTED --------------------------------------------------------------------------------------------- PROTECTED ////////////////////////
		//////////////
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
		//////////////
		////////////// OVERRIDE GET & SET ------------------------------------------------------------------------------------ OVERRIDE GET & SET ///////////////
		//////////////
		public function get hue():Number
		{
			return __hue;
		}

		public function set hue(value:Number):void
		{
			value %= 360;
			__hue = value < 0 ? 0 : value;
		}

		public function get saturation():Number
		{
			return __saturation;
		}

		public function set saturation(value:Number):void
		{
			__saturation = value > 100 ? 100 : value < 0 ? 0 : value;
		}

		public function get value():Number
		{
			return __value;
		}

		public function set value(value:Number):void
		{
			__value = value > 100 ? 100 : value < 0 ? 0 : value
		}
	}
}
