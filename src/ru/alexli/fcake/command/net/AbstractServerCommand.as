package ru.alexli.fcake.command.net
{
	import com.adobe.serialization.json.JSON;
	
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getTimer;
	
	import ru.alexli.fcake.command.AbstractCommand;
	import ru.alexli.fcake.utils.log.Logger;
	
	/**
	 * Базовый класс команды отправки запроса к серверу
	 *  
	 * @author Alexander Litvinenko
	 * 
	 */	
	public class AbstractServerCommand extends AbstractCommand
	{
		
		protected var data:Object = {};
		
		protected var loader:URLLoader = new URLLoader();
		
		protected var command:String;
		
		/**
		 * URL нужно переопределить в классе-наследнике 
		 */		
		protected var url:String;
		
		public function AbstractServerCommand()
		{
			if (getQualifiedClassName(this) == getQualifiedClassName(AbstractServerCommand)) {
				throw new IllegalOperationError('Error: '+getQualifiedClassName(this)+' class cannot be instantiated.');
			}
		}
		
		override protected function execInternal():void{
			
			Logger.debug("url:", url);
			var req:URLRequest = new URLRequest(url);
			
			req.data = data;
			loader.addEventListener(Event.COMPLETE, onServerResponse);//, false, 0, true);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onError);
			loader.load(req);
			
			Logger.debug("ServerRequest", command, "Sent params:", data);
		}
		
		protected function parseServerResponse(data:Object):void{
			
		}
		
		protected function onServerResponse(evt:Event):void{
			
			var obj:Object = URLLoader(evt.target).data;
			
			Logger.debug("ServerResponse", command, obj);
			
			try{
				var data:Object = JSON.decode(String(obj));
			}catch(err:Error){
				Logger.error("JSON ERROR", err);
				notifyComplete();
				return;
			}
			
			parseServerResponse(data);
			notifyComplete();
		}
		
		protected function onError(err:Object):void{
			Logger.error("Server Error", err);
		}
	}
}