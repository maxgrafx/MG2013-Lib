package net.mg2013.display.bitmap.texture
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import net.mg2013.display.Scale9BitmapDataSprite;
	import net.mg2013.display.SpriteStageEvents;
	import net.mg2013.singeltons.Textures;
	import net.mg2013.vo.TextureVO;

	public class TextureButton extends SpriteStageEvents
	{
		//////////////
		////////////// CONSTRUCTOR ------------------------------------------------------------------------------------------- CONSTRUCTOR ///////////////////////////
		//////////////
		private var __autoDispose:Boolean;

		private var __bg:Scale9BitmapDataSprite;

		public function TextureButton(texture:*, autoDispose:Boolean = false)
		{
			__autoDispose = autoDispose;
			super(true);
			initTexture(texture);
			mouseChildren = tabChildren = tabEnabled = false;
			buttonMode = true;
		}

		//////////////
		////////////// PUBLIC ------------------------------------------------------------------------------------------------ PUBLIC ///////////////////////////
		//////////////
		//////////////
		////////////// OVERRIDE PUBLIC --------------------------------------------------------------------------------------- OVERRIDE PUBLIC //////////////////
		//////////////
		override public function dispose():void
		{
			super.dispose();
			if (__bg)
			{
				if (contains(__bg))
					removeChild(__bg);
				__bg.dispose();
				__bg = null;
			}
		}

		//////////////
		////////////// PROTECTED --------------------------------------------------------------------------------------------- PROTECTED ////////////////////////
		//////////////
		protected function initTexture(texture:*):void
		{
			var bmd:BitmapData
			var textureVO:TextureVO;
			var valid:Boolean = true;
			if (texture is TextureVO)
			{
				textureVO = TextureVO(texture);
				bmd = Textures.inst.getTexture(textureVO.textureID, textureVO.trimmed);
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
			if (!valid)
				throw new Error("the 'texture' var should be net.mg2013.vo.TextureVO, flash.display.Bitmap or flash.display.BitmapData!");
			__bg = new Scale9BitmapDataSprite(bmd, textureVO ? textureVO.scale9Rectangle : null, textureVO ? textureVO.repeatTexture : false);
			addChild(__bg);
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
		override protected function addedToStage(event:Event):void
		{
			super.addedToStage(event);
		}

		override protected function removeFromStage(event:Event):void
		{
			if (__autoDispose)
			{
				dispose();
			}
			super.removeFromStage(event);
		}
		//////////////
		////////////// GET & SET --------------------------------------------------------------------------------------------- GET & SET ////////////////////////
		//////////////
		//////////////
		////////////// OVERRIDE GET & SET ------------------------------------------------------------------------------------ OVERRIDE GET & SET ///////////////
		//////////////
	}
}
