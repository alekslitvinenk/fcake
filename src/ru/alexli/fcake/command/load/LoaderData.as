package ru.alexli.fcake.command.load
{
	import ru.alexli.fcake.command.AbstractCommand;
	
	/**
	 * Данные для команды-загрузчика
	 *  
	 * @author Alexander Litvinenko
	 * 
	 */	
	public class LoaderData
	{
		
		/**
		 * Команда, чей прогресс в обшем процессе загрузки необходимо отобразить 
		 */		
		public var cmd:AbstractCommand;
		
		/**
		 * Относительный вес команды в общем процессе загрузки 
		 */		
		public var weight:Number;
		
		public function LoaderData(cmd:AbstractCommand, weight:Number = 0)
		{
			this.cmd 	= cmd;
			this.weight = weight;
		}
	}
}