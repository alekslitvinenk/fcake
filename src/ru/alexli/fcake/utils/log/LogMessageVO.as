package ru.alexli.fcake.utils.log
{
	
	/**
	 * Сообщение в логе
	 *  
	 * @author Alexander Litvinenko
	 * 
	 */	
	public class LogMessageVO
	{
		
		/**
		 * Уровень логирования 
		 */		
		public var level:uint;
		/**
		 * Сообщение 
		 */		
		public var message:String;
		/**
		 * Временная отметка сообщения 
		 */		
		public var time:uint;
		
		public function LogMessageVO()
		{
			super();
		}
		
		public function toString():String{
			var str:String = Logger.levelMap[level] + " " + time + "\n" + message;
			return str;
		}
	}
}