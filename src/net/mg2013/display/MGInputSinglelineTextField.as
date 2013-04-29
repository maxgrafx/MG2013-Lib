package net.mg2013.display
{
	import net.mg2013.display.textfield.MGInputTextFieldType;
	
	import flash.text.AntiAliasType;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;

	public class MGInputSinglelineTextField extends MGCSSTextFieldSingleline
	{
		private var __fieldType:String;

		//////////-------------------------------------------------------------------------------------------------------------------------- CONSTRUCTOR
		public function MGInputSinglelineTextField(_format:TextFormat, _width:Number = 0, _height:Number = 0, _text:String = "", _fieldType:String = MGInputTextFieldType.ALL, _autoSizeLeft:Boolean = true, _wordWrap:Boolean = false, _id:String = null)
		{
			super(_format, _width, _height, _text, _autoSizeLeft, true, true, _wordWrap, _id);
			__fieldType = _fieldType;
			//defaultTextFormat = _format;
			if (__fieldType != "")
				MGInputTextFieldType.setRestriction(this, __fieldType);
			text = _text;
		}

		//////////-------------------------------------------------------------------------------------------------------------------------- PUBLIC FUNCTIONS
		//////////-------------------------------------------------------------------------------------------------------------------------- PROTECTED FUNCTIONS
		override protected function defaults():void
		{
			type = TextFieldType.INPUT;
			multiline = false;
			tabEnabled = true;
			antiAliasType = AntiAliasType.ADVANCED;
			condenseWhite = true;
			embedFonts = true;
		}

		//////////-------------------------------------------------------------------------------------------------------------------------- EVENT FUNCTIONS
		//////////-------------------------------------------------------------------------------------------------------------------------- MOUSE FUNCTIONS
		//////////-------------------------------------------------------------------------------------------------------------------------- PROTECTED GET & SET FUNCTIONS
		//////////-------------------------------------------------------------------------------------------------------------------------- GET & SET FUNCTIONS
		override public function get htmlText():String
		{
			return null;
		}

		override public function set htmlText(value:String):void
		{
		}

		public function get fieldType():String
		{
			return __fieldType;
		}
	}
}
