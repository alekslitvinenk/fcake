package ru.alexli.fcake.view
{
	public class AbstractItemRenderer extends AbstractVisualObject
	{
		
		public function AbstractItemRenderer(data:Object = null)
		{
			_data = data;
		}
		
		protected var _data:Object;

		public function get data():Object
		{
			return _data;
		}
		
		public function set data(value:Object):void
		{
			_data = value;
			
			if(stage){
				commitData();
			}
		}
		
		override protected function onShow():void{
			commitData();
		}
		
		virtual protected function commitData():void{
			
		}

	}
}