package net.mg2013.display
{
	import net.mg2013.collection.MGTextFieldCollection;
	import net.mg2013.collection.MGTextFieldCollectionTypes;
	import net.mg2013.display.textfield.TextFieldCoreEvent;
	
	import flash.events.Event;
	import flash.text.TextField;

	[Event(name = "update", type = "net.mg2013.display.textfield.TextFieldCoreEvent")]
	public class MGCSSTextFieldCore extends TextField
	{
		private var __id:String

		private var __startTag:String = ""

		private var __endTag:String = ""

		private var __collectionType:int

		private var __listenersTypeArray:Array = [];

		private var __listenersFunctionArray:Array = [];

		private var __listenersUseCaptureArray:Array = [];

		//////////-------------------------------------------------------------------------------------------------------------------------- CONSTRUCTOR
		public function MGCSSTextFieldCore(_id:String = null, collectionType:int = -1)
		{
			super();
			__id = _id;
			__collectionType = collectionType;
			if (__id && collectionType == MGTextFieldCollectionTypes.SKIP_COLLECTION)
				__collectionType = MGTextFieldCollectionTypes.MONITOR_STAGE;
			if (__id || __collectionType == MGTextFieldCollectionTypes.MONITOR_STAGE)
			{
				addEventListener(Event.ADDED_TO_STAGE, added);
			}
			else if (collectionType == MGTextFieldCollectionTypes.COLLECT)
			{
				__id = new Date().getTime().toString() + Math.round(Math.random() * 1000).toString();
				MGTextFieldCollection.getInstance().addTextField(this);
			}
		}

		//////////-------------------------------------------------------------------------------------------------------------------------- PUBLIC FUNCTIONS
		public function dispose():void
		{
			if (collectionType != MGTextFieldCollectionTypes.SKIP_COLLECTION)
				MGTextFieldCollection.getInstance().clearFromVector(this);
			/*if (hasEventListener(Event.ADDED_TO_STAGE))
				removeEventListener(Event.ADDED_TO_STAGE, added);*/
			if (styleSheet)
				styleSheet = null;
			var n:int = __listenersFunctionArray.length;
			for (var i:int = 0; i < n; i++)
				super.removeEventListener(__listenersTypeArray[i], __listenersFunctionArray[i], __listenersUseCaptureArray[i]);
			__listenersTypeArray.length = 0;
			__listenersFunctionArray.length = 0;
			__listenersUseCaptureArray.length = 0;
			__listenersTypeArray = null;
			__listenersFunctionArray = null;
			__listenersUseCaptureArray = null;
		}

		public function update():void
		{
			dispatchEvent(new TextFieldCoreEvent(TextFieldCoreEvent.UPDATE));
		}

		//////////-------------------------------------------------------------------------------------------------------------------------- PROTECTED FUNCTIONS
		//////////-------------------------------------------------------------------------------------------------------------------------- EVENT FUNCTIONS
		protected function added(_e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, added);
			MGTextFieldCollection.getInstance().addTextField(this);
		}

		override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			super.addEventListener(type, listener, useCapture, priority, useWeakReference);
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

		//////////-------------------------------------------------------------------------------------------------------------------------- MOUSE FUNCTIONS
		//////////-------------------------------------------------------------------------------------------------------------------------- PROTECTED GET & SET FUNCTIONS
		//////////-------------------------------------------------------------------------------------------------------------------------- GET & SET FUNCTIONS
		public function get id():String
		{
			return __id;
		}

		public function set id(_id:String):void
		{
			__id = _id;
		}

		public function get startTag():String
		{
			return __startTag;
		}

		public function set startTag(_tag:String):void
		{
			__startTag = _tag;
		}

		public function get endTag():String
		{
			return __endTag;
		}

		public function set endTag(_tag:String):void
		{
			__endTag = _tag;
		}

		public function get collectionType():int
		{
			return __collectionType;
		}
	}
}
