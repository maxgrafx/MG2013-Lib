package net.mg2013.display
{
    import flash.text.AntiAliasType;
    import flash.text.StyleSheet;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFieldType;
    import flash.text.TextFormat;
    import net.mg2013.collection.MGTextFieldCollectionTypes;

    public class MGCSSTextFieldMultiline extends MGCSSTextFieldCore
    {
        //////////-------------------------------------------------------------------------------------------------------------------------- CONSTRUCTOR
        public function MGCSSTextFieldMultiline(_css:*, _width:Number, _height:Number, _text:String = "", _autoSizeLeft:Boolean = true, _mouseEnabled:Boolean = false, _selectable:Boolean = false, _wordWrap:Boolean = true, _id:String = null, collectionType:int = MGTextFieldCollectionTypes.SKIP_COLLECTION)
        {
            super(_id, collectionType);
            if (_css is StyleSheet)
                styleSheet = _css as StyleSheet;
            else if (_css is TextFormat)
            {
                defaultTextFormat = _css as TextFormat;
                setTextFormat(_css as TextFormat);
            }else
				throw new Error("the css var should be flash.text.StyleSheet or flash.text.TextFormat!");
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
            if (_css is TextFormat)
                text = _text;
            else
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
