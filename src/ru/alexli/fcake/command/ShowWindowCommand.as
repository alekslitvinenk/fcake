package ru.alexli.fcake.command
{
	import flash.events.Event;
	
	import ru.alexli.fcake.command.AbstractCommand;
	import ru.alexli.fcake.view.ui.window.AbstractWindow;
	import ru.alexli.fcake.view.ui.window.WindowEvent;
	import ru.alexli.fcake.window.WindowManager;
	
	public class ShowWindowCommand extends AbstractCommand
	{
		protected var windowName:String;
		protected var params:Object;
		protected var waitForClose:Boolean;
		
		public function ShowWindowCommand(windowName:String, params:Object = null, waitForClose:Boolean = false)
		{
			this.windowName = windowName;
			this.params = params;
			this.waitForClose = waitForClose;
		}
		
		override protected function execInternal():void
		{
			var win:AbstractWindow = WindowManager.instance.showWindow(windowName, params);
			
			if(waitForClose)
			{
				win.addEventListener(WindowEvent.WINDOW_CLOSE, onWindowClose);
			}else{
				notifyComplete();
			}
		}
		
		//evenst
		protected function onWindowClose(evt:Event):void{
			notifyComplete();
		}
	}
}