package net.mg2013.utils
{
	import flash.text.Font;

	public class MGFontUtil
	{
		public static function embeddedFonts():void
		{
			var fa:Array = Font.enumerateFonts(false)
			for (var i:int = 0; i < fa.length; i++)
			{
				trace(fa[i].fontName)
			}
		}
	}
}
