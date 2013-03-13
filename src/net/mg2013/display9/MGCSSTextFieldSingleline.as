package net.mg2013.display9
{
	import flash.text.AntiAliasType;
	import flash.text.StyleSheet;
	import flash.text.TextFieldType;

	public class MGCSSTextFieldSingleline extends MGCSSTextFieldMultiline
	{
		public function MGCSSTextFieldSingleline(_css : StyleSheet, _width : Number, _height : Number, _text : String = "", _autoSizeLeft : Boolean = true, _mouseEnabled : Boolean = false, _selectable : Boolean = false, _wordWrap : Boolean = false)
		{
			super(_css, _width, _height, _text, _autoSizeLeft, _mouseEnabled, _selectable, _wordWrap);
		}

		override protected function defaults() : void
		{
			embedFonts = true
			multiline = false
			tabEnabled = false
			antiAliasType = AntiAliasType.ADVANCED
			type = TextFieldType.DYNAMIC
			condenseWhite = true
		}
	}
}