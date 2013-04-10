package net.mg2013.display
{
	import flash.display.DisplayObject;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;

	public class MGColorTransform
	{
		protected static var _lumR:Number = 0.212671; //Red constant - used for a few color matrix filter functions

		/** @private **/
		protected static var _lumG:Number = 0.715160; //Green constant - used for a few color matrix filter functions

		/** @private **/
		protected static var _lumB:Number = 0.072169;

		public static function exposure(_item:DisplayObject, _exposure:Number):void
		{
			var end:ColorTransform = _item.transform.colorTransform;
			end.redOffset = end.greenOffset = end.blueOffset = 255 * (_exposure - 1);
			end.redMultiplier = end.greenMultiplier = end.blueMultiplier = 1;
			_item.transform.colorTransform = end
		}

		public static function brightness(_item:DisplayObject, _brightness:Number):void
		{
			var end:ColorTransform = _item.transform.colorTransform;
			end.redOffset = end.greenOffset = end.blueOffset = Math.max(0, (_brightness - 1) * 255);
			end.redMultiplier = end.greenMultiplier = end.blueMultiplier = 1 - Math.abs(_brightness - 1);
			_item.transform.colorTransform = end
		}

		public static function colorTransform(_item:DisplayObject, _tint:uint, _tintAmount:Number):void
		{
			var end:ColorTransform = _item.transform.colorTransform;
			if (_tintAmount > 0)
				end.color = int(_tint);
			var ratio:Number = _tintAmount / (1 - ((end.redMultiplier + end.greenMultiplier + end.blueMultiplier) / 3));
			end.redOffset *= ratio;
			end.greenOffset *= ratio;
			end.blueOffset *= ratio;
			end.redMultiplier = end.greenMultiplier = end.blueMultiplier = 1 - _tintAmount;
			_item.transform.colorTransform = end
		}

		public static function removeAddedTint(_item:DisplayObject):void
		{
			_item.transform.colorTransform = new ColorTransform()
		}

		/**
		 * sets brightness value available are -100 ~ 100 @default is 0
		 * @param 		value:int	brightness value
		 * @return		ColorMatrixFilter
		 */
		public static function setBrightness(value:Number):ColorMatrixFilter
		{
			value = value * (255 / 250);
			var m:Array = new Array();
			m = m.concat([ 1, 0, 0, 0, value ]); // red
			m = m.concat([ 0, 1, 0, 0, value ]); // green
			m = m.concat([ 0, 0, 1, 0, value ]); // blue
			m = m.concat([ 0, 0, 0, 1, 0 ]); // alpha
			return new ColorMatrixFilter(m);
		}

		/**
		 * sets contrast value available are -100 ~ 100 @default is 0
		 * @param 		value:int	contrast value
		 * @return		ColorMatrixFilter
		 */
		public static function setContrast(value:Number):ColorMatrixFilter
		{
			value /= 100;
			var s:Number = value + 1;
			var o:Number = 128 * (1 - s);
			var m:Array = new Array();
			m = m.concat([ s, 0, 0, 0, o ]); // red
			m = m.concat([ 0, s, 0, 0, o ]); // green
			m = m.concat([ 0, 0, s, 0, o ]); // blue
			m = m.concat([ 0, 0, 0, 1, 0 ]); // alpha
			return new ColorMatrixFilter(m);
		}

		/**
		 * sets saturation value available are -100 ~ 100 @default is 0
		 * @param 		value:int	saturation value
		 * @return		ColorMatrixFilter
		 */
		public static function setSaturation(value:Number):ColorMatrixFilter
		{
			const lumaR:Number = 0.212671;
			const lumaG:Number = 0.71516;
			const lumaB:Number = 0.072169;
			var v:Number = (value / 100) + 1;
			var i:Number = (1 - v);
			var r:Number = (i * lumaR);
			var g:Number = (i * lumaG);
			var b:Number = (i * lumaB);
			var m:Array = new Array();
			m = m.concat([(r + v), g, b, 0, 0 ]); // red
			m = m.concat([ r, (g + v), b, 0, 0 ]); // green
			m = m.concat([ r, g, (b + v), 0, 0 ]); // blue
			m = m.concat([ 0, 0, 0, 1, 0 ]); // alpha
			return new ColorMatrixFilter(m);
		}
	}
}
