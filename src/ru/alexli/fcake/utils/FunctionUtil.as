package ru.alexli.fcake.utils
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class FunctionUtil
	{
		
		private static var _sprite:Sprite;
		
		private static var callLaterFramesElapsed:uint;
		
		private static var callLaterObjs:Array = [];
		
		private static function get sprite():Sprite{
			if(!_sprite){
				_sprite = new Sprite();
			}
			return _sprite;
		}
		
		public static function callLater(func:Function, args:Array = null, frames:uint = 1):void{
			
			if(!callLaterObjs[callLaterFramesElapsed + frames]){
				callLaterObjs[callLaterFramesElapsed + frames] = [];
			}
			callLaterObjs[callLaterFramesElapsed + frames].push({func:func, args:args, frames:frames});
			
			if(!sprite.hasEventListener(Event.ENTER_FRAME)){
				sprite.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
		}
		
		private static function onEnterFrame(evt:Event):void{
			
			callLaterFramesElapsed++;
			
			if(callLaterObjs[callLaterFramesElapsed] && callLaterObjs[callLaterFramesElapsed].length){
				
				for(var i:uint = 0; i < callLaterObjs[callLaterFramesElapsed].length; i++){
					var callObj:Object = callLaterObjs[callLaterFramesElapsed][i];
					
					if(callObj.func){
						callObj.func.apply(null, callObj.args);
					}
				}
			}
			
		}
	}
}