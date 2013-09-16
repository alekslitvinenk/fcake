package ru.alexli.fcake.controller
{
	import mx.binding.utils.BindingUtils;
	
	/**
	 * Базовый класс контроллера
	 *  
	 * @author Alexander Litvinenko
	 * 
	 */	
	public class AbstractController
	{
		
		/**
		 * Массив объектов слушателей изменений 
		 */		
		private var changeWatchers:Array = new Array();
		
		public function AbstractController()
		{
		}
		
		/**
		 * Изменяет свойство одного объекта при изменении свойств другого объекта 
		 * @param site объект назначения (свойства которого будут изменяться
		 * в ответ на изменения свойств целевого объекта)
		 * @param prop свойство, которое будет изменяться на объекте назначения
		 * @param host целевой объект (за изменением свойств которого будем следить)
		 * @param chain путь к свойству целевого объекта,
		 * за изменением свойств которого будем следить
		 * 
		 */		
		protected function bindProp(site:Object, prop:String, host:Object, chain:String):void{
			changeWatchers[changeWatchers.length] = BindingUtils.bindProperty(site, prop, host, chain);
		}
		
		/**
		 * Связывает функцию-сеттер со свойством целевого объекта.
		 * Назначенная функция будет вызываться в ответ на изменения свойства целевого объекта
		 * @param setter функция, которая будет вызываться в ответ на изменения свойства целевого объекта
		 * @param host целевой объект (за изменением свойств которого будем следить)
		 * @param chain путь к свойству целевого объекта,
		 * за изменением свойств которого будем следить
		 * 
		 */		
		protected function bindSetter(setter:Function, host:Object, chain:Object):void{
			changeWatchers[changeWatchers.length] = BindingUtils.bindSetter(setter, host, chain);
		}
		
		/**
		 * Содержит все объявления биндинга 
		 * 
		 */		
		protected function addBindings():void{
			
		}
		
		/**
		 * Удаляет все биндинги 
		 * 
		 */		
		protected function removeBindings():void{
			var len:uint = changeWatchers.length;
			for(var i:uint = 0; i < len; i++){
				changeWatchers[i].unwatch();
				changeWatchers[i] = null;
			}
			changeWatchers = new Array();
		}
	}
}