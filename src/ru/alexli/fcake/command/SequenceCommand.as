package ru.alexli.fcake.command
{
	import flash.events.Event;
	
	/**
	 * Псоледовательность комманд 
	 * @author Alexander Litvinenko
	 * 
	 */	
	public class SequenceCommand extends AbstractCommand
	{
		
		protected var sequence:Array = new Array();
		
		public function SequenceCommand(sequence:Array = null)
		{
			if(sequence)
				this.sequence = sequence;
		}
		
		/**
		 * Добавляет комманду в очередь исполнения
		 * 
		 */		
		public function add(command:AbstractCommand):void{
			sequence[sequence.length] = command;
		}
		
		override protected function execInternal():void{
			runNext();
		}
		
		/**
		 * Запускает следующаю комманду из очереди 
		 * 
		 */		
		protected function runNext():void{
			var cmd:AbstractCommand = sequence.shift();
			if(!cmd){
				notifyComplete();
				return;
			}
			cmd.addEventListener(Event.COMPLETE, onCommandComplete);
			cmd.execute();
		}
		
		protected function onCommandComplete(evt:Event):void{
			var cmd:AbstractCommand = evt.target as AbstractCommand;
			cmd.removeEventListener(Event.COMPLETE, onCommandComplete);
			runNext();
		}
	}
}