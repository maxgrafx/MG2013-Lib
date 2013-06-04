package net.mg2013.utils
{

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
					color = MGColorUtil.HSV2RGB(ratio * i, 100, 100);
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
					color = MGColorUtil.HSV2RGB(ratio * i, 100, 100);
					for (j = 0; j < m; j++)
					{
						pixels[i + (j * n)] = color;
					}
				}
			}
			return pixels;
		}

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
				ratio = 360 / height;
				for (i = 0; i < n; i++)
				{
					color = MGColorUtil.HSV2RGB(ratio * i, 100, 100);
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

		public static function fullColorMap(width:int, height:int):Vector.<uint>
		{
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
