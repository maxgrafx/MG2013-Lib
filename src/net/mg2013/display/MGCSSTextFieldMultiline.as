package net.mg2013.display
{
	import net.mg2013.collection.MGTextFieldCollectionTypes;
	
	import flash.text.AntiAliasType;
	import flash.text.StyleSheet;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;

	public class MGCSSTextFieldMultiline extends MGCSSTextFieldCore
	{
		//////////-------------------------------------------------------------------------------------------------------------------------- CONSTRUCTOR
		public function MGCSSTextFieldMultiline(_css:StyleSheet, _width:Number, _height:Number, _text:String = "", _autoSizeLeft:Boolean = true, _mouseEnabled:Boolean = false, _selectable:Boolean = false, _wordWrap:Boolean = true, _id:String = null, collectionType:int = MGTextFieldCollectionTypes.SKIP_COLLECTION)
		{
			super(_id, collectionType);
			styleSheet = _css;
			width = _width;
			height = _height;
			///////
			setMouseEnabled(_mouseEnabled);
			setSelectable(_selectable);
			setWordWrap(_wordWrap);
			if (_autoSizeLeft)
			{
				setAutoSize();
			}
			defaults();
			htmlText = _text;
		}

		//////////-------------------------------------------------------------------------------------------------------------------------- PUBLIC FUNCTIONS
		//////////------------------------------------------------§-------------------------------------------------------------------------- PROTECTED FUNCTIONS
		protected function setAutoSize():void
		{
			autoSize = TextFieldAutoSize.LEFT;
		}

		protected function setWordWrap(_b:Boolean):void
		{
			wordWrap = _b;
		}

		protected function setMouseEnabled(_b:Boolean):void
		{
			mouseEnabled = _b;
		}

		protected function setSelectable(_b:Boolean):void
		{
			selectable = _b;
		}

		protected function defaults():void
		{
			embedFonts = true;
			multiline = true;
			tabEnabled = false;
			antiAliasType = AntiAliasType.ADVANCED;
			type = TextFieldType.DYNAMIC;
			condenseWhite = true;
		}
		//////////-------------------------------------------------------------------------------------------------------------------------- EVENT FUNCTIONS
		//////////-------------------------------------------------------------------------------------------------------------------------- MOUSE FUNCTIONS
		//////////-------------------------------------------------------------------------------------------------------------------------- GET & SET FUNCTIONS
	}
}