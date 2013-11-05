package ru.alexli.fcake.utils
{
	import flash.events.EventDispatcher;
	
	[Event(name="added_to_list", type="ru.alexli.fcake.utils.ItemListEvent")]
	[Event(name="item_changed", type="ru.alexli.fcake.utils.ItemListEvent")]
	[Event(name="removed_from_list", type="ru.alexli.fcake.utils.ItemListEvent")]
	public class ItemList extends EventDispatcher
	{
		
		private var data:Array;
		private var field:String;
		
		private var mapedData:Array;
		
		private var dataChanged:Boolean;
		
		private var convertKey:Function;
		
		public function ItemList()
		{
			
		}
		
		public function setData(data:Array = null, field:String = null, convertKey:Function = null):void{
			this.data = data;
			this.field = field;
			this.convertKey = convertKey;
			
			createMap();
			
			for(var i:uint = 0; i < data.length; i++){
				dispatchEvent(new ItemListEvent(ItemListEvent.ADDED_TO_LIST, data[i]));
			}
		}
		
		public function getData():Array{
			if(dataChanged){
				data = ArrayUtils.makeArray(mapedData);
				dataChanged = false;
			}
			
			return data;
		}
		
		public function getItemByKey(key:*):*{
			if(!mapedData){
				createMap();
			}
			
			return mapedData[key];
		}
		
		public function add(val:*):void
		{
			var key:* = val[field];
			
			var type:String;
			
			if(mapedData[key]){
				type = ItemListEvent.ITEM_CHENGED;
			}else{
				type = ItemListEvent.ADDED_TO_LIST;
			}
			mapedData[key] = val;
			
			dataChanged = true;
			
			dispatchEvent(new ItemListEvent(type, mapedData[key]));
		}
		
		public function remove(val:*):void
		{
			var key:* = val[field];
			
			dataChanged = true;
			
			var item:* = mapedData[key];
			
			if(mapedData[key]){
				mapedData[key] = null;
				delete mapedData[key];
			}
			
			dispatchEvent(new ItemListEvent(ItemListEvent.REMOVED_FROM_LIST, item));
		}
		
		private function createMap():void{
			if(data){
				mapedData = ArrayUtils.createMap(field, data, convertKey);
			}else{
				mapedData = [];
			}
		}
	}
}