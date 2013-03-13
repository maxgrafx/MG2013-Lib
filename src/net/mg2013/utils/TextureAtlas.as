package net.mg2013.utils
{
	import net.mg2013.display.bitmap.texture.BitmapDataTexture;
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;

	public class TextureAtlas
	{
		//////////////
		////////////// CONSTRUCTOR ------------------------------------------------------------------------------------------- CONSTRUCTOR //////////////////////
		//////////////
		private var __regions:Vector.<Rectangle> = new Vector.<Rectangle>();

		private var __frames:Vector.<Rectangle> = new Vector.<Rectangle>();

		private var __ids:Vector.<String> = new Vector.<String>();

		private var __atlasTexture:BitmapData;

		public function TextureAtlas(bitmapdata:BitmapData, atlasXml:XML)
		{
			__atlasTexture = bitmapdata;
			__atlasTexture.getPixel(0, 0);
			if (atlasXml)
				parseAtlasXml(atlasXml);
		}

		//////////////
		////////////// PUBLIC ------------------------------------------------------------------------------------------------ PUBLIC ///////////////////////////
		//////////////
		public function addRegion(name:String, region:Rectangle, frame:Rectangle = null):void
		{
			__regions.push(region);
			__frames.push(frame);
			__ids.push(name);
		}

		public function getTexture(name:String):BitmapDataTexture
		{
			var index:int = __ids.indexOf(name);
			if (index == -1)
				return null;
			else
				return BitmapDataTexture.fromTexture(__atlasTexture, __regions[index], __frames[index]);
		}

		//////////////
		////////////// OVERRIDE PUBLIC --------------------------------------------------------------------------------------- OVERRIDE PUBLIC //////////////////
		//////////////
		//////////////
		////////////// PROTECTED --------------------------------------------------------------------------------------------- PROTECTED ////////////////////////
		//////////////
		protected function parseAtlasXml(atlasXml:XML):void
		{
			for each (var subTexture:XML in atlasXml.SubTexture)
			{
				var name:String = subTexture.attribute("name");
				var x:Number = parseFloat(subTexture.attribute("x"));
				var y:Number = parseFloat(subTexture.attribute("y"));
				var width:Number = parseFloat(subTexture.attribute("width"));
				var height:Number = parseFloat(subTexture.attribute("height"));
				var frameX:Number = parseFloat(subTexture.attribute("frameX"));
				var frameY:Number = parseFloat(subTexture.attribute("frameY"));
				var frameWidth:Number = parseFloat(subTexture.attribute("frameWidth"));
				var frameHeight:Number = parseFloat(subTexture.attribute("frameHeight"));
				var region:Rectangle = new Rectangle(x, y, width, height);
				var frame:Rectangle = frameWidth > 0 && frameHeight > 0 ? new Rectangle(frameX, frameY, frameWidth, frameHeight) : null;
				addRegion(name, region, frame);
			}
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
		public function get ids():Vector.<String>
		{
			return __ids;
		}
		//////////////
		////////////// OVERRIDE GET & SET ------------------------------------------------------------------------------------ OVERRIDE GET & SET ///////////////
		//////////////
	}
}