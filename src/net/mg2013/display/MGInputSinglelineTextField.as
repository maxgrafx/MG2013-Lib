package net.mg2013.display
{
	import com.adobe.utils.StringUtil;
	import flash.events.FocusEvent;
	import flash.text.AntiAliasType;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import net.mg2013.display.textfield.MGInputTextFieldType;

	public class MGInputSinglelineTextField extends MGCSSTextFieldSingleline
	{
		private var __fieldType:String;

		//////////-------------------------------------------------------------------------------------------------------------------------- CONSTRUCTOR
		private var __message:String;

		public function MGInputSinglelineTextField(_format:TextFormat, _width:Number = 0, _height:Number = 0, _text:String = "", _message:String = "", _fieldType:String = MGInputTextFieldType.ALL, _autoSizeLeft:Boolean = true, _wordWrap:Boolean = false, _id:String = null)
		{
			super(_format, _width, _height, _text, _autoSizeLeft, true, true, _wordWrap, _id);
			__fieldType = _fieldType;
			__message = _message;
			if (__fieldType != "")
				MGInputTextFieldType.setRestriction(this, __fieldType);
			text = _text != "" ? _text : __message != "" ? __message : "";
			if (__message != "")
			{
				addEventListener(FocusEvent.FOCUS_IN, focusEvent, false, 0, true);
				addEventListener(FocusEvent.FOCUS_OUT, focusEvent, false, 0, true);
			}
		}
		public function resetInput():void
		{
			text = __message;
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
		protected function focusEvent(event:FocusEvent):void
		{
			switch (event.type)
			{
				case FocusEvent.FOCUS_IN:
					if (StringUtil.trim(text) == __message)
						text = "";
					break;
				case FocusEvent.FOCUS_OUT:
					if (StringUtil.trim(text) == "")
						text = __message;
					break;
			}
		}

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
