package net.mg2013.events
{
	import flash.events.Event;
	import net.mg2013.display.mg_internal;
	import net.mg2013.interfaces.IPoolable;
	use namespace mg_internal

	public class MGEvent extends Event implements IPoolable
	{
		//////////////
		////////////// CONSTRUCTOR ------------------------------------------------------------------------------------------- CONSTRUCTOR ///////////////////////////
		//////////////
		private var __type:String;

		private var __bubbles:Boolean;

		private var __cancelable:Boolean;

		public function MGEvent(_type:String, _bubbles:Boolean = false, _cancelable:Boolean = false)
		{
			__type = _type;
			__bubbles = _bubbles;
			__cancelable = _cancelable;
			super(_type, _bubbles, _cancelable);
		}

		//////////////
		////////////// PUBLIC ------------------------------------------------------------------------------------------------ PUBLIC ///////////////////////////
		//////////////
		public static function factory(args:Array):MGEvent
		{
			return new MGEvent(args[0], args[1], args[2]);
		}

		public function reset(args:Array):void
		{
			type = String(args[0]);
			bubbles = args.length > 0 ? args[1] as Boolean : false;
			cancelable = args.length > 1 ? args[2] as Boolean : false;
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
		public function set type(value:String):void
		{
			__type = value;
		}

		public function set bubbles(value:Boolean):void
		{
			__bubbles = value;
		}

		public function set cancelable(value:Boolean):void
		{
			__cancelable = value;
		}

		//////////////
		////////////// OVERRIDE GET & SET ------------------------------------------------------------------------------------ OVERRIDE GET & SET ///////////////
		//////////////
		override public function get type():String
		{
			return __type;
		}

		override public function get bubbles():Boolean
		{
			return __bubbles;
		}

		override public function get cancelable():Boolean
		{
			return __cancelable;
		}
	}
}
