package net.mg2013.utils
{

	public class HTMLHexCodes
	{
		public static const HEX_CODES:Array = [[ "%C0", "À" ], [ "%C1", "Á" ], [ "%C2", "Â" ], [ "%C3", "Ã" ], [ "%C4", "Ä" ], [ "%C5", "Å" ], [ "%C6", "Æ" ], [ "%C7", "Ç" ], [ "%C8", "È" ], [ "%C9", "É" ], [ "%CA", "Ê" ], [ "%CB", "Ë" ], [ "%CC", "Ì" ], [ "%CD", "Í" ], [ "%CE", "Î" ], [ "%CF", "Ï" ], [ "%D0", "Ð" ], [ "%D1", "Ñ" ], [ "%D2", "Ò" ], [ "%D3", "Ó" ], [ "%D4", "Ô" ], [ "%D5", "Õ" ], [ "%D6", "Ö" ], [ "%D7", "×" ], [ "%D8", "Ø" ], [ "%D9", "Ù" ], [ "%DA", "Ú" ], [ "%DB", "Û" ], [ "%DC", "Ü" ], [ "%DD", "Ý" ], [ "%DE", "Þ" ], [ "%DF", "ß" ], [ "%E0", "à" ], [ "%E1", "á" ], [ "%E2", "â" ], [ "%E3", "ã" ], [ "%E4", "ä" ], [ "%E5", "å" ], [ "%E6", "æ" ], [ "%E7", "ç" ], [ "%E8", "è" ], [ "%E9", "é" ], [ "%EA", "ê" ], [ "%EB", "ë" ], [ "%EC", "ì" ], [ "%ED", "í" ], [ "%EE", "î" ], [ "%EF", "ï" ], [ "%F0", "ð" ], [ "%F1", "ñ" ], [ "%F2", "ò" ], [ "%F3", "ó" ], [ "%F4", "ô" ], [ "%F5", "õ" ], [ "%F6", "ö" ], [ "%F7", "÷" ], [ "%F8", "ø" ], [ "%F9", "ù" ], [ "%FA", "ú" ], [ "%FB", "û" ], [ "%FC", "ü" ], [ "%FD", "ý" ], [ "%FE", "þ" ], [ "%FF", "ÿ" ]]

		//////////-------------------------------------------------------------------------------------------------------------------------- CONSTRUCTOR
		public static function replaceHexCodes(value:String):String
		{
			var n:int = HEX_CODES.length
			for (var i:int = 0; i < n; i++)
			{
				value = value.split(HEX_CODES[i][0]).join(HEX_CODES[i][1])
			}
			return value
		}
		//////////-------------------------------------------------------------------------------------------------------------------------- PUBLIC FUNCTIONS
		//////////-------------------------------------------------------------------------------------------------------------------------- PROTECTED FUNCTIONS
		//////////-------------------------------------------------------------------------------------------------------------------------- EVENT FUNCTIONS
		//////////-------------------------------------------------------------------------------------------------------------------------- MOUSE FUNCTIONS
		//////////-------------------------------------------------------------------------------------------------------------------------- PROTECTED GET & SET FUNCTIONS
		//////////-------------------------------------------------------------------------------------------------------------------------- GET & SET FUNCTIONS
	}
}