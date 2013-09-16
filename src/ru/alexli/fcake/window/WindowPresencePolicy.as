package ru.alexli.fcake.window
{
	
	/**
	 * Политики показа окон
	 *  
	 * @author alexander
	 * 
	 */	
	public class WindowPresencePolicy
	{
		
		/**
		 * Политика при которой на сцене может быть только одно окно
		 * (то, которое необхдимо показать в данный момент) 
		 */		
		public static const SINGLE:int 			= 1;
		
		/**
		 * Поитика при которой окно добавляется новым слоем в стопку слоев с открытими окнами 
		 */		
		public static const ADD:int				= 2;
		
		/**
		 * Замещает текущее открытое окно новым 
		 */		
		public static const REPLACE:int			= 4;
		
		/**
		 * Политика, при которой все остальные окна закрываются, и показы других окон игнорируются 
		 */		
		public static const TERMINATE:int		= 8;
		
		/**
		 * Ставит окно в очередь на отображение 
		 */		
		public static const SEQUENCE:int		= 16;
		
	}
}