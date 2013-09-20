package net.mg2013.display
{
	import flash.display.Sprite;
	import net.mg2013.interfaces.IDisposable;

	public class MGEventDispatcher extends Sprite implements IDisposable
	{
		//////////////
		////////////// CONSTRUCTOR ------------------------------------------------------------------------------------------- CONSTRUCTOR //////////////////////
		//////////////
		private var __listenersTypeArray:Array = [];

		private var __listenersFunctionArray:Array = [];

		private var __listenersUseCaptureArray:Array = [];

		private var __manageEvents:Boolean;

		public function MGEventDispatcher(manageEvents:Boolean = false)
		{
			super();
			__manageEvents = manageEvents;
		}

		//////////////
		////////////// PUBLIC ------------------------------------------------------------------------------------------------ PUBLIC ///////////////////////////
		//////////////
		public function dispose():void
		{
			if (manageEvents && __listenersFunctionArray)
			{
				var n:int = __listenersFunctionArray.length;
				for (var i:int = 0; i < n; i++)
					super.removeEventListener(__listenersTypeArray[i], __listenersFunctionArray[i], __listenersUseCaptureArray[i]);
			}
			if (__listenersTypeArray)
				__listenersTypeArray.length = 0;
			if (__listenersFunctionArray)
				__listenersFunctionArray.length = 0;
			if (__listenersUseCaptureArray)
				__listenersUseCaptureArray.length = 0;
			__listenersTypeArray = null;
			__listenersFunctionArray = null;
			__listenersUseCaptureArray = null;
		}

		//////////////
		////////////// OVERRIDE PUBLIC --------------------------------------------------------------------------------------- OVERRIDE PUBLIC //////////////////
		//////////////
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			super.addEventListener(type, listener, useCapture, priority, useWeakReference);
			if (!__manageEvents)
				return;
			if (__listenersTypeArray.indexOf(type) == -1 && __listenersFunctionArray.indexOf(listener) == -1)
			{
				__listenersTypeArray.push(type);
				__listenersFunctionArray.push(listener);
				__listenersUseCaptureArray.push(useCapture);
			}
			else if (hasEventListener(type) && __listenersFunctionArray.indexOf(listener) == -1)
			{
				__listenersTypeArray.push(type);
				__listenersFunctionArray.push(listener);
				__listenersUseCaptureArray.push(useCapture);
			}
		}

		override public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		{
			super.removeEventListener(type, listener, useCapture);
			if (!__manageEvents)
				return;
			var index0:int = __listenersTypeArray.indexOf(type);
			var index1:int = __listenersFunctionArray.indexOf(listener);
			if (index0 >= 0 && index1 >= 0)
			{
				if (index1 > index0)
				{
					if (__listenersTypeArray[index1] == type)
					{
						__listenersTypeArray.splice(index1, 1);
						__listenersFunctionArray.splice(index1, 1);
						__listenersUseCaptureArray.splice(index1, 1);
					}
				}
				else if (index0 == index1)
				{
					__listenersTypeArray.splice(index1, 1);
					__listenersFunctionArray.splice(index1, 1);
					__listenersUseCaptureArray.splice(index1, 1);
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
