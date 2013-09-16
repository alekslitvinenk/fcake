package ru.alexli.fcake.command
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class WaitCommand extends AbstractCommand
	{
		
		private var delay:Number;
		
		public function WaitCommand(delay:Number)
		{
			this.delay = delay;
		}
		
		override protected function execInternal():void{
			var timer:Timer = new Timer(delay, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			timer.start();
		}
		
		private function onTimerComplete(evt:TimerEvent):void{
			notifyComplete();
		}
	}
}