package net.mg2013.dom
{
	/**
	 * .....
	 * @author MAXGRAFX
	
	 */
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.SelfLoader;
	
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import org.casalib.util.StageReference;
	
	public class MovieClipDom extends MovieClip
	{
		private var __frame:int;
		
		private var __selfLoader:SelfLoader;
		
		//////////-------------------------------------------------------------------------------------------------------------------------- CONSTRUCTOR
		public function MovieClipDom(frame:int = 2, autoLoad:Boolean = true)
		{
			super();
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.addEventListener(Event.RESIZE, stageResize);
			StageReference.setStage(stage);
			__frame = frame;
			__selfLoader = new SelfLoader(this, { autoDispose: false });
			__selfLoader.addEventListener(LoaderEvent.PROGRESS, swfProgress, false, 0, true);
			__selfLoader.addEventListener(LoaderEvent.COMPLETE, swfLoaded, false, 0, true);
			if (autoLoad)
				__selfLoader.load();
		}
		
		//////////-------------------------------------------------------------------------------------------------------------------------- PUBLIC FUNCTIONS
		//////////-------------------------------------------------------------------------------------------------------------------------- PROTECTED FUNCTIONS
		protected function init():void
		{
		}
		
		//////////-------------------------------------------------------------------------------------------------------------------------- EVENT FUNCTIONS
		protected function stageResize(event:Event):void
		{
		}
		
		protected function swfProgress(event:LoaderEvent):void
		{
		}
		
		protected function swfLoaded(event:LoaderEvent):void
		{
			gotoAndStop(__frame);
			init();
			__selfLoader.removeEventListener(LoaderEvent.PROGRESS, swfProgress);
			__selfLoader.removeEventListener(LoaderEvent.COMPLETE, swfLoaded);
			__selfLoader.dispose();
			__selfLoader = null;
		}
		
		//////////-------------------------------------------------------------------------------------------------------------------------- MOUSE FUNCTIONS
		//////////-------------------------------------------------------------------------------------------------------------------------- PROTECTED GET & SET FUNCTIONS
		protected function get selfLoader():SelfLoader
		{
			return __selfLoader;
		}
		//////////-------------------------------------------------------------------------------------------------------------------------- GET & SET FUNCTIONS
	}
}
