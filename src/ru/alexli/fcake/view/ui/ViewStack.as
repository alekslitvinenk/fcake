package ru.alexli.fcake.view.ui
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import ru.alexli.fcake.view.AbstractVisualObject;
	
	[Event(name="change", type="flash.events.Event")]
	public class ViewStack extends AbstractVisualObject
	{
		private var states:Array = [];
		
		public function ViewStack()
		{
			super();
		}
		
		override protected function onShow():void
		{
			super.onShow();
			
			addEventListener(Event.ADDED, onItemAdded);
		}
		
		override protected function onHide():void
		{
			super.onHide();
			
			removeEventListener(Event.ADDED, onItemAdded);
		}
		
		public function registerState(state:String, view:DisplayObject):void
		{
			states[state] = view;
		}
		
		private var _state:String;
		
		public function get state():String
		{
			return _state;
		}
		
		public function set state(value:String):void
		{
			_state = value;
			
			if(states[value])
			{
				exitState(value);
				enterState(value);
			}
		}
		
		protected function exitState(val:String):void
		{
			while(numChildren)
			{
				removeChildAt(0);
			}
		}
		
		protected function enterState(val:String):void
		{
			addChild(states[val]);
		}
		
		private function notifyChange():void
		{
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		//events
		private function onItemAdded(evt:Event):void
		{
			evt.stopImmediatePropagation();
			
			if((evt.target as DisplayObject).parent == this){
				notifyChange();
			}
		}
	}
}