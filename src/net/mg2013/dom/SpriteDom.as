package net.mg2013.dom
{
	/**
	 * .....
	 * @author MAXGRAFX

	 */
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.SelfLoader;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	public class SpriteDom extends Sprite
	{
		private var __selfLoader:SelfLoader

		//////////-------------------------------------------------------------------------------------------------------------------------- CONSTRUCTOR
		public function SpriteDom()
		{
			super();
			stage.align = StageAlign.TOP_LEFT
			stage.scaleMode = StageScaleMode.NO_SCALE
			stage.addEventListener(Event.RESIZE, stageResize)
			selfLoader = new SelfLoader(this, { autoDispose: false })
			selfLoader.addEventListener(LoaderEvent.COMPLETE, swfLoaded)
			selfLoader.load()
		}

		//////////-------------------------------------------------------------------------------------------------------------------------- PUBLIC FUNCTIONS
		//////////-------------------------------------------------------------------------------------------------------------------------- PROTECTED FUNCTIONS
		protected function init():void
		{
		}

		protected function cancelSelfLoader():void
		{
			selfLoader.cancel()
			selfLoader.unload()
			selfLoader.removeEventListener(LoaderEvent.COMPLETE, swfLoaded)
		}

		//////////-------------------------------------------------------------------------------------------------------------------------- EVENT FUNCTIONS
		protected function stageResize(event:Event = null):void
		{
		}

		protected function swfLoaded(event:LoaderEvent):void
		{
			selfLoader.removeEventListener(LoaderEvent.COMPLETE, swfLoaded)
			init()
		}

		//////////-------------------------------------------------------------------------------------------------------------------------- MOUSE FUNCTIONS
		//////////-------------------------------------------------------------------------------------------------------------------------- PROTECTED GET & SET FUNCTIONS
		//////////-------------------------------------------------------------------------------------------------------------------------- GET & SET FUNCTIONS
		public function get selfLoader():SelfLoader
		{
			return __selfLoader;
		}

		public function set selfLoader(value:SelfLoader):void
		{
			__selfLoader = value;
		}
	}
}