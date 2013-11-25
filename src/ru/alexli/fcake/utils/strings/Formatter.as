package ru.alexli.fcake.utils.strings
{
	public class Formatter
	{	
		public static function formatTime(val:Number):String
		{
			if(val/60 >= 1)
			{
				return Math.floor(val/60) + ":" + checkDecimal(val % 60);
			}else
			{
				return checkDecimal(val);
			}
		}
		
		public static function formatNumber(val:Number):String
		{
			var str:String = String(int(val));
			
			var arr:Array = [];
			
			var ranges:uint = str.length / 3;
			
			for(var i:uint = 0; i < ranges; i++)
			{
				arr.push(str.substr((str.length - 3) * i, 3));
			}
			
			if(str.length >= 3 && str.length % 3)
			{
				arr.push(str.substr(0, str.length % 3));
			}
			
			arr.reverse();
			
			return arr.join(" ");
		}
		
		private static function checkDecimal(val:Number):String
		{
			if(val > 9)
			{
				return String(val);
			}else
			{
				return ("0" + String(val));
			}
		}
	}
}