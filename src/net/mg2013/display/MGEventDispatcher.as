package net.mg2013.display
{
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	import net.mg2013.events.MGEvent;
	import net.mg2013.interfaces.IDisposable;
	import net.mg2013.singeltons.ObjectPools;
	use namespace mg_internal;

	public class MGEventDispatcher extends Sprite implements IDisposable
	{
		//////////////
		////////////// CONSTRUCTOR ------------------------------------------------------------------------------------------- CONSTRUCTOR //////////////////////
		//////////////
		/*private var __listenersTypeArray:Array = [];

		private var __listenersFunctionArray:Array = [];

		private var __listenersUseCaptureArray:Array = [];*/
		private var __manageEvents:Boolean = false;

		private var __eventListeners:Dictionary;

		public function MGEventDispatcher(manageEvents:Boolean = true)
		{
			super();
			__manageEvents = manageEvents;
		}

		//////////////
		////////////// PUBLIC ------------------------------------------------------------------------------------------------ PUBLIC ///////////////////////////
		//////////////
		public function dispose():void
		{
			removeEventListeners();
		}

		public function removeEventListeners(type:String = null):void
		{
			if (type && __eventListeners)
				delete __eventListeners[type];
			else
				__eventListeners = null;
		}

		public function dispatchEventFromPool(classObject:Class, factory:Function, ... args):void
		{
			if (!ObjectPools.getInstance().hasPool(classObject))
			{
				ObjectPools.getInstance().createPool(classObject, factory);
			}
			var event:MGEvent = ObjectPools.getInstance().getObject(classObject, args) as MGEvent;
			event.reset(args as Array);
			dispatchEvent(event);
			ObjectPools.getInstance().returnObject(classObject, event);
		}

		//////////////
		////////////// OVERRIDE PUBLIC --------------------------------------------------------------------------------------- OVERRIDE PUBLIC //////////////////
		//////////////
		/** Returns if there are listeners registered for a certain event type. */
		override public function hasEventListener(type:String):Boolean
		{
			if (__manageEvents)
			{
				var listeners:Vector.<Function> = __eventListeners ? __eventListeners[type] as Vector.<Function> : null;
				return listeners ? listeners.length != 0 : false;
			}
			return super.hasEventListener(type);
		}

		override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			super.addEventListener(type, listener, useCapture, priority, useWeakReference);
			if (!__manageEvents)
				return;
			if (__eventListeners == null)
				__eventListeners = new Dictionary();
			var listeners:Vector.<Function> = __eventListeners[type] as Vector.<Function>;
			if (listeners == null)
				__eventListeners[type] = new <Function>[ listener ];
			else if (listeners.indexOf(listener) == -1)
				listeners.push(listener);
		}

		override public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		{
			super.removeEventListener(type, listener, useCapture);
			if (!__manageEvents)
				return;
			if (__eventListeners)
			{
				var listeners:Vector.<Function> = __eventListeners[type] as Vector.<Function>;
				if (listeners)
				{
					var numListeners:int = listeners.length;
					var remainingListeners:Vector.<Function> = new <Function>[];
					for (var i:int = 0; i < numListeners; ++i)
						if (listeners[i] != listener)
							remainingListeners.push(listeners[i]);
					__eventListeners[type] = remainingListeners;
				}
			}
		}

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
		public function get manageEvents():Boolean
		{
			return __manageEvents;
		}
		//////////////
		////////////// OVERRIDE GET & SET ------------------------------------------------------------------------------------ OVERRIDE GET & SET ///////////////
		//////////////
	}
}
