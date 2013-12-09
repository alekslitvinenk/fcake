package ru.alexli.fcake.view.ui
{
	import ru.alexli.fcake.view.AbstractItemRenderer;
	import ru.alexli.fcake.view.ui.containers.AlignContainer;
	import ru.alexli.fcake.view.ui.containers.ScrollContainer;
	
	public class ItemListScrollView extends ScrollContainer
	{
		public function ItemListScrollView(rows:uint=2, columns:uint=2, container:AlignContainer=null)
		{
			super(rows, columns, container);
		}
		
		private var _itemRenderer:Class;
		
		public function get itemRenderer():Class
		{
			return _itemRenderer;
		}
		
		public function set itemRenderer(value:Class):void
		{
			_itemRenderer = value;
		}
		
		private var _dataProvider:Array;

		public function get dataProvider():Array
		{
			return _dataProvider;
		}

		public function set dataProvider(value:Array):void
		{
			_dataProvider = value;
			
			if(stage){
				commitData();
			}
			
			scrollToZero();
		}
		
		override protected function onShow():void
		{
			super.onShow();
			commitData();
		}
		
		protected function commitData():void
		{
			if(_container && _dataProvider && _itemRenderer)
			{
				while(_container.numChildren){
					_container.removeChildAt(0);
				}
				
				for(var i:uint = 0; i < _dataProvider.length; i++){
					var item:AbstractItemRenderer = new _itemRenderer();
					item.data = _dataProvider[i];
					_container.addChild(item);
				}
			}
		}
	}
}