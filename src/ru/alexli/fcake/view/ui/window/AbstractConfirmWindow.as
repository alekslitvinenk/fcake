package ru.alexli.fcake.view.ui.window
{
	[Event(name="window_status_ok", type="ru.finam.games.islands.view.ui.WindowEvent")]
	[Event(name="window_status_cancel", type="ru.finam.games.islands.view.ui.WindowEvent")]
	public class AbstractConfirmWindow extends AbstractWindow
	{
		public function AbstractConfirmWindow(id:String=null)
		{
			super(id);
		}
		
		protected function notifyStatusOk():void
		{
			dispatchEvent(new WindowEvent(WindowEvent.WINDOW_STATUS_OK));
			close();
		}
		
		protected function notifyStatusCancel():void
		{
			dispatchEvent(new WindowEvent(WindowEvent.WINDOW_STATUS_CANCEL));
			close();
		}
	}
}