package ru.alexli.fcake.utils
{
	import flash.utils.Timer;

	public class TimerUtil
	{
		private static var ticker:Timer;
		
		public static function getTicker():Timer{
			if(!ticker){
				ticker = new Timer(1000);
				ticker.start();
			}
			
			return ticker;
		}
	}
}