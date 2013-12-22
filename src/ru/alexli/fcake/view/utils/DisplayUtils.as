package ru.alexli.fcake.view.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;

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
	}
}