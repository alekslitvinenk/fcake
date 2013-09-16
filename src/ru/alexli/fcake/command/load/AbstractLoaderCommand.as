package ru.alexli.fcake.command.load
{
	import ru.alexli.fcake.command.AbstractCommand;
	
	/**
	 * Абстрактная комманда для загрузки данных.
	 * Позволяет задать относительный вес в общем списке загрузокы
	 *  
	 * @author alexander
	 * 
	 */	
	public class AbstractLoaderCommand extends AbstractCommand
	{
		
		public var weight:Number;
		
		public function AbstractLoaderCommand(weight:Number)
		{
			this.weight = weight;
		}
	}
}