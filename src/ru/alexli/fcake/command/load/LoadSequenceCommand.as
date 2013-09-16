package ru.alexli.fcake.command.load
{
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	
	import ru.alexli.fcake.command.AbstractCommand;
	import ru.alexli.fcake.command.SequenceCommand;

	[Event(name="loader_progress", type="ru.alexli.fcake.command.load.LoaderEvent")]
	public class LoadSequenceCommand extends SequenceCommand
	{
		
		private var currentLoader:LoaderData;
		
		public function LoadSequenceCommand()
		{
			super(null);
		}
		
		public function addLoader(loader:LoaderData):void{
			sequence[sequence.length] = loader;
		}
		
		override public function add(command:AbstractCommand):void{
			throw new IllegalOperationError("This method is forbiden here");
		}
		
		override protected function runNext():void{
			
			currentLoader = sequence.shift();
			
			if(!currentLoader){
				notifyComplete();
				return;
			}
			
			var cmd:AbstractCommand = currentLoader.cmd;
			cmd.addEventListener(Event.COMPLETE, onCommandComplete);
			cmd.execute();
		}
		
		override protected function onCommandComplete(evt:Event):void{
			
			dispatchEvent(new LoaderEvent(LoaderEvent.LOADER_PROGRESS, currentLoader.weight));
			
			super.onCommandComplete(evt);
		}
	}
}