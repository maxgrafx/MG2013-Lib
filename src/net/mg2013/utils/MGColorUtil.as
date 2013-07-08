package net.mg2013.utils
{
	import net.mg2013.vo.HSV;
	import net.mg2013.vo.RGB;

	public class MGColorUtil
	{
		private static const hslConstant:Number = 0.003921568627450980392156862745098;

		////////// CONSTRUCTOR -------------------------------------------------------------------------------------------------------------------------- CONSTRUCTOR
		public static function colorChange(color:uint, into:uint = 0xFFFFFFFF, factor:Number = 0.5, blendAlpha:Boolean = false):uint
		{
			if (factor < 0 || factor > 1)
				factor = 0.5;
			var a1:uint = (color >> 24) & 0xFF;
			var r1:uint = (color >> 16) & 0xFF;
			var g1:uint = (color >> 8) & 0xFF;
			var b1:uint = (color >> 0) & 0xFF;
			var a2:uint = (into >> 24) & 0xFF;
			var r2:uint = (into >> 16) & 0xFF;
			var g2:uint = (into >> 8) & 0xFF;
			var b2:uint = (into >> 0) & 0xFF;
			var a3:uint = (a1 * factor + a2 * (1 - factor)) & 0xFF;
			var r3:uint = (r1 * factor + r2 * (1 - factor)) & 0xFF;
			var g3:uint = (g1 * factor + g2 * (1 - factor)) & 0xFF;
			var b3:uint = (b1 * factor + b2 * (1 - factor)) & 0xFF;
			return (blendAlpha ? a3 << 24 : 0x0) | (r3 << 16) | (g3 << 8) | b3;
		}

		/**
		 *
		 * @param color uint
		 * @return net.mg2013.vo.HSV object. with Hue, Saturation and Value variables;
		 *
		 */
		public static function Hex2HSV(color:uint):HSV
		{
			var rgb:RGB = new RGB();
			rgb.fromHex(color);
			var red:Number = rgb.red / 255;
			var green:Number = rgb.green / 255;
			var blue:Number = rgb.blue / 255;
			var min:Number;
			var max:Number;
			var delta:Number;
			min = Math.min(red, green, blue);
			max = Math.max(red, green, blue);
			var v:Number = max;
			// v
			var h:Number;
			delta = max - min;
			var s:Number;
			if (max != 0)
			{
				s = delta / max; // s
			}
			else
			{
				// r = g = b = 0		// s = 0, v is undefined
				s = 0;
				h = -1;
				return new HSV(h, s * 100, v);
			}
			if (red == max)
			{
				h = (green - blue) / delta; // between yellow & magenta
			}
			else if (green == max)
			{
				h = 2 + (blue - red) / delta; // between cyan & yellow
			}
			else
			{
				h = 4 + (red - green) / delta; // between magenta & cyan
			}
			h *= 60;
			// degrees
			if (h < 0)
			{
				h += 360;
			}
			return new HSV(h, s * 100, v * 100);
		}

		/**
		 * <p>returns the Hue of the color passed, without any saturation or Chroma.</p>
		 * <lu>
		 * 		<li>@param color</li>
		 * 		<li>@return</li>
		 * </lu>
		 *
		 */
		public static function Hex2Hue(color:uint):uint
		{
			var hsvColor:HSV = Hex2HSV(color);
			return HSV2RGB(hsvColor.hue, 100, 100).toHex();
		}

		/**
		 * <p></p>
		 * <lu>
		 * 		<li>@param hue: 0 - 360, representing every color hue.</li>
		 * 		<li>@param sat: 0 - 100, 0 equals no color or white, 100 equals full color.</li>
		 * 		<li>@param val: 0 - 100, 0 equals black no matter what the other value passed are. 100 equals full Chroma and will appear very bright</li>
		 * 		<li>@return</li>
		 * </lu>
		 *
		 */
		public static function HSV2RGB(hue:Number, sat:Number, val:Number):RGB
		{
			var red:Number, green:Number, blue:Number, i:Number, f:Number, p:Number, q:Number, t:Number;
			hue %= 360;
			if (val == 0)
			{
				return new RGB(0, 0, 0);
			}
			sat /= 100;
			val /= 100;
			hue /= 60;
			i = Math.floor(hue);
			f = hue - i;
			p = val * (1 - sat);
			q = val * (1 - (sat * f));
			t = val * (1 - (sat * (1 - f)));
			if (i == 0)
			{
				red = val;
				green = t;
				blue = p;
			}
			else if (i == 1)
			{
				red = q;
				green = val;
				blue = p;
			}
			else if (i == 2)
			{
				red = p;
				green = val;
				blue = t;
			}
			else if (i == 3)
			{
				red = p;
				green = q;
				blue = val;
			}
			else if (i == 4)
			{
				red = t;
				green = p;
				blue = val;
			}
			else if (i == 5)
			{
				red = val;
				green = p;
				blue = q;
			}
			red = int(red * 255);
			green = int(green * 255);
			blue = int(blue * 255);
			//return RGBToHex(red, green, blue);
			return new RGB(red, green, blue);
		}

		public static function RGBtoHSV(r:Number, g:Number, b:Number):HSV
		{
			r /= 255;
			g /= 255;
			b /= 255;
			var h:Number = 0, s:Number = 0, v:Number = 0;
			var x:Number, y:Number;
			if (r >= g)
				x = r;
			else
				x = g;
			if (b > x)
				x = b;
			if (r <= g)
				y = r;
			else
				y = g;
			if (b < y)
				y = b;
			v = x;
			var c:Number = x - y;
			if (x == 0)
				s = 0;
			else
				s = c / x;
			if (s != 0)
			{
				if (r == x)
				{
					h = (g - b) / c;
				}
				else
				{
					if (g == x)
					{
						h = 2 + (b - r) / c;
					}
					else
					{
						if (b == x)
						{
							h = 4 + (r - g) / c;
						}
					}
				}
				h = h * 60;
				if (h < 0)
					h = h + 360;
			}
			return new HSV(h, s * 100, v * 100);
		}

		public static function ARGBToRGB(c:uint):uint
		{
			var a:uint = MGColorUtil.extractAlpha(c);
			var r:uint = MGColorUtil.extractRed(c);
			var g:uint = MGColorUtil.extractGreen(c);
			var b:uint = MGColorUtil.extractBlue(c);
			return combineRGB(r, g, b);
		}

		/**
		 *
		 * @param rgb
		 * @param newAlpha, has to be in the 0 to 255 range
		 * @return ARGB uint
		 *
		 */
		public static function RGBToARGB(rgb:uint, newAlpha:uint):uint
		{
			var argb:uint = 0;
			argb += (newAlpha << 24);
			argb += (rgb);
			return argb;
		}

		public static function extractAlpha(c:uint):uint
		{
			return ((c >> 24) & 0xFF);
		}

		public static function extractRed(c:uint):uint
		{
			return ((c >> 16) & 0xFF);
		}

		public static function extractGreen(c:uint):uint
		{
			return ((c >> 8) & 0xFF);
		}

		public static function extractBlue(c:uint):uint
		{
			return (c & 0xFF);
		}

		public static function combineRGB(r:uint, g:uint, b:uint):uint
		{
			return ((r << 16) | (g << 8) | b);
		}

		public static function combineARGB(a:uint, r:uint, g:uint, b:uint):uint
		{
			return ((a << 24) | (r << 16) | (g << 8) | b);
		}

		public static function hex2rgb(color:uint):Object
		{
			var c:Object = {};
			c.r = color >> 16 & 0xFF;
			c.g = color >> 8 & 0xFF;
			c.b = color & 0xFF;
			return c;
		}

		/**
		 *
		 * @param c (0xFF0000), returns FF0000
		 * @return
		 *
		 */
		public static function hex2css(c:int):String
		{
			var r:String = convertChannelToHexStr(MGColorUtil.extractRed(c));
			var g:String = convertChannelToHexStr(MGColorUtil.extractGreen(c));
			var b:String = convertChannelToHexStr(MGColorUtil.extractBlue(c));
			return r + g + b;
		}

		public static function hex2cssAlpha(c:int):String
		{
			var a:String = convertChannelToHexStr(MGColorUtil.extractAlpha(c));
			var r:String = convertChannelToHexStr(MGColorUtil.extractRed(c));
			var g:String = convertChannelToHexStr(MGColorUtil.extractGreen(c));
			var b:String = convertChannelToHexStr(MGColorUtil.extractBlue(c));
			return a + r + g + b;
		}

		private static function convertChannelToHexStr(hex:uint):String
		{
			if (hex > 255)
			{
				hex = 255;
					//trace("hex val overloaded");
			}
			var hexStr:String = hex.toString(16);
			if (hexStr.length < 2)
			{
				//trace("hex small");
				hexStr = "0" + hexStr;
			}
			return hexStr;
		}

		public static function HEXDodge(topColour:uint, bottomColour:uint):uint
		{
			var aRGB:Array = HexToRGB(bottomColour);
			var bRGB:Array = HexToRGB(topColour);
			var blendResult:Array = [];
			if (aRGB[0] == 0)
			{
				blendResult[0] = 0;
			}
			else if (aRGB[0] >= (255 - bRGB[0]))
			{
				blendResult[0] = 255;
			}
			else
			{
				blendResult[0] = aRGB[0] / (255 - bRGB[0]) * 255;
			}
			if (aRGB[1] == 0)
			{
				blendResult[1] = 255;
			}
			else if (aRGB[1] >= (255 - bRGB[1]))
			{
				blendResult[1] = 255;
			}
			else
			{
				blendResult[1] = aRGB[1] / (255 - bRGB[1]) * 255;
			}
			if (aRGB[2] == 0)
			{
				blendResult[2] = 0
			}
			else if (aRGB[2] >= (255 - bRGB[2]))
			{
				blendResult[2] = 255;
			}
			else
			{
				blendResult[2] = aRGB[2] / (255 - bRGB[2]) * 255;
			}
			return RGBToHex(blendResult[0], blendResult[1], blendResult[2]);
		}

		public static function HexToRGB(hex:uint):Array
		{
			var r:uint = hex >> 16 & 0xFF;
			var g:uint = hex >> 8 & 0xFF;
			var b:uint = hex & 0xFF;
			return [ r, g, b ];
		}

		public static function RGBToHex(r:uint, g:uint, b:uint):uint
		{
			return (r << 16 | g << 8 | b);
		}

		public static function interpolateARGBColor(fromColor:uint, toColor:uint, progress:Number):uint
		{
			var q:Number = 1 - progress;
			var fromA:uint = (fromColor >> 24) & 0xFF;
			var fromR:uint = (fromColor >> 16) & 0xFF;
			var fromG:uint = (fromColor >> 8) & 0xFF;
			var fromB:uint = fromColor & 0xFF;
			var toA:uint = (toColor >> 24) & 0xFF;
			var toR:uint = (toColor >> 16) & 0xFF;
			var toG:uint = (toColor >> 8) & 0xFF;
			var toB:uint = toColor & 0xFF;
			var resultA:uint = fromA * q + toA * progress;
			var resultR:uint = fromR * q + toR * progress;
			var resultG:uint = fromG * q + toG * progress;
			var resultB:uint = fromB * q + toB * progress;
			var resultColor:uint = resultA << 24 | resultR << 16 | resultG << 8 | resultB;
			return resultColor;
		}

		public static function interpolateRGBColor(fromColor:uint, toColor:uint, progress:Number):uint
		{
			var q:Number = 1 - progress;
			var fromR:uint = (fromColor >> 16) & 0xFF;
			var fromG:uint = (fromColor >> 8) & 0xFF;
			var fromB:uint = fromColor & 0xFF;
			var toR:uint = (toColor >> 16) & 0xFF;
			var toG:uint = (toColor >> 8) & 0xFF;
			var toB:uint = toColor & 0xFF;
			var resultR:uint = fromR * q + toR * progress;
			var resultG:uint = fromG * q + toG * progress;
			var resultB:uint = fromB * q + toB * progress;
			var resultColor:uint = resultR << 16 | resultG << 8 | resultB;
			return resultColor;
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
