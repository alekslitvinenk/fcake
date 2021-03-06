package ru.alexli.fcake.view
{
	public class AbstractItemRenderer extends AbstractVisualObject
	{
		private var dirty:Boolean = true;
		
		public function AbstractItemRenderer(data:Object = null)
		{
			_data = data;
			
			super();
		}
		
		protected var _data:Object;

		public function get data():Object
		{
			return _data;
		}
		
		public function set data(value:Object):void
		{
			if(_data != value)
			{
				_data = value;
				
				dirty = true;
			}
			
			if(dirty)
			{
				commitData();
				
				dirty = false;
			}
		}
		
		override protected function init():void
		{
			super.init();
			
			if((_data != null) && dirty)
			{
				commitData();
				
				dirty = false;
			}
		}
		
		virtual protected function commitData():void
		{
			
		}

	}
}