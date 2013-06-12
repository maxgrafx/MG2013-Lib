package net.mg2013.display.bitmap.texture
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;

	public class BitmapDataTexture extends BitmapData
	{
		private static const POINT:Point = new Point();

		//////////////
		////////////// CONSTRUCTOR ------------------------------------------------------------------------------------------- CONSTRUCTOR //////////////////////
		//////////////
		public function BitmapDataTexture(width:int, height:int, transparent:Boolean = true, fillColor:uint = 4.294967295E9)
		{
			super(width, height, transparent, fillColor);
		}

		//////////////
		////////////// PUBLIC ------------------------------------------------------------------------------------------------ PUBLIC ///////////////////////////
		//////////////
		public static function fromTexture(bitmapdata:BitmapData, region:Rectangle, frame:Rectangle = null):BitmapDataTexture
		{
			var bmd:BitmapDataTexture = new BitmapDataTexture(frame ? frame.width : region.width, frame ? frame.height : region.height, true, 0x00000000);
			var nr:Rectangle = region.clone();
			if (frame)
			{
				//nr.x += frame.x;
				//nr.y += frame.y;
				//nr.width = frame.width;
				//nr.height = frame.height;
				bmd.copyPixels(bitmapdata, nr, new Point(Math.abs(frame.x), Math.abs(frame.y)), null, null, true);
			}
			else
			{
				bmd.copyPixels(bitmapdata, nr, POINT, null, null, true);
			}
			return bmd;
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
	}
}
