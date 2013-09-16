package ru.alexli.fcake.command
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * Очереь комманд с задержкой между вызовами комманд из очереди
	 *  
	 * @author Alexander Litvinenko
	 * 
	 */	
	public class DelayedSequenceCommand extends SequenceCommand
	{
		
		private var delay:uint;
		
		/**
		 *  
		 * @param delay задержка в миллисекундах между вызовами комманд из очереди
		 * 
		 */		
		public function DelayedSequenceCommand(delay:uint)
		{
			this.delay = delay;
			super(null);
		}
		
		override protected function runNext():void{
			var t:Timer = new Timer(delay, 1);
			t.addEventListener(TimerEvent.TIMER_COMPLETE, onRunTimer);
			t.start();
		}
		
		private function onRunTimer(evt:TimerEvent):void{
			super.runNext();
		}
	}
}