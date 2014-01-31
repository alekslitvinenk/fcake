package ru.alexli.fcake.view.ui
{
	import flash.display.DisplayObject;
	
	import ru.alexli.fcake.view.AbstractVisualObject;
	
	public class StateView extends AbstractVisualObject
	{
		public function StateView(view:DisplayObject)
		{
			addChild(view);
			
			super();
		}
		
		private var _viewStack:ViewStack;

		public function get viewStack():ViewStack
		{
			return _viewStack;
		}

		public function set viewStack(value:ViewStack):void
		{
			_viewStack = value;
		}

	}
}