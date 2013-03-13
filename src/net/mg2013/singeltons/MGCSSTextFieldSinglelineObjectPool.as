package net.mg2013.singeltons
{
    import flash.text.StyleSheet;
    import flash.text.TextFieldAutoSize;
    
    import net.mg2013.display.MGCSSTextFieldSingleline;

    public class MGCSSTextFieldSinglelineObjectPool
    {
        public static var instance:MGCSSTextFieldSinglelineObjectPool;

        //////////////
        ////////////// CONSTRUCTOR ------------------------------------------------------------------------------------------- CONSTRUCTOR //////////////////////
        //////////////
        private var __textFields:Vector.<MGCSSTextFieldSingleline> = new Vector.<MGCSSTextFieldSingleline>();

        private var __used:Vector.<int> = new Vector.<int>();

        private var __size:int;

        private var __currentIndex:int = 0;

        private var __css:StyleSheet;

        private var __initialized:Boolean = false;

        public function MGCSSTextFieldSinglelineObjectPool(enforcer:SingletonEnforcer)
        {
            if (!enforcer)
                throw new Error("Class is singleton, use getInstance");
        }

        //////////////
        ////////////// PUBLIC ------------------------------------------------------------------------------------------------ PUBLIC ///////////////////////////
        //////////////
        public function initialize(size:int, css:StyleSheet):void
        {
            __size = size;
            __css = css;
            initPool();
            __initialized = true;
        }

        public function getObject(_width:Number, _height:Number, _text:String = "", _autoSizeLeft:Boolean = true, _mouseEnabled:Boolean = false, _selectable:Boolean = false, _wordWrap:Boolean = false, _id:String = null):MGCSSTextFieldSingleline
        {
            if (!__initialized)
                throw new Error("initialize the " + this + " first");
            var index:int = __used.indexOf(0);
            var field:MGCSSTextFieldSingleline;
            if (index >= 0)
            {
                field = __textFields[index];
                __used[index] = 1;
                __currentIndex = index;
            }
            else
            {
                field = new MGCSSTextFieldSingleline(__css, 0, 0);
                __textFields.push(field);
                __used.push(1);
                __currentIndex = __used.length - 1;
            }
            field.width = _width;
            field.height = _height;
            field.mouseEnabled = _mouseEnabled;
            field.selectable = _selectable;
            field.wordWrap = _wordWrap;
            field.id = _id;
            field.background = false;
            if (_autoSizeLeft)
                field.autoSize = TextFieldAutoSize.LEFT;
            field.htmlText = _text;
            return field;
        }

        public function returnObject(field:MGCSSTextFieldSingleline):void
        {
            var index:int = __textFields.indexOf(field);
            if (index == -1)
                return;
            __used[index] = 0;
        }

        public static function getInstance():MGCSSTextFieldSinglelineObjectPool
        {
            if (instance == null)
                instance = new MGCSSTextFieldSinglelineObjectPool(new SingletonEnforcer());
            return instance;
        }

        //////////////
        ////////////// OVERRIDE PUBLIC --------------------------------------------------------------------------------------- OVERRIDE PUBLIC //////////////////
        //////////////
        //////////////
        ////////////// PROTECTED --------------------------------------------------------------------------------------------- PROTECTED ////////////////////////
        //////////////
        protected function initPool():void
        {
            var n:int = __size;
            for (var i:int = 0; i < n; i++)
            {
                var field:MGCSSTextFieldSingleline = new MGCSSTextFieldSingleline(__css, 0, 0);
                __textFields.push(field);
                __used.push(0);
            }
        }
        //////////////
        ////////////// OVERRIDE PROTECTED ------------------------------------------------------------------------------------ OVERRIDE PROTECTED ///////////////
        //////////////
        //////////////
        ////////////// MOUSE EVENTS ------------------------------------------------------------------------------------------ MOUSE EVENTS /////////////////////
        //////////////
        //////////////
        ////////////// OVERRIDE MOUSE EVENTS --------------------------------------------------------------------------------- OVERRIDE MOUSE EVENTS ////////////
        //////////////
        //////////////
        ////////////// EVENTS ------------------------------------------------------------------------------------------------ EVENTS ///////////////////////////
        //////////////
        //////////////
        ////////////// OVERRIDE EVENTS --------------------------------------------------------------------------------------- OVERRIDE EVENTS //////////////////
        //////////////
        //////////////
        ////////////// GET & SET --------------------------------------------------------------------------------------------- GET & SET ////////////////////////
        //////////////
        //////////////
        ////////////// OVERRIDE GET & SET ------------------------------------------------------------------------------------ OVERRIDE GET & SET ///////////////
        //////////////
    }
}

internal class SingletonEnforcer
{
}
