package ru.alexli.fcake.utils.log
{
	
	/**
	 * Получатель вывода логгирования 
	 * @author Alexander Litvinenko
	 * 
	 */	
	public interface IloggerTarget
	{
		
		function send(val:LogMessageVO):void;
		
	}
}