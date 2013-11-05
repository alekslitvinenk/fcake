package ru.alexli.fcake.utils.strings
{
	public class Formatter
	{
		public static function formatTime(val:Number):String
		{
			if(val/60 >= 1){
				return Math.floor(val/60) + ":" + checkDecimal(val % 60);
			}else{
				return checkDecimal(val);
			}
		}
		
		private static function checkDecimal(val:Number):String
		{
			if(val > 9){
				return String(val);
			}else{
				return ("0" + String(val));
			}
		}
	}
}