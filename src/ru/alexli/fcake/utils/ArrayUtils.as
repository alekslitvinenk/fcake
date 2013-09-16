package ru.alexli.fcake.utils
{
	public class ArrayUtils
	{
		public static function createMap(key:String, array:Array, test:Function = null):Array
		{
			var arr:Array = array.slice();
			
			var map:Array = [];
			for(var i:uint = 0; i < arr.length; i++){
				
				var val:* = arr[i][key];
				if(test){
					val = test.call(null, val);
				}
				
				map[val] = arr[i];
			}
			return map;
		}
		
		public static function makeArray(obj:Object):Array{
			var arr:Array = [];
			
			for each (var e:* in obj){
				arr.push(e);
			}
			
			return arr;
		}
		
		public static function getValsByKey(key:String, array:Array):Array
		{
			var arr:Array = array.slice();
			
			var res:Array = [];
			
			for(var i:uint = 0; i < arr.length; i++){
				
				var val:* = arr[i][key];
				
				if(val){
					res.push(val);
				}
			}
			
			return res;
		}
		
		public static function substractArrays(first:Array, second:Array):Array
		{
			var res:Array = [];
			
			for(var i:uint = 0; i < second.length; i++){
				var val:* = second[i];
				
				if(first.indexOf(val) == -1){
					res.push(val);
				}
			}
			
			return res;
		}
	}
}