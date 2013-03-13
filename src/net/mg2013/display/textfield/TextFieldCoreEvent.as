package net.mg2013.display.textfield
{
	import flash.events.Event;

	public class TextFieldCoreEvent extends Event
	{
		public static const UPDATE : String = "update"

		public function TextFieldCoreEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}