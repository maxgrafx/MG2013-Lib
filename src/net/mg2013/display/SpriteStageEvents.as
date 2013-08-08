package net.mg2013.display
{
	import flash.display.Sprite;
	import flash.events.Event;
	import net.mg2013.interfaces.IDisposable;

	public class SpriteStageEvents extends MGEventDispatcher implements ISpriteStageEvents, IDisposable
	{
		//////////-------------------------------------------------------------------------------------------------------------------------- CONSTRUCTOR
		public function SpriteStageEvents(manageEvents:Boolean = false)
		{
			super(manageEvents);
			addEventListener(Event.ADDED_TO_STAGE, addedToStage, false, 0, true);
		}

		//////////-------------------------------------------------------------------------------------------------------------------------- PUBLIC FUNCTIONS
		override public function dispose():void
		{
			if (!manageEvents)
			{
				removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
				removeEventListener(Event.REMOVED_FROM_STAGE, removeFromStage);
			}
		}

		//////////-------------------------------------------------------------------------------------------------------------------------- OVERRIDE PUBLIC FUNCTIONS
		//////////-------------------------------------------------------------------------------------------------------------------------- PROTECTED FUNCTIONS
		//////////-------------------------------------------------------------------------------------------------------------------------- OVERRIDE PROTECTED FUNCTIONS
		//////////-------------------------------------------------------------------------------------------------------------------------- EVENT FUNCTIONS
		protected function addedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, removeFromStage, false, 0, true);
		}

		protected function removeFromStage(event:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removeFromStage);
			//addEventListener(Event.ADDED_TO_STAGE, addedToStage, false, 0, true);
		}
		//////////-------------------------------------------------------------------------------------------------------------------------- OVERRIDE EVENT FUNCTIONS
		//////////-------------------------------------------------------------------------------------------------------------------------- MOUSE FUNCTIONS
		//////////-------------------------------------------------------------------------------------------------------------------------- OVERRIDE MOUSE FUNCTIONS
		//////////-------------------------------------------------------------------------------------------------------------------------- PROTECTED GET & SET FUNCTIONS
		//////////-------------------------------------------------------------------------------------------------------------------------- PUBLIC GET & SET FUNCTIONS
	}
}
