package net.mg2013.display
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class Scale9BitmapDataSprite extends SpriteStageEvents implements ISpriteStageEvents
	{
		//////////////
		////////////// CONSTRUCTOR ------------------------------------------------------------------------------------------- CONSTRUCTOR //////////////////////
		//////////////
		private var __bitmapData:BitmapData;

		private var __scale9Rectangle:Rectangle;

		private var __topLeft:Shape;

		private var __topRight:Shape;

		private var __bottomLeft:Shape;

		private var __bottomRight:Shape;

		private var __left:Shape;

		private var __right:Shape;

		private var __top:Shape;

		private var __shape:Shape;

		private var __bottom:Shape;

		private var __center:Shape;

		private var __height:Number = 0;

		private var __width:Number = 0;

		private var __repeatTexture:Boolean;

		private var __bBmd:BitmapData;

		private var __cBmd:BitmapData;

		private var __tBmd:BitmapData;

		private var __rBmd:BitmapData;

		private var __lBmd:BitmapData;

		private var __brBmd:BitmapData;

		private var __blBmd:BitmapData;

		private var __trBmd:BitmapData;

		private var __tlBmd:BitmapData;

		public function Scale9BitmapDataSprite(bitmapData:BitmapData, scale9Rect:Rectangle = null, repeatTexture:Boolean = false)
		{
			__bitmapData = bitmapData;
			__scale9Rectangle = scale9Rect;
			__repeatTexture = repeatTexture;
			super(true);
			__width = __bitmapData.width;
			__height = __bitmapData.height;
			initShapes();
		}

		//////////////
		////////////// PUBLIC ------------------------------------------------------------------------------------------------ PUBLIC ///////////////////////////
		//////////////
		public function setSize(_width:Number, _height:Number):void
		{
			__width = _width;
			__height = _height;
			validateSize();
		}

		//////////////
		////////////// OVERRIDE PUBLIC --------------------------------------------------------------------------------------- OVERRIDE PUBLIC //////////////////
		//////////////
		override public function dispose():void
		{
			super.dispose();
			if (__bBmd)
			{
				__bBmd.dispose();
				__bBmd = null;
			}
			if (__cBmd)
			{
				__cBmd.dispose();
				__cBmd = null;
			}
			if (__tBmd)
			{
				__tBmd.dispose();
				__tBmd = null;
			}
			if (__rBmd)
			{
				__rBmd.dispose();
				__rBmd = null;
			}
			if (__lBmd)
			{
				__lBmd.dispose();
				__lBmd = null;
			}
			if (__brBmd)
			{
				__brBmd.dispose();
				__brBmd = null;
			}
			if (__blBmd)
			{
				__blBmd.dispose();
				__blBmd = null;
			}
			if (__trBmd)
			{
				__trBmd.dispose();
				__trBmd = null;
			}
			if (__tlBmd)
			{
				__tlBmd.dispose();
				__tlBmd = null;
			}
			if (__bitmapData)
			{
				__bitmapData.dispose();
				__bitmapData = null;
			}
			if (__topLeft)
			{
				__topLeft.graphics.clear();
				__topLeft = null;
			}
			if (__topRight)
			{
				__topRight.graphics.clear();
				__topRight = null;
			}
			if (__bottomLeft)
			{
				__bottomLeft.graphics.clear();
				__bottomLeft = null;
			}
			if (__bottomRight)
			{
				__bottomRight.graphics.clear();
				__bottomRight = null;
			}
			if (__left)
			{
				__left.graphics.clear();
				__left = null;
			}
			if (__right)
			{
				__right.graphics.clear();
				__right = null;
			}
			if (__top)
			{
				__top.graphics.clear();
				__top = null;
			}
			if (__shape)
			{
				__shape.graphics.clear();
				__shape = null;
			}
			if (__bottom)
			{
				__bottom.graphics.clear();
				__bottom = null;
			}
			if (__center)
			{
				__center.graphics.clear();
				__center = null;
			}
		}

		//////////////
		////////////// PROTECTED --------------------------------------------------------------------------------------------- PROTECTED ////////////////////////
		//////////////
		protected function validateSize():void
		{
			if (!__scale9Rectangle)
			{
				__height = isNaN(height) ? 0 : height;
				__width = isNaN(width) ? 0 : width;
				if (__repeatTexture)
				{
					__shape.graphics.clear();
					__shape.graphics.beginBitmapFill(__bitmapData, null, __repeatTexture, true);
					__shape.graphics.drawRect(0, 0, width, height);
					return;
				}
				__shape.width = width;
				__shape.height = height;
				//__height = height;
				return;
			}
			var w:Number = isNaN(width - __right.width - __left.width) ? 0 : (width - __right.width - __left.width)
			var h:Number = isNaN(height - __top.height - __bottom.height) ? 0 : (height - __top.height - __bottom.height);
			__topRight.x = width - __topRight.width;
			__topRight.y = 0;
			__bottomLeft.x = 0;
			__bottomLeft.y = height - __bottomLeft.height;
			__bottomRight.x = width - __bottomRight.width;
			__bottomRight.y = height - __bottomRight.height;
			__left.x = 0;
			__left.y = __scale9Rectangle.y;
			if (__repeatTexture)
			{
				__left.graphics.clear();
				__left.graphics.beginBitmapFill(__lBmd, null, __repeatTexture, true);
				__left.graphics.drawRect(0, 0, __lBmd.width, h);
			}
			else
				__left.height = h;
			__right.x = width - __right.width;
			__right.y = __scale9Rectangle.y;
			if (__repeatTexture)
			{
				__right.graphics.clear();
				__right.graphics.beginBitmapFill(__rBmd, null, __repeatTexture, true);
				__right.graphics.drawRect(0, 0, __rBmd.width, h);
			}
			else
				__right.height = h;
			__top.x = __scale9Rectangle.x;
			__top.y = 0;
			if (__repeatTexture)
			{
				__top.graphics.clear();
				__top.graphics.beginBitmapFill(__tBmd, null, __repeatTexture, true);
				__top.graphics.drawRect(0, 0, w, __tBmd.height);
			}
			else
				__top.width = w;
			__bottom.x = __scale9Rectangle.x;
			__bottom.y = height - __bottom.height;
			if (__repeatTexture)
			{
				__bottom.graphics.clear();
				__bottom.graphics.beginBitmapFill(__bBmd, null, __repeatTexture, true);
				__bottom.graphics.drawRect(0, 0, w, __bBmd.height);
			}
			else
				__bottom.width = w;
			__center.x = __scale9Rectangle.x;
			__center.y = __scale9Rectangle.y;
			if (__repeatTexture)
			{
				__center.graphics.clear();
				__center.graphics.beginBitmapFill(__cBmd, null, __repeatTexture, true);
				__center.graphics.drawRect(0, 0, w, h);
			}
			else
			{
				__center.width = w;
				__center.height = h;
			}
			__height = __bottom.y + __bottom.height;
			__width = __right.x + __right.width;
		}

		protected function initShapes():void
		{
			
			if (!__scale9Rectangle)
			{
				__shape = new Shape();
				__shape.graphics.beginBitmapFill(__bitmapData, null, __repeatTexture, true);
				__shape.graphics.drawRect(0, 0, __bitmapData.width, __bitmapData.height);
				addChild(__shape);
				return;
			}
			__topLeft = new Shape();
			__tlBmd = new BitmapData(__scale9Rectangle.x, __scale9Rectangle.y, true, 0x00000000);
			__tlBmd.copyPixels(__bitmapData, new Rectangle(0, 0, __tlBmd.width, __tlBmd.height), new Point(), null, null, true);
			__topLeft.graphics.beginBitmapFill(__tlBmd, null, false, true);
			__topLeft.graphics.drawRect(0, 0, __tlBmd.width, __tlBmd.height);
			addChild(__topLeft);
			////////
			__topRight = new Shape();
			__trBmd = new BitmapData(__bitmapData.width - __scale9Rectangle.x - __scale9Rectangle.width, __scale9Rectangle.y, true, 0x00000000);
			__trBmd.copyPixels(__bitmapData, new Rectangle(__scale9Rectangle.x + __scale9Rectangle.width, 0, __trBmd.width, __trBmd.height), new Point(), null, null, true);
			__topRight.graphics.beginBitmapFill(__trBmd, null, false, true);
			__topRight.graphics.drawRect(0, 0, __trBmd.width, __trBmd.height);
			addChild(__topRight);
			//////
			__bottomLeft = new Shape();
			__blBmd = new BitmapData(__scale9Rectangle.x, __bitmapData.height - __scale9Rectangle.y - __scale9Rectangle.height, true, 0x00000000);
			__blBmd.copyPixels(__bitmapData, new Rectangle(0, __scale9Rectangle.y + __scale9Rectangle.height, __blBmd.width, __blBmd.height), new Point(), null, null, true);
			__bottomLeft.graphics.beginBitmapFill(__blBmd, null, false, true);
			__bottomLeft.graphics.drawRect(0, 0, __blBmd.width, __blBmd.height);
			addChild(__bottomLeft);
			//////
			__bottomRight = new Shape();
			__brBmd = new BitmapData(__bitmapData.width - __scale9Rectangle.x - __scale9Rectangle.width, __bitmapData.height - __scale9Rectangle.y - __scale9Rectangle.height, true, 0x00000000);
			__brBmd.copyPixels(__bitmapData, new Rectangle(__scale9Rectangle.x + __scale9Rectangle.width, __scale9Rectangle.y + __scale9Rectangle.height, __brBmd.width, __brBmd.height), new Point(), null, null, true);
			__bottomRight.graphics.beginBitmapFill(__brBmd, null, false, true);
			__bottomRight.graphics.drawRect(0, 0, __brBmd.width, __brBmd.height);
			addChild(__bottomRight);
			//////
			__left = new Shape();
			__lBmd = new BitmapData(__scale9Rectangle.x, __scale9Rectangle.height, true, 0x00000000);
			__lBmd.copyPixels(__bitmapData, new Rectangle(0, __scale9Rectangle.y, __lBmd.width, __lBmd.height), new Point(), null, null, true);
			__left.graphics.beginBitmapFill(__lBmd, null, __repeatTexture, true);
			__left.graphics.drawRect(0, 0, __lBmd.width, __lBmd.height);
			addChild(__left);
			//////
			__right = new Shape();
			__rBmd = new BitmapData(__bitmapData.width - __scale9Rectangle.x - __scale9Rectangle.width, __scale9Rectangle.height, true, 0x00000000);
			__rBmd.copyPixels(__bitmapData, new Rectangle(__scale9Rectangle.x + __scale9Rectangle.width, __scale9Rectangle.y, __rBmd.width, __rBmd.height), new Point(), null, null, true);
			__right.graphics.beginBitmapFill(__rBmd, null, __repeatTexture, true);
			__right.graphics.drawRect(0, 0, __rBmd.width, __rBmd.height);
			addChild(__right);
			//////
			__top = new Shape();
			__tBmd = new BitmapData(__scale9Rectangle.width, __scale9Rectangle.y, true, 0x00000000);
			__tBmd.copyPixels(__bitmapData, new Rectangle(__scale9Rectangle.x, 0, __tBmd.width, __tBmd.height), new Point(), null, null, true);
			__top.graphics.beginBitmapFill(__tBmd, null, __repeatTexture, true);
			__top.graphics.drawRect(0, 0, __tBmd.width, __tBmd.height);
			addChild(__top);
			//////
			__bottom = new Shape();
			__bBmd = new BitmapData(__scale9Rectangle.width, __bitmapData.height - __scale9Rectangle.y - __scale9Rectangle.height, true, 0x00000000);
			__bBmd.copyPixels(__bitmapData, new Rectangle(__scale9Rectangle.x, __scale9Rectangle.y + __scale9Rectangle.height, __bBmd.width, __bBmd.height), new Point(), null, null, true);
			__bottom.graphics.beginBitmapFill(__bBmd, null, __repeatTexture, true);
			__bottom.graphics.drawRect(0, 0, __bBmd.width, __bBmd.height);
			addChild(__bottom);
			//////
			__center = new Shape();
			__cBmd = new BitmapData(__scale9Rectangle.width, __scale9Rectangle.height, true, 0x00000000);
			__cBmd.copyPixels(__bitmapData, __scale9Rectangle, new Point(), null, null, true);
			__center.graphics.beginBitmapFill(__cBmd, new Matrix(), __repeatTexture, true);
			__center.graphics.drawRect(0, 0, __cBmd.width, __cBmd.height);
			addChild(__center);
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
			validateSize();
		}

		override public function get width():Number
		{
			return __width;
		}

		override public function set width(value:Number):void
		{
			__width = value;
			validateSize();
		}

		public function get scale9Rectangle():Rectangle
		{
			return __scale9Rectangle;
		}
	}
}
