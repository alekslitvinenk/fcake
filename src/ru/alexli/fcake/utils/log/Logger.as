package ru.alexli.fcake.utils.log
{
	import flash.system.System;
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getTimer;

	/**
	 * Класс содержащий набор методов для логирования
	 *  
	 * @author Alexander Litvinenko
	 * 
	 */	
	public class Logger
	{
		
		/**
		 * Карта уровней логирования 
		 */		
		public static const levelMap:Array = function():Array{
			var map:Array = [];
			map[LogLevel.DEBUG] = "[DEBUG]";
			map[LogLevel.ERROR] = "[ERROR]";
			
			return map;
		}();
		
		/**
		 * Список объектов, в которые можно направлять вывод логгера 
		 */		
		public static var targets:Array;
		
		/**
		 * Количество символов тубаляции 
		 */		
		private static var tabs:String = "";
		
		/**
		 * Простые типы данных, не содержащих определения свойств 
		 */		
		private static var simpleTypes:Array = ["null", "Number", "int", "uint", "String", "Boolean", "XML", "XMLList"];
		
		private static var _output:Array = [];
		
		/**
		 * Возвращает буфер логгера 
		 * @return 
		 * 
		 */		
		/*public static function get output():String{
			
			var str:String;
			
			for(var i:uint = 0; i < _output.length; i++){
				str +=  _output[i].toString();
			}
			
			_output = [];
			
			return str;
		}*/
		
		/**
		 * Записывает в лог отладочное сообщение.
		 * Эта функция здесь исклучительно ради удобства и работает поверх
		 * функции log() 
		 * @param args
		 * 
		 */		
		public static function debug(...args):void{
			args.unshift(LogLevel.DEBUG);
			log.apply(null, args);
		}
		
		/**
		 * Записывает в лог сообщение об ошибке.
		 * Эта функция здесь исклучительно ради удобства и работает поверх
		 * функции log() 
		 * @param args
		 * 
		 */		
		public static function error(...args):void{
			args.unshift(LogLevel.ERROR);
			log.apply(null, args);
		}
		
		/**
		 * Низхкоуровневая комманда, которая выводит список объектов, которые ей передали
		 *  
		 * @param args любое количество любых параметров
		 * 
		 */		
		public static function log(level:uint, ...args):void{
			
			var len:uint = args.length;
			
			var tempOutput:String = "";
			
			for(var i:uint = 0; i < len; ++i){
				
				var xml:XML = describeType(args[i]);
				var type:String = xml.@name.toString();
				
				tempOutput +=/* "[" + type + "]" + */parse(args[i]) + "\n";
				
			}
			
			var logMsg:LogMessageVO = new LogMessageVO();
			logMsg.time = getTimer();
			logMsg.message = tempOutput;
			logMsg.level = level;
			
			//_output[_output.length] = logMsg;
			
			if(targets){
				for(var j:uint = 0; j < targets.length; ++j){
					if(targets[j] is IloggerTarget){
						targets[j].send(logMsg);
					}
				}
			}
		}
		
		/**
		 * Реккурсивно разбирает переданный функции объект и выводит значение всех его свойств,
		 * включая значение геттеров
		 * @param val
		 * @return 
		 * 
		 */		
		private static function parse(val:*):String{
			
			var locOutput:String = "";
			
			var xml:XML = describeType(val);
			var type:String = xml.@name.toString();
			
			if(simpleTypes.indexOf(type) != -1){
				locOutput += String(val);
			}else{
				
				locOutput += "[" + type + "]\n";
				
				var propList:XMLList = xml.accessor;
				
				tabs += "\t";
				for each(var acc:XML in propList){
					
					var declaredBy:String 	= acc.@declaredBy.toString();
					
					var fullType:Array = acc.@type.toString().split("::");
					var accType:String = (fullType.length == 1) ? fullType[0] : fullType[1];
					
					if(declaredBy == type){
						var uri:String;
						try{
							uri = acc.@uri.toString();
						}catch(err:Error){
							
						}
						var accName:String = acc.@name.toString();
						if(uri){
							var ns:Namespace = new Namespace(null, uri);
							locOutput += tabs + "[" + accType + "]" + "{" + uri + "}" + accName + "= " + parse(val.ns::[accName]) + "\n";
						}else{
							locOutput += tabs + "[" + accType + "]" + accName + "= " + parse(val[accName]) + "\n";
						}
					}
					
				}
				
				for (var prop:String in val){
					
					var propXml:XML = describeType(val[prop]);
					var propType:String = propXml.@name.toString();
					
					locOutput += tabs + "[" + propType + "]" +prop + "= " + parse(val[prop]) + "\n";
					
					//System.disposeXML(propXml);
					
				}
				tabs = tabs.substr(0, tabs.length - 1);
			}
			
			//System.disposeXML(xml);
			
			return locOutput;
			
		}
	}
}