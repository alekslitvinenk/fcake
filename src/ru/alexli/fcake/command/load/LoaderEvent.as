package ru.alexli.fcake.command.load
{
	import flash.events.Event;
	
	public class LoaderEvent extends Event
	{
		
		public static const LOADER_PROGRESS:String = "loader_progress";
		
		public var weight:Number = 0;
		
		public function LoaderEvent(type:String, weight:Number)
		{
			this.weight = weight;
			
			super(type, false, false);
		}
		
		override public function clone():Event{
			return new LoaderEvent(type, weight);
		}
	}
}