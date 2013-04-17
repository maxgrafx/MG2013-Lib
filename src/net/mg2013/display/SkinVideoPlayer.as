package net.mg2013.display
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Quad;
	import com.greensock.events.LoaderEvent;
	import com.greensock.layout.ScaleMode;
	import com.greensock.loading.VideoLoader;
	import com.greensock.loading.display.ContentDisplay;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.StageVideoAvailabilityEvent;
	import flash.events.StageVideoEvent;
	import flash.geom.Rectangle;
	import flash.media.StageVideoAvailability;
	import flash.net.URLRequest;
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

		private var __controls:Sprite;

		private var __videoLoader:VideoLoader;

		private var __pausePlayButton:Sprite;

		private var __pauseIcon:Sprite;

		private var __playIcon:Sprite;

		private var __track:Sprite;

		private var __scrubber:Sprite;

		private var __trackBG:Sprite;

		private var __controlsBG:Sprite;

		private var __stage:Stage;

		private var __controlsHolder:Sprite;

		private var __wasPlaying:Boolean = true;

		private var __userIDLE:Inactivity;

		private var __url:String;

		private var __usingStageVideo:Boolean;

		public function SkinVideoPlayer(url:String, videoWidth:int, videoHeight:int, controlsClass:Class)
		{
			super();
			__url = url;
			//graphics.beginFill(0x000000, .6);
			//graphics.drawRect(0, 0, 1024, 600);
			__videoWidth = videoWidth;
			__videoHeight = videoHeight;
			__controlsHolder = new Sprite();
			__controlsHolder.graphics.beginFill(0x000000, 0);
			__controlsHolder.graphics.drawRect(0, 0, videoWidth, videoHeight);
			__controls = Sprite(new controlsClass());
			__controlsHolder.addEventListener(MouseEvent.ROLL_OUT, videoRollEvent, false, 0, true);
			__controlsHolder.addEventListener(MouseEvent.ROLL_OVER, videoRollEvent, false, 0, true);
			controlsClass = null;
		}

		//////////////
		////////////// PUBLIC ------------------------------------------------------------------------------------------------ PUBLIC ///////////////////////////
		//////////////
		public function setSize(width:int, height:int):void
		{
			__videoWidth = width;
			__videoHeight = height;
			if (__usingStageVideo)
				setViewportRectangle();
			else
			{
				if (__contentDisplay)
				{
					trace("__contentDisplay");
					__contentDisplay.fitWidth = __videoWidth;
					__contentDisplay.fitHeight = __videoHeight;
				}
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
			removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveEvent);
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
				__stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpEvent);
			}
			if (__controlsHolder)
			{
				__controlsHolder.removeEventListener(MouseEvent.ROLL_OUT, videoRollEvent);
				__controlsHolder.removeEventListener(MouseEvent.ROLL_OVER, videoRollEvent);
				__controlsHolder.graphics.clear();
				__controlsHolder.removeChildAt(0);
			}
			if (__contentDisplay)
			{
				__contentDisplay.dispose();
				__contentDisplay = null;
			}
			__controls = null;
			if (__pausePlayButton)
			{
				__pausePlayButton.removeEventListener(MouseEvent.CLICK, pausePlayClickEvent);
				__pausePlayButton = null;
			}
			__pauseIcon = null;
			__playIcon = null;
			__track = null;
			__scrubber = null;
			if (__trackBG)
			{
				__trackBG.removeEventListener(MouseEvent.MOUSE_DOWN, trackDownEvent);
				__trackBG = null;
			}
			__controlsBG = null;
			__controlsHolder = null;
			graphics.clear();
			GarbageCollection.forceGBCollection();
		}

		//////////////
		////////////// PROTECTED --------------------------------------------------------------------------------------------- PROTECTED ////////////////////////
		//////////////
		protected function initControls():void
		{
			addChild(__controlsHolder);
			__controlsHolder.addChild(__controls);
			__controlsBG = __controls.getChildByName("bg") as Sprite;
			__track = __controls.getChildByName("track") as Sprite;
			__scrubber = __track.getChildByName("scrubber") as Sprite;
			__scrubber.mouseEnabled = false;
			__trackBG = __track.getChildByName("trackBG") as Sprite;
			__trackBG.buttonMode = true;
			__trackBG.tabChildren = __trackBG.tabEnabled = __trackBG.mouseChildren = false;
			__trackBG.addEventListener(MouseEvent.MOUSE_DOWN, trackDownEvent, false, 0, true);
			__pausePlayButton = __controls.getChildByName("pausePlayButton") as Sprite;
			__pausePlayButton.addEventListener(MouseEvent.CLICK, pausePlayClickEvent, false, 0, true);
			__pausePlayButton.buttonMode = true;
			__pausePlayButton.tabChildren = __pausePlayButton.tabEnabled = __pausePlayButton.mouseChildren = false;
			__pauseIcon = __pausePlayButton.getChildByName("pauseIcon") as Sprite;
			__playIcon = __pausePlayButton.getChildByName("playIcon") as Sprite;
			__controls.x = 25;
			__controls.y = __videoHeight - __controls.height - 25;
			if (__videoLoader.videoPaused)
			{
				__pauseIcon.visible = false;
				__playIcon.visible = true;
			}
			else
			{
				__pauseIcon.visible = true;
				__playIcon.visible = false;
			}
			validateContent();
		}

		protected function validateContent():void
		{
			if (__contentDisplay)
			{
				//__contentDisplay.x = int(1024 / 2 - __videoWidth / 2);
				//__contentDisplay.y = int(600 / 2 - __videoHeight / 2);
			}
			if (__controls)
			{
				if (__controlsHolder)
				{
					__controlsHolder.x = 0;
					__controlsHolder.y = 0;
				}
				if (__controlsBG)
					__controlsBG.width = __videoWidth - 50;
				__controls.y = __videoHeight - __controls.height - 25;
				if (__trackBG)
					__trackBG.width = __videoWidth - 50 - 26 - 40;
			}
			//mouseMoveEvent(null);
		}

		protected function initVideo():void
		{
			__videoLoader = new VideoLoader(new URLRequest(__url), { autoPlay: false, container: this, width: __videoWidth, height: __videoHeight, scaleMode: ScaleMode.PROPORTIONAL_INSIDE });
			__videoLoader.addEventListener(Event.INIT, videoInitEvent, false, 0, true);
			__videoLoader.addEventListener(VideoLoader.PLAY_PROGRESS, playProgressEvent, false, 0, true);
			__videoLoader.addEventListener(VideoLoader.VIDEO_PAUSE, pausePlayEvent, false, 0, true);
			__videoLoader.addEventListener(VideoLoader.VIDEO_PLAY, pausePlayEvent, false, 0, true);
			__videoLoader.addEventListener(LoaderEvent.FAIL, failEvent, false, 0, true);
			__videoLoader.load();
		}

		protected function initStageVideo():void
		{
			__usingStageVideo = true;
			stage.stageVideos[0].addEventListener(StageVideoEvent.RENDER_STATE, stageVideoStateChange);
			stage.stageVideos[0].viewPort = new Rectangle(int(stage.stageWidth / 2 - __videoWidth / 2), int(stage.stageHeight / 2 - __videoHeight / 2), __videoWidth, __videoHeight);
			__videoLoader = new VideoLoader(new URLRequest(__url), { autoPlay: false, stageVideo: stage.stageVideos[0]});
			__videoLoader.addEventListener(Event.INIT, videoInitEvent, false, 0, true);
			__videoLoader.addEventListener(VideoLoader.PLAY_PROGRESS, playProgressEvent, false, 0, true);
			__videoLoader.addEventListener(VideoLoader.VIDEO_PAUSE, pausePlayEvent, false, 0, true);
			__videoLoader.addEventListener(VideoLoader.VIDEO_PLAY, pausePlayEvent, false, 0, true);
			__videoLoader.addEventListener(LoaderEvent.FAIL, failEvent, false, 0, true);
			__videoLoader.load();
		}

		//////////////
		////////////// OVERRIDE PROTECTED ------------------------------------------------------------------------------------ OVERRIDE PROTECTED ///////////////
		//////////////
		//////////////
		////////////// MOUSE EVENTS ------------------------------------------------------------------------------------------ MOUSE EVENTS /////////////////////
		//////////////
		protected function videoRollEvent(event:MouseEvent):void
		{
			switch (event.type)
			{
				case MouseEvent.ROLL_OUT:
					if (__controls)
						TweenLite.to(__controls, .5, { alpha: 0, ease: Quad.easeOut, overwrite: "all" });
					break;
				case MouseEvent.ROLL_OVER:
					if (__controls)
						TweenLite.to(__controls, .5, { alpha: 1, ease: Quad.easeOut, overwrite: "all" });
					break;
			}
		}

		protected function trackDownEvent(event:MouseEvent):void
		{
			__videoLoader.videoPaused = true;
			mouseMoveEvent(null);
			addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveEvent, false, 0, true);
			__stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpEvent, false, 0, true);
		}

		protected function mouseUpEvent(event:MouseEvent):void
		{
			removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveEvent);
			if (__stage)
			{
				__stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpEvent);
			}
			__videoLoader.videoPaused = !__wasPlaying;
		}

		protected function mouseMoveEvent(event:MouseEvent):void
		{
			var mx:Number = __trackBG.mouseX * __trackBG.scaleX;
			var nx:Number = mx < 0 ? 0 : mx > __trackBG.width ? __trackBG.width : mx;
			var pr:Number = nx / __trackBG.width;
			__videoLoader.playProgress = pr;
			__scrubber.x = (__trackBG.width - __scrubber.width) * pr;
		}

		protected function pausePlayClickEvent(event:MouseEvent):void
		{
			__videoLoader.videoPaused = !__videoLoader.videoPaused;
			__wasPlaying = !__videoLoader.videoPaused;
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
					if (__pauseIcon)
						__pauseIcon.visible = true;
					if (__playIcon)
						__playIcon.visible = false;
					break;
				case VideoLoader.VIDEO_PAUSE:
					if (__pauseIcon)
						__pauseIcon.visible = false;
					if (__playIcon)
						__playIcon.visible = true;
					break;
			}
		}

		protected function playProgressEvent(event:Event):void
		{
			__scrubber.x = (__trackBG.width - __scrubber.width) * __videoLoader.playProgress;
		}

		protected function videoInitEvent(event:Event):void
		{
			trace("videoInitEvent");
			__videoLoader.removeEventListener(Event.INIT, videoInitEvent);
			__contentDisplay = ContentDisplay(__videoLoader.content);
			trace("video meta", __videoLoader.metaData.width, __videoLoader.metaData.height);
			trace(__videoWidth, __videoHeight);
			initControls();
			validateContent();
			//__contentDisplay.fitWidth = __videoWidth;
			//__contentDisplay.fitHeight = __videoHeight;
			setSize(__videoWidth, __videoHeight);
			__videoLoader.gotoVideoTime(0, true);
		}

		protected function activeEvent(event:InactivityEvent):void
		{
			if (__controls)
				TweenLite.to(__controls, .5, { alpha: 1, ease: Quad.easeOut, overwrite: "all" });
		}

		protected function inactiveEvent(event:InactivityEvent):void
		{
			if (__controls)
				TweenLite.to(__controls, .5, { alpha: 0, ease: Quad.easeOut, overwrite: "all" });
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
			stage.addEventListener(StageVideoAvailabilityEvent.STAGE_VIDEO_AVAILABILITY, onStageVideoState, false, 0, true);
		}

		protected function onStageVideoState(event:StageVideoAvailabilityEvent):void
		{
			var available:Boolean = (event.availability == StageVideoAvailability.AVAILABLE);
			trace("available", available);
			if (available)
				initStageVideo();
			else
				initVideo();
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
