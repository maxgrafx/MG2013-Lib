package net.mg2013.display
{
	/**
	 * .....
	 * @author MAXGRAFX
	 * Feb 21, 2012
	 * mg.display.ButtonBase
	 *
	
	 */
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class InteractiveBase extends SpriteStageEvents
	{
		////////// CONSTRUCTOR -------------------------------------------------------------------------------------------------------------------------- CONSTRUCTOR
		public function InteractiveBase(manageEvents:Boolean = false)
		{
			super(manageEvents);
			buttonMode = true;
			tabEnabled = false;
			tabChildren = false;
		}
		
		////////// PUBLIC FUNCTIONS --------------------------------------------------------------------------------------------------------------------- PUBLIC FUNCTIONS
		////////// OVERRIDE PUBLIC FUNCTIONS ------------------------------------------------------------------------------------------------------------ OVERRIDE PUBLIC FUNCTIONS
		////////// PUBLIC STATIC FUNCTIONS -------------------------------------------------------------------------------------------------------------- PUBLIC STATIC FUNCTIONS
		////////// PROTECTED FUNCTIONS ------------------------------------------------------------------------------------------------------------------ PROTECTED FUNCTIONS
		protected function rollout():void
		{
			// TODO Auto Generated method stub
		}
		
		protected function rollover():void
		{
			// TODO Auto Generated method stub
		}
		
		////////// OVERRIDE PROTECTED FUNCTIONS --------------------------------------------------------------------------------------------------------- OVERRIDE PROTECTED FUNCTIONS
		////////// EVENT FUNCTIONS ---------------------------------------------------------------------------------------------------------------------- EVENT FUNCTIONS
		////////// OVERRIDE EVENT FUNCTIONS ------------------------------------------------------------------------------------------------------------- OVERRIDE EVENT FUNCTIONS
		override protected function addedToStage(event:Event):void
		{
			super.addedToStage(event);
			addEventListener(MouseEvent.ROLL_OVER, rollEvent, false, 0, true);
			addEventListener(MouseEvent.ROLL_OUT, rollEvent, false, 0, true);
		}
		
		override protected function removeFromStage(event:Event):void
		{
			super.removeFromStage(event);
			removeEventListener(MouseEvent.ROLL_OVER, rollEvent);
			removeEventListener(MouseEvent.ROLL_OUT, rollEvent);
		}
		
		////////// MOUSE FUNCTIONS ---------------------------------------------------------------------------------------------------------------------- MOUSE FUNCTIONS
		final protected function rollEvent(event:MouseEvent):void
		{
			switch (event.type)
			{
				case MouseEvent.ROLL_OUT:
					rollout();
					break;
				case MouseEvent.ROLL_OVER:
					rollover();
					break;
			}
		}
		////////// OVERRIDE MOUSE FUNCTIONS ------------------------------------------------------------------------------------------------------------- OVERRIDE MOUSE FUNCTIONS
		////////// PROTECTED GET & SET FUNCTIONS -------------------------------------------------------------------------------------------------------- PROTECTED GET & SET FUNCTIONS
		////////// PUBLIC GET & SET FUNCTIONS ----------------------------------------------------------------------------------------------------------- PUBLIC GET & SET FUNCTIONS
	}
}
