package ru.alexli.fcake.view.skinable
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	
	import ru.alexli.fcake.utils.log.Logger;
	import ru.alexli.fcake.view.AbstractVisualObject;
	import ru.alexli.fcake.view.utils.DisplayUtils;
	
	[Event(name="change", type="flash.events.Event")]
	public class Skin extends AbstractVisualObject
	{
		private var container:Sprite;
		private var display:DisplayObject;
		
		public function Skin(src:String = null)
		{
			if(src)
			{
				_src = src;
				commitData();
			}
		}
		
		override protected function init():void
		{
			super.init();
			
			addChild(container = new Sprite());
			container.addEventListener(Event.ADDED, onItemAdded);
			
			if(_src)
			{
				commitData();
			}
		}
		
		private var _src:String;
		
		public function get src():String
		{
			return _src;
		}
		
		public function set src(value:String):void
		{
			if(value != _src){
				_src = value;
				commitData();
			}
		}
		
		public function get content():DisplayObject
		{
			return display;
		}
		
		private function commitData():void
		{
			var skinClass:Class;
			
			try{
				skinClass = fetchClassByName(_src);
			}catch(err:Error){
				Logger.error(err.message);
			}
			
			if(skinClass)
			{
				if(container.numChildren)
				{
					container.removeChildAt(0);
				}
				
				var instance:Object = new skinClass();
				
				if(instance is BitmapData)
				{
					display = DisplayUtils.createBitmapFromBitmapDta(instance as BitmapData);
				}else{
					display = instance as DisplayObject;
				}
				
				container.addChild(display);
			}
		}
		
		protected function fetchClassByName(name:String):Class
		{
			return getDefinitionByName(name) as Class;
		}
		
		//events
		private function onItemAdded(evt:Event):void
		{
			evt.stopImmediatePropagation();
			
			if((evt.target as DisplayObject).parent == container){
				dispatchEvent(new Event(Event.CHANGE));
			}
		}
	}
}