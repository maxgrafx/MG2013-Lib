package net.mg2013.utils
{
	import net.mg2013.vo.HSV;

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
			//var hsvColor:HSV = new HSV();
			var rgb:Array = [ 0, 0, 0 ];
			var hexColor:String = color.toString(16);
			if (hexColor.length == 1)
			{
				hexColor = "000000";
			}
			else if (hexColor.length == 4)
			{
				hexColor = "00" + hexColor;
			}
			rgb[0] = parseInt(hexColor.substr(0, 2), 16) / 255;
			rgb[1] = parseInt(hexColor.substr(2, 2), 16) / 255;
			rgb[2] = parseInt(hexColor.substr(4, 2), 16) / 255;
			var x:Number, f:Number, i:Number, hue:Number, sat:Number, val:Number;
			x = Math.min(Math.min(rgb[0], rgb[1]), rgb[2]);
			val = Math.max(Math.max(rgb[0], rgb[1]), rgb[2]);
			if (x == val)
				return new HSV(0, 0, 100);
			f = (rgb[0] == x) ? rgb[1] - rgb[2] : ((rgb[1] == x) ? rgb[2] - rgb[0] : rgb[0] - rgb[1]);
			i = (rgb[0] == x) ? 3 : ((rgb[1] == x) ? 5 : 1);
			hue = int((i - f / (val - x)) * 60) % 360;
			sat = int(((val - x) / val) * 100);
			val = int(val * 100);
			return new HSV(hue, sat, val);
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
			return HSV2RGB(hsvColor.hue, 100, 100);
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
		public static function HSV2RGB(hue:Number, sat:Number, val:Number):uint
		{
			var red:Number, green:Number, blue:Number, i:Number, f:Number, p:Number, q:Number, t:Number;
			hue %= 360;
			if (val == 0)
			{
				return 0;
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
			return RGBToHex(red, green, blue);
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
