package net.mg2013.utils
{
	import flash.utils.getTimer;

	public class MGColorChart
	{
		public static const VERTICAL:String = "vertical";

		public static const HORIZONTAL:String = "horizontal";

		//////////////
		////////////// CONSTRUCTOR ------------------------------------------------------------------------------------------- CONSTRUCTOR //////////////////////
		//////////////
		//////////////
		////////////// PUBLIC ------------------------------------------------------------------------------------------------ PUBLIC ///////////////////////////
		//////////////
		/**
		 * <p>generates a full color hue range.</p>
		 * <lu>
		 * 		<li>@param width</li>
		 * 		<li>@param height</li>
		 * 		<li>@param direction: either <b>Horizontal</b> or <b>VERTICAL</b>. All the color hue's will be represented allong either axises.</li>
		 * 		<li>@return: a uint vector for use with <b>setVector</b> function available in the <b>Bitmapdata</b> class.</li>
		 * </lu>
		 *
		 */
		public static function fullHueRange(width:int, height:int, direction:String = MGColorChart.VERTICAL):Vector.<uint>
		{
			const pixels:Vector.<uint> = new Vector.<uint>(width * height, true);
			var num:int = 0;
			var ratio:Number;
			var n:int, m:int, i:int, j:int;
			var color:uint;
			if (direction == VERTICAL)
			{
				n = height;
				m = width;
				ratio = 360 / height;
				for (i = 0; i < n; i++)
				{
					color = MGColorUtil.HSV2RGB(ratio * i, 100, 100).toHex();
					for (j = 0; j < m; j++)
					{
						pixels[num] = color;
						num++;
					}
				}
			}
			if (direction == HORIZONTAL)
			{
				n = width;
				m = height;
				ratio = 360 / width;
				for (i = 0; i < n; i++)
				{
					color = MGColorUtil.HSV2RGB(ratio * i, 100, 100).toHex();
					for (j = 0; j < m; j++)
					{
						pixels[i + (j * n)] = color;
					}
				}
			}
			return pixels;
		}

		/**
		 * <p>generates a range of 2 colors.</p>
		 * <lu>
		 * 		<li>@param width</li>
		 * 		<li>@param height</li>
		 *		<li>@param color0</li>
		 * 		<li>@param color1</li>
		 * 		<li>@param direction: either <b>Horizontal</b> or <b>VERTICAL</b>. The 2 colors will be represented either from top to bottom, or left to right. Depending the axis</li>
		 * 		<li>@return: a uint vector for use with <b>setVector</b> function available in the <b>Bitmapdata</b> class.</li>
		 * </lu>
		 */
		

		public static function doubleColorRange(width:int, height:int, color0:uint, color1:uint, direction:String = MGColorChart.VERTICAL):Vector.<uint>
		{
			const pixels:Vector.<uint> = new Vector.<uint>(width * height, true);
			var num:int = 0;
			var ratio:Number;
			var n:int, m:int, i:int, j:int;
			var color:uint;
			if (direction == VERTICAL)
			{
				n = height;
				m = width;
				ratio = 1 / height;
				for (i = 0; i < n; i++)
				{
					color = MGColorUtil.colorChange(color1, color0, ratio * i);
					for (j = 0; j < m; j++)
					{
						pixels[num] = color;
						num++;
					}
				}
			}
			if (direction == HORIZONTAL)
			{
				n = width;
				m = height;
				ratio = 1 / width;
				for (i = 0; i < n; i++)
				{
					color = MGColorUtil.colorChange(color1, color0, ratio * i);
					for (j = 0; j < m; j++)
					{
						pixels[i + (j * n)] = color;
					}
				}
			}
			return pixels;
		}

		/**
		 * <p>generates a triple color hue range.</p>
		 * <lu>
		 * 		<li>@param width</li>
		 * 		<li>@param height</li>
		 *		<li>@param color0: top left color</li>
		 * 		<li>@param color1: top right color</li>
		 * 		<li>@param color2: bottom color</li>
		 * 		<li>@return: a uint vector for use with <b>setVector</b> function available in the <b>Bitmapdata</b> class.</li>
		 * </lu>
		 */
		public static function tripleColorRange(width:int, height:int, color0:uint, color1:uint, color2:uint):Vector.<uint>
		{
			var num:int = 0;
			const colors:Vector.<uint> = MGColorChart.doubleColorRange(width, 1, color0, color1, MGColorChart.HORIZONTAL);
			const pixels:Vector.<uint> = new Vector.<uint>(width * height, true);
			const ratio:Number = 1 / height;
			for (var i:int = 0; i < width; i++)
			{
				const wIndex:Number = ratio * i;
				for (var j:int = 0; j < height; j++)
				{
					var color:uint = colors[j];
					color = MGColorUtil.colorChange(color2, color, wIndex);
					pixels[num] = color;
					num++;
				}
			}
			return pixels;
		}

		/**
		 * <p>generates a four color hue range.</p>
		 * <lu>
		 * 		<li>@param width</li>
		 * 		<li>@param height</li>
		 *		<li>@param color0: top left color</li>
		 * 		<li>@param color1: top right color</li>
		 * 		<li>@param color2: bottom left color</li>
		 * 		<li>@param color3: bottom right color</li>
		 * 		<li>@return: a uint vector for use with <b>setVector</b> function available in the <b>Bitmapdata</b> class.</li>
		 * </lu>
		 */
		public static function fourColorRange(width:int, height:int, color0:uint, color1:uint, color2:uint, color3:uint):Vector.<uint>
		{
			var num:int = 0;
			const colors0:Vector.<uint> = MGColorChart.doubleColorRange(width, 1, color0, color1, MGColorChart.HORIZONTAL);
			const colors1:Vector.<uint> = MGColorChart.doubleColorRange(width, 1, color2, color3, MGColorChart.HORIZONTAL);
			const pixels:Vector.<uint> = new Vector.<uint>(width * height, true);
			const ratio:Number = 1 / height;
			for (var i:int = 0; i < width; i++)
			{
				const topIndex:Number = ratio * i;
				//const bottomIndex:Number = 1-(ratio * i);
				for (var j:int = 0; j < height; j++)
				{
					var colorTop:uint = colors0[j];
					var colorBottom:uint = colors1[j];
					var color:uint = MGColorUtil.colorChange(colorBottom, colorTop, topIndex);
					pixels[num] = color;
					num++;
				}
			}
			return pixels;
		}

		/**
		 * <p>generates a vector with all the colors possible with the width and height passed to the function.</p>
		 * <lu>
		 * 		<li>@param width</li>
		 * 		<li>@param height</li>
		 * 		<li>@return: a uint vector for use with <b>setVector</b> function available in the <b>Bitmapdata</b> class.</li>
		 * </lu>
		 */
		public static function fullColorMap(width:int, height:int):Vector.<uint>
		{
			var time:int = getTimer();
			var num:int = 0;
			const colors:Vector.<uint> = MGColorChart.fullHueRange(width, 1, MGColorChart.HORIZONTAL);
			const pixels:Vector.<uint> = new Vector.<uint>(width * height, true);
			const ratio2:Number = 1 / (height / 2);
			for (var i:int = 0; i < width; i++)
			{
				const wIndex:Number = ratio2 * i;
				for (var j:int = 0; j < height; j++)
				{
					var color:uint = colors[j];
					if (wIndex < 1)
					{
						color = MGColorUtil.colorChange(color, 0xFFFFFF, wIndex);
					}
					else
					{
						color = MGColorUtil.colorChange(color, 0x000000, 1 - (wIndex - 1));
					}
					pixels[num] = color;
					num++;
				}
			}
			return pixels;
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
