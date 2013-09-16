package ru.alexli.fcake.command
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import ru.alexli.fcake.utils.log.Logger;
	
	[Event(name="complete", type="flash.events.Event")]
	/**
	 * Базовый класс для комманд 
	 * @author Alexander Litvinenko
	 */
	public class AbstractCommand extends EventDispatcher
	{
		
		/**
		 * Массив ссылок на запущенные экземпляры комманд
		 */		
		private static var runningInstances:Array = new Array();
		
		/**
		 * Конструктор 
		 * 
		 */		
		public function AbstractCommand()
		{
		}
		
		/**
		 * Начинает выполнение комманды 
		 * 
		 */		
		public function execute():void{
			runningInstances[runningInstances.length] = this;
			//try{
				execInternal();
			/*}catch(err:Error){
				Logger.error("AbstractCommand:" ,err);
			}*/
		}
		
		/**
		 * Фактически исполняемый код комманды.
		 * Необходимо переопределить в потомках
		 * 
		 */		
		protected function execInternal():void{
			
		}
		
		/**
		 * Метод, который удаляет ссылку на свой экземпляр из кеша и
		 * бросает событие complete.
		 * Этот метод нужно вызывать вручную после того как команда выполнила все необходимые действия
		 * 
		 */		
		protected function notifyComplete():void{
			var len:uint = runningInstances.length;
			for(var i:uint = 0; i < len; ++i){
				if(runningInstances[i] === this){
					runningInstances.splice(i, 1);
					break;
				}
			}
			dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}