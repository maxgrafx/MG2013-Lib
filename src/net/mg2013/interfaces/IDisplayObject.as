package net.mg2013.interfaces
{
	import flash.display.DisplayObject;
	
	/**
	 * An interface to work around the lack of interface for display objects.
	 */
	public interface IDisplayObject
	{
		/** 
		 * Returns a representation of the object as a DisplayObject.
		 * Usually would return the object itself.
		 */ 
		function asDisplayObject():DisplayObject; 
		// function get view():DisplayObject; //would work too if you're into the whole brevity thing. 
	}
}