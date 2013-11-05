package ru.alexli.fcake.command
{
	import ru.alexli.fcake.view.ui.window.AbstractConfirmWindow;
	import ru.alexli.fcake.view.ui.window.WindowEvent;
	import ru.alexli.fcake.window.WindowManager;

	public class ShowConfirmWindowCommand extends ShowWindowCommand
	{
		public function ShowConfirmWindowCommand(windowName:String, params:Object=null, waitForClose:Boolean=false)
		{
			super(windowName, params, waitForClose);
		}
		
		override protected function execInternal():void
		{
			var win:AbstractConfirmWindow = WindowManager.instance.showWindow(windowName, params) as AbstractConfirmWindow;
			win.addEventListener(WindowEvent.WINDOW_STATUS_OK, onWindowStatus);
			win.addEventListener(WindowEvent.WINDOW_STATUS_CANCEL, onWindowStatus);
			win.addEventListener(WindowEvent.WINDOW_CLOSE, onWindowClose);
		}
		
		protected function onWindowStatus(evt:WindowEvent):void
		{
			dispatchEvent(evt);
		}
	}
}