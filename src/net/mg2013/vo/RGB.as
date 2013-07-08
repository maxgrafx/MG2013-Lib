package net.mg2013.vo
{
	import net.mg2013.utils.MGColorUtil;

	public class RGB
	{
		//////////////
		////////////// CONSTRUCTOR ------------------------------------------------------------------------------------------- CONSTRUCTOR //////////////////////
		//////////////
		private var __red:uint;

		private var __green:uint;

		private var __blue:uint;

		public function RGB(red:uint = 0, green:uint = 0, blue:uint = 0)
		{
			__red = red;
			__green = green;
			__blue = blue;
		}

		//////////////
		////////////// PUBLIC ------------------------------------------------------------------------------------------------ PUBLIC ///////////////////////////
		//////////////
		public function clone():RGB
		{
			return new RGB(red, green, blue);
		}

		public function toString():String
		{
			return "net.mg2013.vo.RGB: Red: " + red + ", Green: " + green + ", Blue: " + blue;
		}

		public function toHex():uint
		{
			return MGColorUtil.combineRGB(red, green, blue);
		}

		public function fromHex(color:uint):void
		{
			red = MGColorUtil.extractRed(color);
			green = MGColorUtil.extractGreen(color);
			blue = MGColorUtil.extractBlue(color);
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
		public function get red():uint
		{
			return __red;
		}

		public function set red(value:uint):void
		{
			__red = value > 255 ? 255 : value;
		}

		public function get green():uint
		{
			return __green;
		}

		public function set green(value:uint):void
		{
			__green = value > 255 ? 255 : value;
		}

		public function get blue():uint
		{
			return __blue;
		}

		public function set blue(value:uint):void
		{
			__blue = value > 255 ? 255 : value;
		}
		//////////////
		////////////// OVERRIDE GET & SET ------------------------------------------------------------------------------------ OVERRIDE GET & SET ///////////////
		//////////////
	}
}
