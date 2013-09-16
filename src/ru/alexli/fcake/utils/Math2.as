package ru.alexli.fcake.utils
{
	public class Math2
	{
		public static function randomRange(val1:Number, val2:Number):Number{
			var diff:Number = val2 - val1;
			
			return Math.round(Math.random() * diff + val1);
		}
		
		public static function gradToRad(val:Number):Number{
			return (val * Math.PI)/180;
		}
	}
}