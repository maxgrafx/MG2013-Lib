package net.mg2013.display
{
	import com.greensock.loading.VideoLoader;

	public interface IVideoControls
	{
		function initControls():void;
		function dispose():void;
		function hide():void
		function show():void
		function set videoLoader(value:VideoLoader):void;
		function set skinClass(value:Class):void;
		function get videoPaused():Boolean;
		function set videoPaused(value:Boolean):void;
		function get playProgress():Number;
		function set playProgress(value:Number):void;
		function get fullscreen():Boolean;
		function set fullscreen(value:Boolean):void;
		function get videoWidth():Number;
		function set videoWidth(value:Number):void;
		function get videoHeight():Number;
		function set videoHeight(value:Number):void;
		function get wasPlaying():Boolean
		function set wasPlaying(value:Boolean):void
	}
}
