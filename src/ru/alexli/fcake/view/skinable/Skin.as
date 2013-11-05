package ru.alexli.fcake.view.skinable
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	
	import ru.alexli.fcake.utils.log.Logger;
	import ru.alexli.fcake.view.AbstractVisualObject;
	
	[Event(name="change", type="flash.events.Event")]
	public class Skin extends AbstractVisualObject
	{
		
		private var container:Sprite;
		
		public function Skin()
		{
			super();
		}
		
		override protected function init():void
		{
			addChild(container = new Sprite());
			container.addEventListener(Event.ADDED, onItemAdded);
			
			super.init();
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
		
		private function commitData():void
		{
			var skinClass:Class;
			
			try{
				skinClass = getDefinitionByName(_src) as Class;
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
				var display:DisplayObject;
				
				if(instance is BitmapData)
				{
					var bmp:Bitmap = new Bitmap(BitmapData(instance));
					bmp.smoothing = true;
					
					display = bmp;
				}else{
					display = instance as DisplayObject;
				}
				
				container.addChild(display);
			}
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