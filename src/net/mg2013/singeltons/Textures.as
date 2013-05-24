package net.mg2013.singeltons
{
    import flash.display.BitmapData;
    import flash.events.EventDispatcher;
    
    import net.mg2013.utils.TextureAtlas;

    public class Textures extends EventDispatcher
    {
        //////////////
        ////////////// CONSTRUCTOR ------------------------------------------------------------------------------------------- CONSTRUCTOR //////////////////////
        //////////////
        private static var instance:Textures;

        private var __atlas:TextureAtlas;

        private var __customIDs:Vector.<String> = new Vector.<String>();

        private var __custom:Vector.<BitmapData> = new Vector.<BitmapData>();

        private var __id:Vector.<String>;

        public function Textures(pvt:SingletonEnforcer)
        {
            if (!pvt)
                throw new Error("Class is singleton, use getInstance");
        }

        //////////////
        ////////////// PUBLIC ------------------------------------------------------------------------------------------------ PUBLIC ///////////////////////////
        //////////////
        public function initialize(bitmapdata:BitmapData, xml:XML):void
        {
            __atlas = new TextureAtlas(bitmapdata, xml);
            initTexture();
        }

        public static function get inst():Textures
        {
            if (instance == null)
                instance = new Textures(new SingletonEnforcer());
            return instance;
        }

        public function getTexture(id:String, trimmed:Boolean = false):BitmapData
        {
            if (__atlas.ids.indexOf(id) >= 0)
            {
                return __atlas.getTexture(id,trimmed);
            }
            else if (__customIDs.indexOf(id) >= 0)
            {
                return __custom[__customIDs.indexOf(id)].clone();
            }
            else
            {
                throw new Error("texture " + id + " does not exist!");
            }
            return null;
        }

        //////////////
        ////////////// OVERRIDE PUBLIC --------------------------------------------------------------------------------------- OVERRIDE PUBLIC //////////////////
        //////////////
        //////////////
        ////////////// PROTECTED --------------------------------------------------------------------------------------------- PROTECTED ////////////////////////
        //////////////
        protected function initTexture():void
        {
            __id = __atlas.ids.concat();
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
        public function get customIDs():Vector.<String>
        {
            return __customIDs;
        }

        public function get custom():Vector.<BitmapData>
        {
            return __custom;
        }
        //////////////
        ////////////// OVERRIDE GET & SET ------------------------------------------------------------------------------------ OVERRIDE GET & SET ///////////////
        //////////////
    }
}

internal class SingletonEnforcer
{
}
