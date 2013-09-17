package net.mg2013.display.bitmap.texture
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import net.mg2013.interfaces.IDisposable;
	import net.mg2013.singeltons.Textures;
	import net.mg2013.vo.TextureVO;

	public class BitmapTexture extends Bitmap implements IDisposable
	{
		//////////////
		////////////// CONSTRUCTOR ------------------------------------------------------------------------------------------- CONSTRUCTOR ///////////////////////////
		//////////////
		public function BitmapTexture(texture:*, pixelSnapping:String = "auto", smoothing:Boolean = true)
		{
			
			var bmd:BitmapData
			var valid:Boolean = true;
			if (texture is TextureVO)
			{
				bmd = Textures.inst.getTexture(TextureVO(texture).textureID, TextureVO(texture).trimmed);
			}
			else if (texture is Bitmap)
			{
				bmd = Bitmap(texture).bitmapData.clone();
				texture = null;
			}
			else if (texture is BitmapData)
			{
				bmd = BitmapData(texture);
			}
			else
				valid = false;
			super(bmd, pixelSnapping, smoothing);
			if (!valid)
				throw new Error("the 'texture' var should be net.mg2013.vo.TextureVO, flash.display.Bitmap or flash.display.BitmapData!");
		}

		//////////////
		////////////// PUBLIC ------------------------------------------------------------------------------------------------ PUBLIC ///////////////////////////
		//////////////
		public function dispose():void
		{
			if (bitmapData)
				bitmapData.dispose();
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
