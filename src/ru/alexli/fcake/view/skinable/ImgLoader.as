package ru.alexli.fcake.view.skinable
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	import ru.alexli.fcake.utils.log.Logger;
	import ru.alexli.fcake.view.AbstractVisualObject;
	
	[Event(name="change", type="flash.events.Event")]
	public class ImgLoader extends AbstractVisualObject
	{
		
		private var loader:Loader;
		
		public function ImgLoader()
		{
			super();
		}
		
		override protected function init():void{
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
			addChild(loader);
			
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
		
		private function commitData():void{
			loader.unload();
			loader.load(new URLRequest(_src));
		}
		
		//events
		private function onLoadComplete(evt:Event):void
		{
			(loader.content as Bitmap).smoothing = true;
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		private function onError(evt:IOErrorEvent):void
		{
			Logger.error("Resource can't be loaded: ", evt.target.url);
		}

	}
}