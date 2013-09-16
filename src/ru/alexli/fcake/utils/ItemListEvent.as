package ru.alexli.fcake.utils
{
	import flash.events.Event;
	
	public class ItemListEvent extends Event
	{
		
		public static const ADDED_TO_LIST:String = "added_to_list";
		public static const ITEM_CHENGED:String = "item_changed";
		public static const REMOVED_FROM_LIST:String = "removed_from_list";
		
		public var data:Object;
		
		public function ItemListEvent(type:String, data:*)
		{
			super(type);
			this.data = data;
		}
		
		override public function clone():Event{
			return new ItemListEvent(type, data);
		}
	}
}