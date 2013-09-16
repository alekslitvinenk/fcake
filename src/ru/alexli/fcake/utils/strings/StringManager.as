package ru.alexli.fcake.utils.strings
{
	import ru.alexli.fcake.utils.strings.printf;
	
	/**
	 * Набор утилитных методов для работы со строками
	 *  
	 * @author alexander
	 * 
	 */	
	public class StringManager
	{
		
		private static var _strings:Object;
		
		public static function set strings(obj:Object):void{
			_strings = obj;
		}
		
		/**
		 * Возвращает строку из таблицы строк по ее идентификатору
		 *  
		 * @param id
		 * @param params
		 * @return 
		 * 
		 */		
		public static function getString(id:uint, ...params):String{
			if (!_strings)  return "String." + id;
			if (!_strings[id])  return "String." + id;
			
			var str:String = _strings[id];
			
			if(str){
				str = printf(str, params);
				return str;
			}
			return "String." + id;
		}
	}
}