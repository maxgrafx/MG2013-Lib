package net.mg2013.graphics
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.InterpolationMethod;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;
	
	public class Gradient
	{
		/**
		 *
		 * Gradient.verticalSingleColor(displayObject.graphics, [ 0x000000, 0x000000, 0x000000 ], [ 0, .1, .8 ], [ 0, 50, 255 ], 100, 30, 0, 0)
		 *
		 */
		public static function horizontalSingleColor(_graphics:Graphics, _colors:Array, _alphas:Array, _ratios:Array, _width:Number, _height:Number, _x:Number=0, _y:Number=0):void
		{
			var fType:String = GradientType.LINEAR;
			var matr:Matrix = new Matrix();
			matr.createGradientBox(_width, _height, 0, 0, 0)
			var sprMethod:String = SpreadMethod.PAD;
			_graphics.beginGradientFill(fType, _colors, _alphas, _ratios, matr, sprMethod);
			_graphics.drawRect(_x, _y, _width, _height);
		}
		
		public static function verticalSingleColor(_graphics:Graphics, _colors:Array, _alphas:Array, _ratios:Array, _width:Number, _height:Number, _x:Number=0, _y:Number=0):void
		{
			var fType:String = GradientType.LINEAR;
			var matr:Matrix = new Matrix();
			matr.createGradientBox(_width, _height, (Math.PI / 180) * 90, 0, 0)
			var sprMethod:String = SpreadMethod.PAD;
			_graphics.beginGradientFill(fType, _colors, _alphas, _ratios, matr, sprMethod, InterpolationMethod.RGB);
			_graphics.drawRect(_x, _y, _width, _height);
		}
		
		public static function vertical(_graphics:Graphics, _colors:Array, _alphas:Array, _ratios:Array, _width:Number, _height:Number, _x:Number=0, _y:Number=0):void
		{
			var fType:String = GradientType.LINEAR;
			var matr:Matrix = new Matrix();
			matr.createGradientBox(_width, _height, (Math.PI / 180) * 90, 0, 0)
			var sprMethod:String = SpreadMethod.PAD;
			_graphics.beginGradientFill(fType, _colors, _alphas, _ratios, matr, sprMethod);
		}
		
		public static function horizontal(_graphics:Graphics, _colors:Array, _alphas:Array, _ratios:Array, _width:Number, _height:Number, _x:Number=0, _y:Number=0):void
		{
			var fType:String = GradientType.LINEAR;
			var matr:Matrix = new Matrix();
			matr.createGradientBox(_width, _height, 0, 0, 0)
			var sprMethod:String = SpreadMethod.PAD;
			_graphics.beginGradientFill(fType, _colors, _alphas, _ratios, matr, sprMethod);
		}
	}
}