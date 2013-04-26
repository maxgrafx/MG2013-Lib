package net.mg2013.display
{
	import flash.text.AntiAliasType;
	import flash.text.TextFieldType;
	
	import net.mg2013.collection.MGTextFieldCollectionTypes;

	public class MGCSSTextFieldSingleline extends MGCSSTextFieldMultiline
	{
		public function MGCSSTextFieldSingleline(_css:*, _width:Number, _height:Number, _text:String = "", _autoSizeLeft:Boolean = true, _mouseEnabled:Boolean = false, _selectable:Boolean = false, _wordWrap:Boolean = false, _id:String = null, collectionType:int = MGTextFieldCollectionTypes.SKIP_COLLECTION)
		{
			super(_css, _width, _height, _text, _autoSizeLeft, _mouseEnabled, _selectable, _wordWrap, _id, collectionType);
		}

		override protected function defaults():void
		{
			embedFonts = true;
			multiline = false;
			tabEnabled = false;
			antiAliasType = AntiAliasType.ADVANCED;
			type = TextFieldType.DYNAMIC;
			condenseWhite = true;
		}
	}
}