package net.mg2013.singeltons
{
    import flash.geom.Point;

    public class PointClassPool
    {
        private static var instance:PointClassPool;

        private var __size:int;

        private var __points:Vector.<Point> = new Vector.<Point>();

        private var __initialized:Boolean = false;

        private var __used:Vector.<int> = new Vector.<int>();

        private var __currentIndex:int = 0;

        //////////////
        ////////////// CONSTRUCTOR ------------------------------------------------------------------------------------------- CONSTRUCTOR //////////////////////
        //////////////
        public function PointClassPool(enforcer:SingletonEnforcer)
        {
            if (!enforcer)
                throw new Error("Class is singleton, use getInstance");
        }

        //////////////
        ////////////// PUBLIC ------------------------------------------------------------------------------------------------ PUBLIC ///////////////////////////
        //////////////
        public function initialize(size:int = 20):void
        {
            __size = size;
            initPool();
            __initialized = true;
        }

        public function getObjectFromPoint(oldPoint:Point):Point
        {
            return getObject(oldPoint.x, oldPoint.y);
        }

        public function getObject(x:Number = 0, y:Number = 0):Point
        {
            if (!__initialized)
                initialize();
            var index:int = __used.indexOf(0);
            var p:Point;
            if (index >= 0)
            {
                p = __points[index];
                __used[index] = 1;
                __currentIndex = index;
            }
            else
            {
                p = new Point(x, y);
                __points.push(p);
                __used.push(1);
                __currentIndex = __used.length - 1;
            }
            p.x = x;
            p.y = y;
            return p;
        }

        public function returnObject(p:Point):void
        {
            var index:int = __points.indexOf(p);
            if (index == -1)
                return;
            p.x = p.y = 0;
            __used[index] = 0;
        }

        public static function getInstance():PointClassPool
        {
            if (instance == null)
                instance = new PointClassPool(new SingletonEnforcer());
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
                var p:Point = new Point();
                __points.push(p);
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
