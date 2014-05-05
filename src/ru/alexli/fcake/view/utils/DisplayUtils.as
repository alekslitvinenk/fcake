package ru.alexli.fcake.view.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;

	public class DisplayUtils
	{
		/**
		 * Creates Bitmap from BitmapData object
		 *  
		 * @param bitmapData
		 * @return 
		 * 
		 */		
		public static function createBitmapFromBitmapDta(bitmapData:BitmapData):Bitmap
		{
			var bmp:Bitmap = new Bitmap(BitmapData(bitmapData));
			bmp.smoothing = true;
			
			return bmp;
		}
		
		public static function sampleBitmapData(source:BitmapData, width:Number, height:Number):BitmapData
		{
			var target:BitmapData = new BitmapData(width, height, true, 0);
			
			var mtx:Matrix = new Matrix();
			mtx.scale(target.width/source.width, target.height/source.height);
			
			target.draw(source, mtx, null, null, null, true);
			
			source.dispose();
			
			return target;
		}
	}
}