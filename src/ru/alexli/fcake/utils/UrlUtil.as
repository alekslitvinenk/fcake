package ru.alexli.fcake.utils
{
	public class UrlUtil
	{
		public static function isUrl(value:String):Boolean{
			return false;
		}
		
		public static function preventCache(value:String):String
		{
			return value + "?rand=" + Math.random();
		}
	}
}