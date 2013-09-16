package ru.alexli.fcake.utils.log
{
	import flash.external.ExternalInterface;
	
	/**
	 * Вывод логгера в консоль браузера 
	 * @author Alexander Litvinenko
	 * 
	 */	
	public class BrowserConsoleTarget extends AbstractLogTarget
	{
		
		public function BrowserConsoleTarget(level:uint)
		{
			super(level);
		}
		
		override protected function internalSend(val:LogMessageVO):void
		{
			if(ExternalInterface.available){
				try{
					
					sendToJS(Logger.levelMap[val.level] + " " + val.time);
					
					var valArr:Array = val.message.split("\n");
					for(var i:uint = 0; i < valArr.length; ++i){
						sendToJS(valArr[i]);
					}
				}catch(err:Error){
					
				}
			}
		}
		
		private function sendToJS(msg:*):void{
			ExternalInterface.call("function(){try{window.console.log('" + String(msg) + "')}catch(e){}}");
		}
	}
}