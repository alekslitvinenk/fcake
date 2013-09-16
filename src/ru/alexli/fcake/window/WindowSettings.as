package ru.alexli.fcake.window
{
	
	/**
	 * Настройки отображения окна
	 *  
	 * @author alexander
	 * 
	 */	
	public class WindowSettings
	{
		
		public var policy:int;
		public var modal:Boolean;
		public var cache:Boolean;
		public var parent:Array;
		
		public function WindowSettings(policy:int, modal:Boolean = false, cache:Boolean = true, parent:Array = null)
		{
			this.policy = policy;
			this.modal = modal;
			this.cache = cache;
			this.parent = parent;
		}
	}
}