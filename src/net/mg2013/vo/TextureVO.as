package net.mg2013.vo
{
    import flash.geom.Rectangle;

    public class TextureVO
    {
        //////////////
        ////////////// CONSTRUCTOR ------------------------------------------------------------------------------------------- CONSTRUCTOR //////////////////////
        //////////////
        private var __textureID:String;

        private var __scale9Rectangle:Rectangle;

        private var __repeatTexture:Boolean;
        private var __trimmed:Boolean;

        public function TextureVO(textureID:String, scale9Rectangle:Rectangle = null, repeatTexture:Boolean = false, trimmed:Boolean=false)
        {
            __textureID = textureID;
            __scale9Rectangle = scale9Rectangle;
            __repeatTexture = repeatTexture;
			__trimmed = trimmed;
        }

        //////////////
        ////////////// PUBLIC ------------------------------------------------------------------------------------------------ PUBLIC ///////////////////////////
        //////////////
        public function clone():TextureVO
        {
            return new TextureVO(__textureID, __scale9Rectangle.clone(), __repeatTexture);
        }

        public function dispose():void
        {
            __textureID = null;
            __scale9Rectangle.setEmpty();
            __scale9Rectangle = null;
        }

        //////////////
        ////////////// OVERRIDE PUBLIC --------------------------------------------------------------------------------------- OVERRIDE PUBLIC //////////////////
        //////////////
        //////////////
        ////////////// PROTECTED --------------------------------------------------------------------------------------------- PROTECTED ////////////////////////
        //////////////
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
        public function get textureID():String
        {
            return __textureID;
        }

        public function get scale9Rectangle():Rectangle
        {
            return __scale9Rectangle;
        }

        public function get repeatTexture():Boolean
        {
            return __repeatTexture;
        }

		public function get trimmed():Boolean
		{
			return __trimmed;
		}

    }
}
