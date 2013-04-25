package net.mg2013.singeltons
{
    import flash.text.StyleSheet;
    import flash.text.TextFormat;

    public class CSSUtil
    {
        private var __css:StyleSheet = new StyleSheet()

        public static var instance:CSSUtil;

        //////////-------------------------------------------------------------------------------------------------------------------------- CONSTRUCTOR
        public function CSSUtil(pvt:SingletonEnforcer)
        {
            if (!pvt)
                throw new Error("Class is singleton, use getInstance");
        }

        //////////-------------------------------------------------------------------------------------------------------------------------- PUBLIC FUNCTIONS
        public function addStyleSheet(styleSheet:StyleSheet):void
        {
            __css = styleSheet
        }

        public function getTextFormat(tag:String):TextFormat
        {
            var newFormat:TextFormat = new TextFormat();
            var style:Object = __css.getStyle(tag);
            newFormat = __css.transform(style);
            return newFormat;
        }

        public function formatPClass(str:String, className:String):String
        {
            return "<p class='" + className + "'>" + str + "</p>"
        }

        //////////-------------------------------------------------------------------------------------------------------------------------- PUBLIC STATIC FUNCTIONS
        public static function getInstance():CSSUtil
        {
            if (instance == null)
                instance = new CSSUtil(new SingletonEnforcer());
            return instance;
        }

        //////////-------------------------------------------------------------------------------------------------------------------------- OVERRIDE PUBLIC FUNCTIONS
        //////////-------------------------------------------------------------------------------------------------------------------------- PROTECTED FUNCTIONS
        //////////-------------------------------------------------------------------------------------------------------------------------- OVERRIDE PROTECTED FUNCTIONS
        //////////-------------------------------------------------------------------------------------------------------------------------- EVENT FUNCTIONS
        //////////-------------------------------------------------------------------------------------------------------------------------- OVERRIDE EVENT FUNCTIONS
        //////////-------------------------------------------------------------------------------------------------------------------------- MOUSE FUNCTIONS
        //////////-------------------------------------------------------------------------------------------------------------------------- OVERRIDE MOUSE FUNCTIONS
        //////////-------------------------------------------------------------------------------------------------------------------------- PROTECTED GET & SET FUNCTIONS
        //////////-------------------------------------------------------------------------------------------------------------------------- PUBLIC GET & SET FUNCTIONS
        public function get css():StyleSheet
        {
            return __css;
        }
    }
}

internal class SingletonEnforcer
{
}
