package net.mg2013.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.PixelSnapping;
	import flash.text.StaticText;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class MGTextUtil
	{
		public static function cssToDefaultFormat(_textField:TextField, _tag:String, _css:StyleSheet):void
		{
			var text:String = _textField.text
			var newFormat:TextFormat = new TextFormat();
			var style:Object = _css.getStyle(_tag);
			newFormat = _css.transform(style);
			_textField.styleSheet = null
			_textField.defaultTextFormat = newFormat
			_textField.text = text
		}

		public static function cssToFormat(_tag:String, _css:StyleSheet):TextFormat
		{
			var newFormat:TextFormat = new TextFormat();
			var style:Object = _css.getStyle(_tag);
			newFormat = _css.transform(style);
			return newFormat
		}

		public static function bitmapStaticTextfields(displayObject:DisplayObjectContainer):void
		{
			var n:int = displayObject.numChildren
			for (var i:int = 0; i < n; i++)
			{
				var dsp:DisplayObject = displayObject.getChildAt(i)
				if (dsp is StaticText)
				{
					var bmd:BitmapData = new BitmapData(dsp.width, dsp.height, true, 0x00000000)
					bmd.draw(dsp, null, null, null, null, false)
					var bm:Bitmap = new Bitmap(bmd, PixelSnapping.AUTO, false)
					bm.x = dsp.x
					bm.y = dsp.y
					displayObject.addChild(bm)
					dsp.visible = false
				}
			}
		}

		public static function AsciiLetterCodeConverter(str:String):String
		{
			var keyEntities:Array = new Array();
			keyEntities.push("&nbsp;") // "\u00A0"; // non-breaking space
			keyEntities.push("&iexcl;") // "\u00A1"; // inverted exclamation mark
			keyEntities.push("&cent;") // "\u00A2"; // cent sign
			keyEntities.push("&pound;") // "\u00A3"; // pound sign
			keyEntities.push("&curren;") // "\u00A4"; // currency sign
			keyEntities.push("&yen;") // "\u00A5"; // yen sign
			keyEntities.push("&brvbar;") // "\u00A6"; // broken vertical bar (|)
			keyEntities.push("&sect;") // "\u00A7"; // section sign
			keyEntities.push("&uml;") // "\u00A8"; // diaeresis
			keyEntities.push("&copy;") // "\u00A9"; // copyright sign
			keyEntities.push("&reg;") // "\u00AE"; // registered sign
			keyEntities.push("&deg;") // "\u00B0"; // degree sign
			keyEntities.push("&plusmn;") // "\u00B1"; // plus-minus sign
			// remove spaces from next three lines in actual code
			keyEntities.push("&sup1;") // "\u00B9"; // superscript one
			keyEntities.push("&sup2;") // "\u00B2"; // superscript two
			keyEntities.push("&sup3;") // "\u00B3"; // superscript three
			keyEntities.push("&acute;") // "\u00B4"; // acute accent
			keyEntities.push("&micro;") // "\u00B5"; // micro sign
			// remove spaces from next three lines in actual code
			keyEntities.push("&frac14;") // "\u00BC"; // vulgar fraction one quarter
			keyEntities.push("&frac12;") // "\u00BD"; // vulgar fraction one half
			keyEntities.push("&frac34;") // "\u00BE"; // vulgar fraction three quarters
			keyEntities.push("&iquest;") // "\u00BF"; // inverted question mark
			keyEntities.push("&Agrave;") // "\u00C0"; // Latin capital letter A with grave
			keyEntities.push("&Aacute;") // "\u00C1"; // Latin capital letter A with acute
			keyEntities.push("&Acirc;") // "\u00C2"; // Latin capital letter A with circumflex
			keyEntities.push("&Atilde;") // "\u00C3"; // Latin capital letter A with tilde
			keyEntities.push("&Auml;") // "\u00C4"; // Latin capital letter A with diaeresis
			keyEntities.push("&Aring;") // "\u00C5"; // Latin capital letter A with ring above
			keyEntities.push("&AElig;") // "\u00C6"; // Latin capital letter AE
			keyEntities.push("&Ccedil;") // "\u00C7"; // Latin capital letter C with cedilla
			keyEntities.push("&Egrave;") // "\u00C8"; // Latin capital letter E with grave
			keyEntities.push("&Eacute;") // "\u00C9"; // Latin capital letter E with acute
			keyEntities.push("&Ecirc;") // "\u00CA"; // Latin capital letter E with circumflex
			keyEntities.push("&Euml;") // "\u00CB"; // Latin capital letter E with diaeresis
			keyEntities.push("&Igrave;") // "\u00CC"; // Latin capital letter I with grave
			keyEntities.push("&Iacute;") // "\u00CD"; // Latin capital letter I with acute
			keyEntities.push("&Icirc;") // "\u00CE"; // Latin capital letter I with circumflex
			keyEntities.push("&Iuml;") // "\u00CF"; // Latin capital letter I with diaeresis
			keyEntities.push("&ETH;") // "\u00D0"; // Latin capital letter ETH
			keyEntities.push("&Ntilde;") // "\u00D1"; // Latin capital letter N with tilde
			keyEntities.push("&Ograve;") // "\u00D2"; // Latin capital letter O with grave
			keyEntities.push("&Oacute;") // "\u00D3"; // Latin capital letter O with acute
			keyEntities.push("&Ocirc;") // "\u00D4"; // Latin capital letter O with circumflex
			keyEntities.push("&Otilde;") // "\u00D5"; // Latin capital letter O with tilde
			keyEntities.push("&Ouml;") // "\u00D6"; // Latin capital letter O with diaeresis
			keyEntities.push("&Oslash;") // "\u00D8"; // Latin capital letter O with stroke
			keyEntities.push("&Ugrave;") // "\u00D9"; // Latin capital letter U with grave
			keyEntities.push("&Uacute;") // "\u00DA"; // Latin capital letter U with acute
			keyEntities.push("&Ucirc;") // "\u00DB"; // Latin capital letter U with circumflex
			keyEntities.push("&Uuml;") // "\u00DC"; // Latin capital letter U with diaeresis
			keyEntities.push("&Yacute;") // "\u00DD"; // Latin capital letter Y with acute
			keyEntities.push("&THORN;") // "\u00DE"; // Latin capital letter THORN
			keyEntities.push("&szlig;") // "\u00DF"; // Latin small letter sharp s = ess-zed
			keyEntities.push("&agrave;") // "\u00E0"; // Latin small letter a with grave
			keyEntities.push("&aacute;") // "\u00E1"; // Latin small letter a with acute
			keyEntities.push("&acirc;") // "\u00E2"; // Latin small letter a with circumflex
			keyEntities.push("&atilde;") // "\u00E3"; // Latin small letter a with tilde
			keyEntities.push("&auml;") // "\u00E4"; // Latin small letter a with diaeresis
			keyEntities.push("&aring;") // "\u00E5"; // Latin small letter a with ring above
			keyEntities.push("&aelig;") // "\u00E6"; // Latin small letter ae
			keyEntities.push("&ccedil;") // "\u00E7"; // Latin small letter c with cedilla
			keyEntities.push("&egrave;") // "\u00E8"; // Latin small letter e with grave
			keyEntities.push("&eacute;") // "\u00E9"; // Latin small letter e with acute
			keyEntities.push("&ecirc;") // "\u00EA"; // Latin small letter e with circumflex
			keyEntities.push("&euml;") // "\u00EB"; // Latin small letter e with diaeresis
			keyEntities.push("&igrave;") // "\u00EC"; // Latin small letter i with grave
			keyEntities.push("&iacute;") // "\u00ED"; // Latin small letter i with acute
			keyEntities.push("&icirc;") // "\u00EE"; // Latin small letter i with circumflex
			keyEntities.push("&iuml;") // "\u00EF"; // Latin small letter i with diaeresis
			keyEntities.push("&eth;") // "\u00F0"; // Latin small letter eth
			keyEntities.push("&ntilde;") // "\u00F1"; // Latin small letter n with tilde
			keyEntities.push("&ograve;") // "\u00F2"; // Latin small letter o with grave
			keyEntities.push("&oacute;") // "\u00F3"; // Latin small letter o with acute
			keyEntities.push("&ocirc;") // "\u00F4"; // Latin small letter o with circumflex
			keyEntities.push("&otilde;") // "\u00F5"; // Latin small letter o with tilde
			keyEntities.push("&ouml;") // "\u00F6"; // Latin small letter o with diaeresis
			keyEntities.push("&oslash;") // "\u00F8"; // Latin small letter o with stroke
			keyEntities.push("&ugrave;") // "\u00F9"; // Latin small letter u with grave
			keyEntities.push("&uacute;") // "\u00FA"; // Latin small letter u with acute
			keyEntities.push("&ucirc;") // "\u00FB"; // Latin small letter u with circumflex
			keyEntities.push("&uuml;") // "\u00FC"; // Latin small letter u with diaeresis
			keyEntities.push("&yacute;") // "\u00FD"; // Latin small letter y with acute
			keyEntities.push("&thorn;") // "\u00FE"; // Latin small letter thorn
			keyEntities.push("&yuml;") // "\u00FF"; // Latin small letter y with diaeresis
			var aryEntities:Array = new Array();
			aryEntities.push("\u00A0") // "\u00A0"; // non-breaking space
			aryEntities.push("\u00A1") // "\u00A1"; // inverted exclamation mark
			aryEntities.push("\u00A2") // "\u00A2"; // cent sign
			aryEntities.push("\u00A3") // "\u00A3"; // pound sign
			aryEntities.push("\u00A4") // "\u00A4"; // currency sign
			aryEntities.push("\u00A5") // "\u00A5"; // yen sign
			aryEntities.push("\u00A6") // "\u00A6"; // broken vertical bar (|)
			aryEntities.push("\u00A7") // "\u00A7"; // section sign
			aryEntities.push("\u00A8") // "\u00A8"; // diaeresis
			aryEntities.push("\u00A9") // "\u00A9"; // copyright sign
			aryEntities.push("\u00AE") // "\u00AE"; // registered sign
			aryEntities.push("\u00B0") // "\u00B0"; // degree sign
			aryEntities.push("\u00B1") // "\u00B1"; // plus-minus sign
			// remove spaces from next three lines in actual code
			aryEntities.push("\u00B9") // "\u00B9"; // superscript one
			aryEntities.push("\u00B2") // "\u00B2"; // superscript two
			aryEntities.push("\u00B3") // "\u00B3"; // superscript three
			aryEntities.push("\u00B4") // "\u00B4"; // acute accent
			aryEntities.push("\u00B5") // "\u00B5"; // micro sign
			// remove spaces from next three lines in actual code
			aryEntities.push("\u00BC") // "\u00BC"; // vulgar fraction one quarter
			aryEntities.push("\u00BD") // "\u00BD"; // vulgar fraction one half
			aryEntities.push("\u00BE") // "\u00BE"; // vulgar fraction three quarters
			aryEntities.push("\u00BF") // "\u00BF"; // inverted question mark
			aryEntities.push("\u00C0") // "\u00C0"; // Latin capital letter A with grave
			aryEntities.push("\u00C1") // "\u00C1"; // Latin capital letter A with acute
			aryEntities.push("\u00C2") // "\u00C2"; // Latin capital letter A with circumflex
			aryEntities.push("\u00C3") // "\u00C3"; // Latin capital letter A with tilde
			aryEntities.push("\u00C4") // "\u00C4"; // Latin capital letter A with diaeresis
			aryEntities.push("\u00C5") // "\u00C5"; // Latin capital letter A with ring above
			aryEntities.push("\u00C6") // "\u00C6"; // Latin capital letter AE
			aryEntities.push("\u00C7") // "\u00C7"; // Latin capital letter C with cedilla
			aryEntities.push("\u00C8") // "\u00C8"; // Latin capital letter E with grave
			aryEntities.push("\u00C9") // "\u00C9"; // Latin capital letter E with acute
			aryEntities.push("\u00CA") // "\u00CA"; // Latin capital letter E with circumflex
			aryEntities.push("\u00CB") // "\u00CB"; // Latin capital letter E with diaeresis
			aryEntities.push("\u00CC") // "\u00CC"; // Latin capital letter I with grave
			aryEntities.push("\u00CD") // "\u00CD"; // Latin capital letter I with acute
			aryEntities.push("\u00CE") // "\u00CE"; // Latin capital letter I with circumflex
			aryEntities.push("\u00CF") // "\u00CF"; // Latin capital letter I with diaeresis
			aryEntities.push("\u00D0") // "\u00D0"; // Latin capital letter ETH
			aryEntities.push("\u00D1") // "\u00D1"; // Latin capital letter N with tilde
			aryEntities.push("\u00D2") // "\u00D2"; // Latin capital letter O with grave
			aryEntities.push("\u00D3") // "\u00D3"; // Latin capital letter O with acute
			aryEntities.push("\u00D4") // "\u00D4"; // Latin capital letter O with circumflex
			aryEntities.push("\u00D5") // "\u00D5"; // Latin capital letter O with tilde
			aryEntities.push("\u00D6") // "\u00D6"; // Latin capital letter O with diaeresis
			aryEntities.push("\u00D8") // "\u00D8"; // Latin capital letter O with stroke
			aryEntities.push("\u00D9") // "\u00D9"; // Latin capital letter U with grave
			aryEntities.push("\u00DA") // "\u00DA"; // Latin capital letter U with acute
			aryEntities.push("\u00DB") // "\u00DB"; // Latin capital letter U with circumflex
			aryEntities.push("\u00DC") // "\u00DC"; // Latin capital letter U with diaeresis
			aryEntities.push("\u00DD") // "\u00DD"; // Latin capital letter Y with acute
			aryEntities.push("\u00DE") // "\u00DE"; // Latin capital letter THORN
			aryEntities.push("\u00DF") // "\u00DF"; // Latin small letter sharp s = ess-zed
			aryEntities.push("\u00E0") // "\u00E0"; // Latin small letter a with grave
			aryEntities.push("\u00E1") // "\u00E1"; // Latin small letter a with acute
			aryEntities.push("\u00E2") // "\u00E2"; // Latin small letter a with circumflex
			aryEntities.push("\u00E3") // "\u00E3"; // Latin small letter a with tilde
			aryEntities.push("\u00E4") // "\u00E4"; // Latin small letter a with diaeresis
			aryEntities.push("\u00E5") // "\u00E5"; // Latin small letter a with ring above
			aryEntities.push("\u00E6") // "\u00E6"; // Latin small letter ae
			aryEntities.push("\u00E7") // "\u00E7"; // Latin small letter c with cedilla
			aryEntities.push("\u00E8") // "\u00E8"; // Latin small letter e with grave
			aryEntities.push("\u00E9") // "\u00E9"; // Latin small letter e with acute
			aryEntities.push("\u00EA") // "\u00EA"; // Latin small letter e with circumflex
			aryEntities.push("\u00EB") // "\u00EB"; // Latin small letter e with diaeresis
			aryEntities.push("\u00EC") // "\u00EC"; // Latin small letter i with grave
			aryEntities.push("\u00ED") // "\u00ED"; // Latin small letter i with acute
			aryEntities.push("\u00EE") // "\u00EE"; // Latin small letter i with circumflex
			aryEntities.push("\u00EF") // "\u00EF"; // Latin small letter i with diaeresis
			aryEntities.push("\u00F0") // "\u00F0"; // Latin small letter eth
			aryEntities.push("\u00F1") // "\u00F1"; // Latin small letter n with tilde
			aryEntities.push("\u00F2") // "\u00F2"; // Latin small letter o with grave
			aryEntities.push("\u00F3") // "\u00F3"; // Latin small letter o with acute
			aryEntities.push("\u00F4") // "\u00F4"; // Latin small letter o with circumflex
			aryEntities.push("\u00F5") // "\u00F5"; // Latin small letter o with tilde
			aryEntities.push("\u00F6") // "\u00F6"; // Latin small letter o with diaeresis
			aryEntities.push("\u00F8") // "\u00F8"; // Latin small letter o with stroke
			aryEntities.push("\u00F9") // "\u00F9"; // Latin small letter u with grave
			aryEntities.push("\u00FA") // "\u00FA"; // Latin small letter u with acute
			aryEntities.push("\u00FB") // "\u00FB"; // Latin small letter u with circumflex
			aryEntities.push("\u00FC") // "\u00FC"; // Latin small letter u with diaeresis
			aryEntities.push("\u00FD") // "\u00FD"; // Latin small letter y with acute
			aryEntities.push("\u00FE") // "\u00FE"; // Latin small letter thorn
			aryEntities.push("\u00FF") // "\u00FF"; // Latin small letter y with diaeresis
			//trace(str.length)
			//trace("test: " + str.indexOf("&nbsp;"))
			var s:int = str.indexOf('&')
			while (s != -1)
			{
				//trace(s)
				var n:int = keyEntities.length
				for (var i:int = 0; i < n; i++)
				{
					//trace("entity test: " + keyEntities[i])
					if (str.indexOf(keyEntities[i]) != -1)
					{
						//trace("entity found: " + keyEntities[i])
						str = str.split(keyEntities[i]).join(aryEntities[i]);
					}
				}
				var prev:int = s
				s = str.indexOf('&', s)
				if (prev == s)
					return str;
			}
			return str
		}
	}
}
