package net.mg2013.display.bitmap
{
	/**
	 * .....
	 * @author MAXGRAFX
	 * Apr 7, 2011
	 * mg.olasharehappy.display.utils.Bitmapper
	 *
	
	 */
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.PixelSnapping;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	public class Bitmapper
	{
		////////// CONSTRUCTOR -------------------------------------------------------------------------------------------------------------------------- CONSTRUCTOR
		public static function convert(displayObject:DisplayObject, xOffset:Number = 0, yOffset:Number = 0, smooth:Boolean = true, pixelsnapping:String = PixelSnapping.AUTO, bitmapClass:Class = null):*
		{
			var matrix:Matrix = new Matrix();
			matrix.scale(displayObject.scaleX, displayObject.scaleY);
			matrix.rotate(displayObject.rotation);
			matrix.translate(xOffset, yOffset);
			var bitmapData:BitmapData = new BitmapData(displayObject.width + (xOffset * 2), displayObject.height + (yOffset * 2), true, 0x00000000);
			bitmapData.lock();
			bitmapData.draw(displayObject, matrix, null, displayObject.blendMode, new Rectangle(0, 0, displayObject.width + (xOffset * 2), displayObject.height + (yOffset * 2)), smooth);
			bitmapData.unlock();
			var bitmap:Bitmap = bitmapClass ? new bitmapClass(bitmapData, pixelsnapping, smooth) : new Bitmap(bitmapData, pixelsnapping, smooth);
			return bitmap;
		}
		////////// PUBLIC FUNCTIONS --------------------------------------------------------------------------------------------------------------------- PUBLIC FUNCTIONS
		////////// OVERRIDE PUBLIC FUNCTIONS ------------------------------------------------------------------------------------------------------------ OVERRIDE PUBLIC FUNCTIONS
		////////// PUBLIC STATIC FUNCTIONS -------------------------------------------------------------------------------------------------------------- PUBLIC STATIC FUNCTIONS
		////////// PROTECTED FUNCTIONS ------------------------------------------------------------------------------------------------------------------ PROTECTED FUNCTIONS
		////////// OVERRIDE PROTECTED FUNCTIONS --------------------------------------------------------------------------------------------------------- OVERRIDE PROTECTED FUNCTIONS
		////////// EVENT FUNCTIONS ---------------------------------------------------------------------------------------------------------------------- EVENT FUNCTIONS
		////////// OVERRIDE EVENT FUNCTIONS ------------------------------------------------------------------------------------------------------------- OVERRIDE EVENT FUNCTIONS
		////////// MOUSE FUNCTIONS ---------------------------------------------------------------------------------------------------------------------- MOUSE FUNCTIONS
		////////// OVERRIDE MOUSE FUNCTIONS ------------------------------------------------------------------------------------------------------------- OVERRIDE MOUSE FUNCTIONS
		////////// PROTECTED GET & SET FUNCTIONS -------------------------------------------------------------------------------------------------------- PROTECTED GET & SET FUNCTIONS
		////////// PUBLIC GET & SET FUNCTIONS ----------------------------------------------------------------------------------------------------------- PUBLIC GET & SET FUNCTIONS
	}
}
