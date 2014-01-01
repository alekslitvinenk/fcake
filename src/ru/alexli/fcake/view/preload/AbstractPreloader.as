package ru.alexli.fcake.view.preload
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	
	public class AbstractPreloader extends MovieClip
	{
		public var preloaderAnimation:IPreloaderAnimation;
		
		protected var mainClassName:String;
		
		protected var weight:Number;
		
		public function AbstractPreloader()
		{
			stop();
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.RESIZE, onStageResize);
			
			initPreleader();
			
			arrange();
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		protected function initPreleader():void
		{
			
		}
		
		protected function arrange():void
		{
			preloaderAnimation.display.x = stage.stageWidth/2 - preloaderAnimation.display.width/2;
			preloaderAnimation.display.y = stage.stageHeight/2 - preloaderAnimation.display.height/2;
		}
		
		protected function init():void
		{
			var mainClass:Class = Class(getDefinitionByName(mainClassName));
			var instance:DisplayObject = new mainClass();
			addChildAt(instance, 0);
		}
		
		//events
		private function onEnterFrame(evt:Event):void
		{
			if(framesLoaded == totalFrames)
			{
				preloaderAnimation.setProgress(weight);
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				nextFrame();
				init();
			}else
			{
				var bl:uint = root.loaderInfo.bytesLoaded;
				var bt:uint = root.loaderInfo.bytesTotal;
				
				var w:Number = (bl/bt) * weight;
				w = w > 0.5 ? weight : w;
				
				preloaderAnimation.setProgress(w);
			}
		}
		
		private function onStageResize(evt:Event):void
		{
			arrange();
		}
	}
}