package net.mg2013.vo
{

	public class StyleSheetObject
	{
		//////////////
		////////////// CONSTRUCTOR ------------------------------------------------------------------------------------------- CONSTRUCTOR //////////////////////
		//////////////
		private var __color:String;

		private var __display:String;

		private var __fontFamily:String;

		private var __fontSize:Number;

		private var __fontStyle:String;

		private var __fontWeight:String;

		private var __kerning:Number;

		private var __leading:Number;

		private var __letterSpacing:Number;

		private var __marginLeft:Number;

		private var __marginRight:Number;

		private var __textAlign:String;

		private var __textDecoration:String;

		private var __textIndent:Number;

		public function StyleSheetObject()
		{
			super();
		}

		//////////////
		////////////// PUBLIC ------------------------------------------------------------------------------------------------ PUBLIC ///////////////////////////
		//////////////
		public function getAsObject():Object
		{
			var obj:Object = {};
			if (color)
				obj.color = color;
			if (display)
				obj.display = display;
			if (fontFamily)
				obj.fontFamily = fontFamily;
			if (fontSize)
				obj.fontSize = fontSize;
			if (fontStyle)
				obj.fontStyle = fontStyle;
			if (fontWeight)
				obj.fontWeight = fontWeight;
			if (kerning)
				obj.kerning = kerning;
			if (leading)
				obj.leading = leading;
			if (letterSpacing)
				obj.letterSpacing = letterSpacing;
			if (marginLeft)
				obj.marginLeft = marginLeft;
			if (marginRight)
				obj.marginRight = marginRight;
			if (textAlign)
				obj.textAlign = textAlign;
			if (textDecoration)
				obj.textDecoration = textDecoration;
			if (textIndent)
				obj.textIndent = textIndent;
			return obj;
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
		public function get color():String
		{
			return __color;
		}

		/**
		 *Only hexadecimal color values are supported. Named colors (such as blue) are not supported. Colors are written in the following format: #FF0000.
		 * @param value
		 *
		 */
		public function set color(value:String):void
		{
			__color = value;
		}

		public function get display():String
		{
			return __display;
		}

		/**
		 * Supported values are inline, block, and none.
		 * @param value
		 *
		 */
		public function set display(value:String):void
		{
			__display = value;
		}

		public function get fontFamily():String
		{
			return __fontFamily;
		}

		/**
		 * A comma-separated list of fonts to use, in descending order of desirability. Any font family name can be used. If you specify a generic font name, it is converted to an appropriate device font. The following font conversions are available: mono is converted to _typewriter, sans-serif is converted to _sans, and serif is converted to _serif.
		 * @param value
		 *
		 */
		public function set fontFamily(value:String):void
		{
			__fontFamily = value;
		}

		public function get fontSize():Number
		{
			return __fontSize;
		}

		/**
		 * Only the numeric part of the value is used. Units (px, pt) are not parsed; pixels and points are equivalent.
		 * @param value
		 *
		 */
		public function set fontSize(value:Number):void
		{
			__fontSize = value;
		}

		public function get fontStyle():String
		{
			return __fontStyle;
		}

		/**
		 * Recognized values are normal and italic.
		 * @param value
		 *
		 */
		public function set fontStyle(value:String):void
		{
			__fontStyle = value;
		}

		public function get fontWeight():String
		{
			return __fontWeight;
		}

		/**
		 * Recognized values are normal and bold.
		 * @param value
		 *
		 */
		public function set fontWeight(value:String):void
		{
			__fontWeight = value;
		}

		public function get kerning():Number
		{
			return __kerning;
		}

		/**
		 * Recognized values are true and false. Kerning is supported for embedded fonts only. Certain fonts, such as Courier New, do not support kerning. The kerning property is only supported in SWF files created in Windows, not in SWF files created on the Macintosh. However, these SWF files can be played in non-Windows versions of Flash Player and the kerning still applies.
		 * @param value
		 *
		 */
		public function set kerning(value:Number):void
		{
			__kerning = value;
		}

		public function get leading():Number
		{
			return __leading;
		}

		/**
		 * The amount of space that is uniformly distributed between lines. The value specifies the number of pixels that are added after each line. A negative value condenses the space between lines. Only the numeric part of the value is used. Units (px, pt) are not parsed; pixels and points are equivalent.
		 * @param value
		 *
		 */
		public function set leading(value:Number):void
		{
			__leading = value;
		}

		public function get letterSpacing():Number
		{
			return __letterSpacing;
		}

		/**
		 * The amount of space that is uniformly distributed between characters. The value specifies the number of pixels that are added after each character. A negative value condenses the space between characters. Only the numeric part of the value is used. Units (px, pt) are not parsed; pixels and points are equivalent.
		 * @param value
		 *
		 */
		public function set letterSpacing(value:Number):void
		{
			__letterSpacing = value;
		}

		public function get marginLeft():Number
		{
			return __marginLeft;
		}

		/**
		 * Only the numeric part of the value is used. Units (px, pt) are not parsed; pixels and points are equivalent.
		 * @param value
		 *
		 */
		public function set marginLeft(value:Number):void
		{
			__marginLeft = value;
		}

		public function get marginRight():Number
		{
			return __marginRight;
		}

		/**
		 * Only the numeric part of the value is used. Units (px, pt) are not parsed; pixels and points are equivalent.
		 * @param value
		 *
		 */
		public function set marginRight(value:Number):void
		{
			__marginRight = value;
		}

		public function get textAlign():String
		{
			return __textAlign;
		}

		/**
		 * Recognized values are left, center, right, and justify.
		 * @param value
		 *
		 */
		public function set textAlign(value:String):void
		{
			__textAlign = value;
		}

		public function get textDecoration():String
		{
			return __textDecoration;
		}

		/**
		 * Recognized values are none and underline.
		 * @param value
		 *
		 */
		public function set textDecoration(value:String):void
		{
			__textDecoration = value;
		}

		public function get textIndent():Number
		{
			return __textIndent;
		}

		/**
		 * Only the numeric part of the value is used. Units (px, pt) are not parsed; pixels and points are equivalent.
		 * @param value
		 *
		 */
		public function set textIndent(value:Number):void
		{
			__textIndent = value;
		}
	}
}
