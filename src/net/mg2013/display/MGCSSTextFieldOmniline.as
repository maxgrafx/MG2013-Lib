package net.mg2013.display
{
	import net.mg2013.collection.MGTextFieldCollectionTypes;

	public class MGCSSTextFieldOmniline extends MGCSSTextFieldSingleline
	{
		////////// CONSTRUCTOR -------------------------------------------------------------------------------------------------------------------------- CONSTRUCTOR
		public function MGCSSTextFieldOmniline(_css:*, _width:Number, _height:Number, maxWidth:Number, _text:String = "", _wordWrap:Boolean = false, _autoSizeLeft:Boolean = true, _mouseEnabled:Boolean = false, _selectable:Boolean = false, _id:String = null, collectionType:int = MGTextFieldCollectionTypes.SKIP_COLLECTION)
		{
			super(_css, _width, _height, _text, _autoSizeLeft, _mouseEnabled, _selectable, _wordWrap, _id, collectionType);
			if (width > maxWidth)
			{
				width = maxWidth;
				multiline = true;
				wordWrap = true;
			}
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
