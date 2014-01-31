package ru.alexli.fcake.utils
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;

	public class TimerUtil
	{
		private static var ticker:Timer;
		
		private static var map:Dictionary = new Dictionary();
		
		public static function getTicker():Timer
		{
			if(!ticker){
				ticker = new Timer(1000);
				ticker.start();
			}
			
			return ticker;
		}
		
		public static function callLater(func:Function, args:Array, time:Number):void
		{
			var timer:Timer = new Timer(time * 1000, 1);
			
			var f:Function = function(evt:Event):void
			{
				func.apply(null, args);
				
				timer.removeEventListener(TimerEvent.TIMER_COMPLETE, arguments.callee);
				
				map[func] = null;
				delete map[func];
			}
				
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, f);
			timer.start();
			
			map[func] = {t: timer, f: f};
		}
		
		public static function removeCallLater(func:Function):void
		{
			var obj:Object = map[func];
			
			if(obj)
			{
				var timer:Timer = obj.t;
				
				var f:Function = obj.f;
				
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER_COMPLETE, f);
				
				map[func] = null;
				delete map[func];
			}
		}
	}
}