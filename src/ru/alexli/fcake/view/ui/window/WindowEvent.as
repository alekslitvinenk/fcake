package ru.alexli.fcake.view.ui.window
{
	import flash.events.Event;
	
	/**
	 * События окна
	 *  
	 * @author Alexander Litvinenko
	 * 
	 */	
	public class WindowEvent extends Event
	{
		public static const WINDOW_CLOSE:String = "window_close";
		public static const WINDOW_STATUS_OK:String = "window_status_ok";
		public static const WINDOW_STATUS_CANCEL:String = "window_status_cancel";
		
		public var status:String;
		
		public function WindowEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event{
			return new WindowEvent(type, bubbles, cancelable);
		}
	}
}