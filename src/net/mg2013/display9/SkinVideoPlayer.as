package net.mg2013.display9
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.layout.ScaleMode;
	import com.greensock.loading.VideoLoader;
	import com.greensock.loading.display.ContentDisplay;
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	import flash.events.MouseEvent;
	import flash.events.StageVideoEvent;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.utils.describeType;
	import net.mg2013.display.IVideoControls;
	import net.mg2013.display.SpriteStageEvents;
	import net.mg2013.display.VideoPlayerDefaultControls;
	import net.mg2013.memory.GarbageCollection;
	import org.casalib.events.InactivityEvent;
	import org.casalib.time.Inactivity;
	import org.casalib.util.StageReference;

	public class SkinVideoPlayer extends SpriteStageEvents
	{
		//////////////
		////////////// CONSTRUCTOR ------------------------------------------------------------------------------------------- CONSTRUCTOR //////////////////////
		//////////////
		private var __contentDisplay:ContentDisplay;

		private var __videoWidth:int;

		private var __videoHeight:int;

		private var __videoLoader:VideoLoader;

		private var __stage:Stage;

		private var __wasPlaying:Boolean = true;

		private var __userIDLE:Inactivity;

		private var __url:String;

		private var __controlsSkinClass:Class = VideoPlayerDefaultControls;

		private const __controlsFactory:Class = VideoPlayerDefaultControls;

		private var __controls:IVideoControls

		public function SkinVideoPlayer(url:String, videoWidth:int, videoHeight:int, autoPlay:Boolean = false, controlsSkinClass:Class = null, controlsClass:Class = null) //, controlSkinClass:Class, controlsClass:Class=null)
		{
			super();
			if (!controlsClass)
				controlsClass = __controlsFactory;
			var typeXML:XML = describeType(controlsClass);
			if (String(typeXML.factory.implementsInterface).indexOf("IVideoControls") < 0)
			{
				throw new Error("This class doesn't implement net.mg2013.display.IVideoControls");
			}
			else
			{
				__controlsFactory = controlsClass;
				trace("controls class is ok");
			}
			__wasPlaying = autoPlay;
			__url = url;
			__videoWidth = videoWidth;
			__videoHeight = videoHeight;
			__controlsSkinClass = controlsSkinClass;
		}

		//////////////
		////////////// PUBLIC ------------------------------------------------------------------------------------------------ PUBLIC ///////////////////////////
		//////////////
		public function play():void
		{
			__videoLoader.videoPaused = false;
		}

		public function stop():void
		{
			__videoLoader.videoPaused = true;
			__videoLoader.gotoVideoTime(0);
		}

		public function setSize(width:int, height:int):void
		{
			__videoWidth = width;
			__videoHeight = height;
			if (__contentDisplay)
			{
				trace("__contentDisplay");
				__contentDisplay.fitWidth = __videoWidth;
				__contentDisplay.fitHeight = __videoHeight;
			}
			if (__controls)
			{
				__controls.videoWidth = __videoWidth;
				__controls.videoHeight = __videoHeight;
			}
			validateContent();
		}

		protected function setViewportRectangle():void
		{
			var rect:Rectangle = new Rectangle();
			var w:int = __videoLoader.metaData.width;
			var h:int = __videoLoader.metaData.height;
			var r0:Number = __videoWidth / w;
			var r1:Number = __videoHeight / h;
			var r:Number = r0 < r1 ? r0 : r1;
			rect.width = w * r;
			rect.height = h * r;
			rect.x = int(stage.stageWidth / 2 - rect.width / 2);
			rect.y = int(stage.stageHeight / 2 - rect.height / 2);
			stage.stageVideos[0].viewPort = rect;
		}

		//////////////
		////////////// OVERRIDE PUBLIC --------------------------------------------------------------------------------------- OVERRIDE PUBLIC //////////////////
		//////////////
		override public function dispose():void
		{
			super.dispose();
			if (__videoLoader)
			{
				__videoLoader.videoPaused = true;
				__videoLoader.removeEventListener(Event.INIT, videoInitEvent);
				__videoLoader.removeEventListener(VideoLoader.PLAY_PROGRESS, playProgressEvent);
				__videoLoader.removeEventListener(VideoLoader.VIDEO_PAUSE, pausePlayEvent);
				__videoLoader.removeEventListener(VideoLoader.VIDEO_PLAY, pausePlayEvent);
				__videoLoader.removeEventListener(LoaderEvent.FAIL, failEvent);
				__videoLoader.dispose();
				__videoLoader = null;
			}
			if (__userIDLE)
			{
				__userIDLE.stop();
				__userIDLE.removeEventListener(InactivityEvent.INACTIVE, inactiveEvent);
				__userIDLE.removeEventListener(InactivityEvent.ACTIVATED, activeEvent);
				__userIDLE.destroy();
				__userIDLE = null;
			}
			if (__stage)
			{
				StageReference.removeStage("stageDefault");
			}
			if (__contentDisplay)
			{
				__contentDisplay.dispose();
				__contentDisplay = null;
			}
			if (__controls)
				__controls.dispose();
			graphics.clear();
			GarbageCollection.forceGBCollection();
		}

		//////////////
		////////////// PROTECTED --------------------------------------------------------------------------------------------- PROTECTED ////////////////////////
		//////////////
		protected function initControls():void
		{
			__controls = new __controlsFactory();
			__controls.videoWidth = __videoWidth;
			__controls.videoHeight = __videoHeight;
			if (__controlsSkinClass)
				__controls.skinClass = __controlsSkinClass;
			__controls.videoLoader = __videoLoader;
			__controls.wasPlaying = __wasPlaying;
			__controls.initControls();
			addChild(__controls as DisplayObject);
			__controls.videoPaused = __videoLoader.videoPaused
			validateContent();
		}

		protected function validateContent():void
		{
		}

		protected function initVideo():void
		{
			__videoLoader = new VideoLoader(new URLRequest(__url), { autoPlay: __wasPlaying, container: this, width: __videoWidth, height: __videoHeight, scaleMode: ScaleMode.PROPORTIONAL_INSIDE });
			__videoLoader.addEventListener(Event.INIT, videoInitEvent, false, 0, true);
			__videoLoader.addEventListener(VideoLoader.PLAY_PROGRESS, playProgressEvent, false, 0, true);
			__videoLoader.addEventListener(VideoLoader.VIDEO_PAUSE, pausePlayEvent, false, 0, true);
			__videoLoader.addEventListener(VideoLoader.VIDEO_PLAY, pausePlayEvent, false, 0, true);
			__videoLoader.addEventListener(VideoLoader.VIDEO_COMPLETE, videoPlayCompleteEvent, false, 0, true);
			__videoLoader.addEventListener(LoaderEvent.FAIL, failEvent, false, 0, true);
			__videoLoader.load();
		}

		protected function videoPlayCompleteEvent(event:Event):void
		{
			__videoLoader.gotoVideoTime(0);
		}

		//////////////
		////////////// OVERRIDE PROTECTED ------------------------------------------------------------------------------------ OVERRIDE PROTECTED ///////////////
		//////////////
		//////////////
		////////////// MOUSE EVENTS ------------------------------------------------------------------------------------------ MOUSE EVENTS /////////////////////
		//////////////
		protected function fullscreenClickEvent(event:Event):void
		{
			if (stage.displayState == StageDisplayState.NORMAL)
				stage.displayState = StageDisplayState.FULL_SCREEN;
			else
				stage.displayState = StageDisplayState.NORMAL;
		}

		//////////////
		////////////// OVERRIDE MOUSE EVENTS --------------------------------------------------------------------------------- OVERRIDE MOUSE EVENTS ////////////
		//////////////
		//////////////
		////////////// EVENTS ------------------------------------------------------------------------------------------------ EVENTS ///////////////////////////
		//////////////
		protected function pausePlayEvent(event:Event):void
		{
			switch (event.type)
			{
				case VideoLoader.VIDEO_PLAY:
					if (__controls)
						__controls.videoPaused = false;
					break;
				case VideoLoader.VIDEO_PAUSE:
					if (__controls)
						__controls.videoPaused = true;
					if (__controls)
						__controls.show();
					break;
			}
		}

		protected function playProgressEvent(event:Event):void
		{
			if (__controls)
				__controls.playProgress = __videoLoader.playProgress;
		}

		protected function videoInitEvent(event:Event):void
		{
			__videoLoader.removeEventListener(Event.INIT, videoInitEvent);
			__contentDisplay = ContentDisplay(__videoLoader.content);
			initControls();
			validateContent();
			setSize(__videoWidth, __videoHeight);
			__videoLoader.gotoVideoTime(0, __wasPlaying);
		}

		protected function activeEvent(event:InactivityEvent):void
		{
			if (__controls)
				__controls.show();
		}

		protected function inactiveEvent(event:InactivityEvent):void
		{
			trace("inactiveEvent");
			if (__controls && !__videoLoader.videoPaused)
				__controls.hide();
		}

		protected function failEvent(event:LoaderEvent):void
		{
			trace(event.data);
		}

		protected function stageVideoStateChange(event:StageVideoEvent):void
		{
			var status:String = event.status;
			trace("stageVideoStateChange", status);
		}

		protected function fullscreenEvent(event:FullScreenEvent):void
		{
			if (event.fullScreen)
			{
				if (__controls)
					__controls.fullscreen = true;
			}
			else
			{
				if (__controls)
					__controls.fullscreen = false;
			}
		}

		//////////////
		////////////// OVERRIDE EVENTS --------------------------------------------------------------------------------------- OVERRIDE EVENTS //////////////////
		//////////////
		override protected function addedToStage(event:Event):void
		{
			super.addedToStage(event);
			__stage = stage;
			StageReference.setStage(__stage, "stageDefault");
			__userIDLE = new Inactivity(3000);
			__userIDLE.addEventListener(InactivityEvent.INACTIVE, inactiveEvent, false, 0, true);
			__userIDLE.addEventListener(InactivityEvent.ACTIVATED, activeEvent, false, 0, true);
			__userIDLE.start();
			initVideo();
			stage.addEventListener(FullScreenEvent.FULL_SCREEN, fullscreenEvent, false, 0, true);
		}

		override protected function removeFromStage(event:Event):void
		{
			super.removeFromStage(event);
			__stage = null;
		}
		//////////////
		////////////// GET & SET --------------------------------------------------------------------------------------------- GET & SET ////////////////////////
		//////////////
		//////////////
		////////////// OVERRIDE GET & SET ------------------------------------------------------------------------------------ OVERRIDE GET & SET ///////////////
		//////////////
	}
}