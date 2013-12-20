package ru.alexli.fcake.view.ui.button
{
	import flash.events.Event;
	

	public class UIToggleButton extends UIButton
	{
		public static var instances:Array = [];
		
		public function UIToggleButton()
		{
			super();
		}
		
		override protected function onShow():void
		{
			super.onShow();
			
			instances.push(this);
			
			if(toggled)
			{
				if(state == NORMAL_STATE)
				{
					state = DOWN_STATE;
					
					unlistenToMouse();
				}
			}
		}
		
		override protected function onHide():void
		{
			super.onHide();
			
			for(var i:uint = 0; i < instances.length; i++)
			{
				if(instances[i] == this)
				{
					instances.splice(i, 1);
					break;
				}
			}
		}
		
		protected var toggled:Boolean;
		
		public function toggle():void
		{
			if(stage)
			{
				if(state == NORMAL_STATE)
				{
					state = DOWN_STATE;
					
					unlistenToMouse();
				}
			}
			
			toggled = !toggled;
		}
		
		override protected function onMouseClick(evt:Event):void
		{
			super.onMouseClick(evt);
			
			toggle();
			
			for(var i:uint = 0; i < instances.length; i++)
			{
				if(instances[i] != this)
				{
					(instances[i] as UIToggleButton).state = NORMAL_STATE;
					(instances[i] as UIToggleButton).listenToMouse();
				}
			}
		}
	}
}