package net.mg2013.display
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Quad;
	import com.greensock.loading.VideoLoader;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class VideoPlayerDefaultControls extends SpriteStageEvents implements IVideoControls
	{
		//////////////
		////////////// CONSTRUCTOR ------------------------------------------------------------------------------------------- CONSTRUCTOR //////////////////////
		//////////////
		private var __skinClass:Class;

		private var __videoPaused:Boolean;

		private var __playProgress:Number;

		private var __fullscreen:Boolean;

		private var __videoHeight:Number = 0;

		private var __videoWidth:Number = 0;

		private var __controlsBG:Sprite;

		private var __track:Sprite;

		private var __scrubber:Sprite;

		private var __trackBG:Sprite;

		private var __fullscreenButton:Sprite;

		private var __fullscreenExpandIcon:Sprite;

		private var __fullscreenCollapseIcon:Sprite;

		private var __pausePlayButton:Sprite;

		private var __pauseIcon:Sprite;

		private var __playIcon:Sprite;

		private var __videoLoader:VideoLoader;

		private var __stage:Stage;

		private var __skin:Sprite;

		private var __wasPlaying:Boolean = false;

		public function VideoPlayerDefaultControls()
		{
			super(true);
		}

		//////////////
		////////////// PUBLIC ------------------------------------------------------------------------------------------------ PUBLIC ///////////////////////////
		//////////////
		/**
		 * <p>This function initiates the control component.</p>
		 *
		 */
		public function initControls():void
		{
			addEventListener(MouseEvent.ROLL_OUT, videoRollEvent, false, 0, true);
			addEventListener(MouseEvent.ROLL_OVER, videoRollEvent, false, 0, true);
			initSkinClass();
			alignObjects();
		}

		public function show():void
		{
			TweenLite.to(this, .5, { alpha: 1, ease: Quad.easeOut, overwrite: "all" });
		}

		public function hide():void
		{
			TweenLite.to(this, .5, { alpha: 0, ease: Quad.easeOut, overwrite: "all" });
		}

		//////////////
		////////////// OVERRIDE PUBLIC --------------------------------------------------------------------------------------- OVERRIDE PUBLIC //////////////////
		//////////////
		override public function dispose():void
		{
			super.dispose();
		}

		//////////////
		////////////// PROTECTED --------------------------------------------------------------------------------------------- PROTECTED ////////////////////////
		//////////////
		protected function alignObjects():void
		{
			graphics.clear();
			graphics.beginFill(0x000000, 0);
			graphics.drawRect(0, 0, videoWidth, videoHeight);
			if (__controlsBG)
				__controlsBG.width = __videoWidth - 50;
			if (__skin)
				__skin.y = __videoHeight - __skin.height - 25;
			if (__trackBG)
				__trackBG.width = __videoWidth - 50 - 26 - 40 - 40;
			if (__fullscreenButton)
				__fullscreenButton.x = __controlsBG.x + __controlsBG.width - 40;
		}

		protected function initSkinClass():void
		{
			__skin = Sprite(new __skinClass());
			addChild(__skin);
			trace(__skin.numChildren);
			for (var i:int = 0; i < __skin.numChildren; i++)
			{
				trace(__skin.getChildAt(i).name);
			}
			__controlsBG = __skin.getChildByName("bg") as Sprite;
			__track = __skin.getChildByName("track") as Sprite;
			__scrubber = __track.getChildByName("scrubber") as Sprite;
			__trackBG = __track.getChildByName("trackBG") as Sprite;
			__fullscreenButton = __skin.getChildByName("fullscreenButton") as Sprite;
			__fullscreenExpandIcon = __fullscreenButton.getChildByName("ExpandIcon") as Sprite;
			__fullscreenCollapseIcon = __fullscreenButton.getChildByName("CollapseIcon") as Sprite;
			__pausePlayButton = __skin.getChildByName("pausePlayButton") as Sprite;
			__pauseIcon = __pausePlayButton.getChildByName("pauseIcon") as Sprite;
			__playIcon = __pausePlayButton.getChildByName("playIcon") as Sprite;
			//////
			__scrubber.mouseEnabled = false;
			__trackBG.buttonMode = true;
			__trackBG.tabChildren = __trackBG.tabEnabled = __trackBG.mouseChildren = false;
			__trackBG.addEventListener(MouseEvent.MOUSE_DOWN, trackDownEvent, false, 0, true);
			__fullscreenButton.addEventListener(MouseEvent.CLICK, fullscreenClickEvent, false, 0, true);
			__fullscreenButton.buttonMode = true;
			__fullscreenCollapseIcon.visible = false;
			__pausePlayButton.addEventListener(MouseEvent.CLICK, pausePlayClickEvent, false, 0, true);
			__pausePlayButton.buttonMode = true;
			__pausePlayButton.tabChildren = __pausePlayButton.tabEnabled = __pausePlayButton.mouseChildren = false;
			__skin.x = 25;
			__skin.y = __videoHeight - __skin.height - 25;
		}

		protected function initVideoLoader():void
		{
			__videoLoader
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
					if (__skin)
						TweenLite.to(__skin, .5, { alpha: 0, ease: Quad.easeOut, overwrite: "all" });
					break;
				case MouseEvent.ROLL_OVER:
					if (__skin)
						TweenLite.to(__skin, .5, { alpha: 1, ease: Quad.easeOut, overwrite: "all" });
					break;
			}
		}

		protected function pausePlayClickEvent(event:MouseEvent):void
		{
			if (!__videoLoader)
				return;
			__videoLoader.videoPaused = !__videoLoader.videoPaused;
			__wasPlaying = !__videoLoader.videoPaused;
		}

		protected function fullscreenClickEvent(event:MouseEvent):void
		{
			if (stage.displayState == StageDisplayState.NORMAL)
				stage.displayState = StageDisplayState.FULL_SCREEN;
			else
				stage.displayState = StageDisplayState.NORMAL;
		}

		protected function trackDownEvent(event:MouseEvent):void
		{
			mouseMoveEvent(null);
			if (__videoLoader)
				__videoLoader.videoPaused = true;
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
			trace("__wasPlaying", __wasPlaying);
			if (__videoLoader)
				__videoLoader.videoPaused = !__wasPlaying;
		}

		protected function mouseMoveEvent(event:MouseEvent):void
		{
			var mx:Number = __trackBG.mouseX * __trackBG.scaleX;
			var nx:Number = mx < 0 ? 0 : mx > __trackBG.width ? __trackBG.width : mx;
			var pr:Number = nx / __trackBG.width;
			if (__videoLoader)
				__videoLoader.playProgress = pr;
			__scrubber.x = (__trackBG.width - __scrubber.width) * pr;
		}

		//////////////
		////////////// OVERRIDE MOUSE EVENTS --------------------------------------------------------------------------------- OVERRIDE MOUSE EVENTS ////////////
		//////////////
		//////////////
		////////////// EVENTS ------------------------------------------------------------------------------------------------ EVENTS ///////////////////////////
		//////////////
		//////////////
		////////////// OVERRIDE EVENTS --------------------------------------------------------------------------------------- OVERRIDE EVENTS //////////////////
		//////////////
		override protected function addedToStage(event:Event):void
		{
			super.addedToStage(event);
			__stage = stage;
		}

		//////////////
		////////////// GET & SET --------------------------------------------------------------------------------------------- GET & SET ////////////////////////
		//////////////
		public function set skinClass(value:Class):void
		{
			__skinClass = value;
		}

		public function set videoLoader(value:VideoLoader):void
		{
			__videoLoader = value;
			initVideoLoader();
		}

		public function get videoPaused():Boolean
		{
			return __videoPaused;
		}

		public function set videoPaused(value:Boolean):void
		{
			__videoPaused = value;
			if (value)
			{
				if (__pauseIcon)
					__pauseIcon.visible = false;
				if (__playIcon)
					__playIcon.visible = true;
			}
			else
			{
				if (__pauseIcon)
					__pauseIcon.visible = true;
				if (__playIcon)
					__playIcon.visible = false;
			}
		}

		public function get playProgress():Number
		{
			return __playProgress;
		}

		public function set playProgress(value:Number):void
		{
			__playProgress = value;
			__scrubber.x = (__trackBG.width - __scrubber.width) * __videoLoader.playProgress;
		}

		public function get fullscreen():Boolean
		{
			return __fullscreen;
		}

		public function set fullscreen(value:Boolean):void
		{
			__fullscreen = value;
			if (value)
			{
				__fullscreenCollapseIcon.visible = true;
				__fullscreenExpandIcon.visible = false;
			}
			else
			{
				__fullscreenCollapseIcon.visible = false;
				__fullscreenExpandIcon.visible = true;
			}
		}

		public function get videoHeight():Number
		{
			return __videoHeight;
		}

		public function set videoHeight(value:Number):void
		{
			__videoHeight = value;
			alignObjects();
		}

		public function get videoWidth():Number
		{
			return __videoWidth;
		}

		public function set videoWidth(value:Number):void
		{
			__videoWidth = value;
			alignObjects();
		}

		public function get wasPlaying():Boolean
		{
			return __wasPlaying;
		}

		public function set wasPlaying(value:Boolean):void
		{
			__wasPlaying = value;
		}
		//////////////
		////////////// OVERRIDE GET & SET ------------------------------------------------------------------------------------ OVERRIDE GET & SET ///////////////
		//////////////
	}
}
