package net.mg2013.utils
{
	import flash.display.*;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.AntiAliasType;
	import flash.text.GridFitType;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	
	public class MGDisplayTools
	{
		public static function RectangleMovieClip(target:*, params_obj:Object):MovieClip
		{
			//trace(params_obj.alpha)
			var mc:MovieClip = new MovieClip()
			mc.name = params_obj.name ? params_obj.name : (Math.random() * 10000).toString().split(".")[0]
			if (params_obj.color || params_obj.color == 0)
				mc.graphics.beginFill(params_obj.color, params_obj.coloralpha ? params_obj.coloralpha : 0)
			else
				mc.graphics.beginFill(0xFF0000, params_obj.coloralpha ? params_obj.coloralpha : 0)
			mc.graphics.drawRect(0, 0, params_obj.width ? params_obj.width : 10, params_obj.height ? params_obj.height : 10);
			mc.graphics.endFill();
			mc.x = params_obj.x ? params_obj.x : 0
			mc.y = params_obj.y ? params_obj.y : 0
			//mc.alpha = params_obj.alpha ? 1 : params_obj.alpha
			mc.tabEnabled = params_obj.tabEnabled ? true : false
			mc.mouseEnabled = params_obj.mouseEnabled ? params_obj.mouseEnabled : false
			if (params_obj.buttonMode)
			{
				mc.mouseEnabled = true;
				mc.buttonMode = params_obj.buttonMode;
			}
			target.addChild(mc);
			return mc
		}
		
		public static function removeAllChildren(d:DisplayObjectContainer, offset:int=0):void
		{
			while (d.numChildren - offset)
			{
				d.removeChildAt(0);
			}
		}
		
		public static function CSSTextfield(target:*, css:StyleSheet, params_obj:Object):TextField
		{
			var mc:TextField = new TextField()
			mc.type = TextFieldType.DYNAMIC
			mc.condenseWhite = true
			target.addChild(mc);
			mc.styleSheet = css;
			if (params_obj.x)
			{
				mc.x = params_obj.x;
			}
			if (params_obj.y)
			{
				mc.y = params_obj.y;
			}
			if (params_obj.width)
			{
				mc.width = params_obj.width;
			}
			if (params_obj.height)
			{
				mc.height = params_obj.height;
			}
			if (params_obj.rotation)
			{
				mc.rotation = params_obj.rotation
			}
			if (params_obj.alpha)
			{
				mc.alpha = params_obj.alpha;
			}
			if (params_obj.wordWrap)
			{
				mc.wordWrap = params_obj.wordWrap;
			}
			if (params_obj.antiAliasType == AntiAliasType.ADVANCED)
			{
				mc.antiAliasType = AntiAliasType.ADVANCED
			}
			else
				mc.antiAliasType = AntiAliasType.ADVANCED
			mc.gridFitType = GridFitType.PIXEL
			if (params_obj.autoSize)
			{
				try
				{
					mc.autoSize = params_obj.autoSize
				}
				catch (e:Error)
				{
					mc.autoSize = TextFieldAutoSize.LEFT;
					mc.wordWrap = false
				}
			}
			else
			{
				mc.autoSize = TextFieldAutoSize.LEFT;
			}
			if (params_obj.border)
			{
				mc.border = params_obj.border;
			}
			if (params_obj.embedFonts)
			{
				mc.embedFonts = params_obj.embedFonts;
			}
			if (params_obj.mouseEnabled)
			{
				mc.mouseEnabled = params_obj.mouseEnabled;
			}
			else if (!params_obj.mouseEnabled)
				mc.mouseEnabled = false
			if (params_obj.multiline)
			{
				mc.multiline = params_obj.multiline;
			}
			if (params_obj.name)
			{
				mc.name = params_obj.name;
			}
			if (params_obj.selectable)
			{
				mc.selectable = params_obj.selectable;
				mc.mouseEnabled = true;
			}
			else
				mc.selectable = false
			if (params_obj.tabEnabled)
			{
				mc.tabEnabled = true
			}
			else
			{
				mc.tabEnabled = false
			}
			if (params_obj.text)
			{
				mc.htmlText = params_obj.text;
			}
			return mc
		}
		
		public static function fitToStage(dsp:DisplayObject, showAll:Boolean=false):void
		{
			var stage:Stage = dsp.stage
			var wRatio:Number = stage.stageWidth / dsp.width
			var hRatio:Number = stage.stageHeight / dsp.height
			var ratio:Number = wRatio > hRatio ? showAll ? hRatio : wRatio : showAll ? wRatio : hRatio
			
			dsp.width = dsp.width * ratio
			dsp.height = dsp.height * ratio
		}
		
		public static function fitToRectangle(dsp:DisplayObject, _rect:Rectangle, showAll:Boolean=false):void
		{
			var wRatio:Number = _rect.width / dsp.width
			var hRatio:Number = _rect.height / dsp.height
			var ratio:Number = wRatio > hRatio ? showAll ? hRatio : wRatio : showAll ? wRatio : hRatio
			dsp.width = dsp.width * ratio
			dsp.height = dsp.height * ratio
		}
		
		public static function ratioToRectangle(_rect1:Rectangle, _rect2:Rectangle, showAll:Boolean=false):Number
		{
			var wRatio:Number = _rect2.width / _rect1.width
			var hRatio:Number = _rect2.height / _rect1.height
			var ratio:Number = wRatio > hRatio ? showAll ? hRatio : wRatio : showAll ? wRatio : hRatio
			return ratio
		}
		
		public static function flipHorizontal(dsp:DisplayObject):void
		{
			var matrix:Matrix = dsp.transform.matrix;
			matrix.transformPoint(new Point(dsp.width / 2, dsp.height / 2));
			if (matrix.a > 0)
			{
				matrix.a = -1 * matrix.a;
				matrix.tx = dsp.width + dsp.x;
			}
			else
			{
				matrix.a = -1 * matrix.a;
				matrix.tx = dsp.x - dsp.width;
			}
			dsp.transform.matrix = matrix;
		}
		
		public static function flipVertical(dsp:DisplayObject):void
		{
			var matrix:Matrix = dsp.transform.matrix;
			matrix.transformPoint(new Point(dsp.width / 2, dsp.height / 2));
			if (matrix.d > 0)
			{
				matrix.d = -1 * matrix.d;
				matrix.ty = dsp.y + dsp.height;
			}
			else
			{
				matrix.d = -1 * matrix.d;
				matrix.ty = dsp.y - dsp.height;
			}
			dsp.transform.matrix = matrix;
		}
	}
}