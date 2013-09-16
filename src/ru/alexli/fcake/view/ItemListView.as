package ru.alexli.fcake.view
{
	import ru.alexli.fcake.view.ui.containers.AlignContainer;

	public class ItemListView extends AbstractItemRenderer
	{
		
		private var _container:AlignContainer;

		public function get container():AlignContainer
		{
			return _container;
		}

		public function set container(value:AlignContainer):void
		{
			_container = value;
			addChild(_container);
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


		public function ItemListView(container:AlignContainer = null, data:Array = null)
		{
			_container = container;
			_data = data;
		}
		
		override protected function commitData():void{
			if(_container && _data && _itemRenderer)
			{
				while(_container.numChildren){
					_container.removeChildAt(0);
				}
				
				var dataProvider:Array = _data as Array;
				
				for(var i:uint = 0; i < dataProvider.length; i++){
					var item:AbstractItemRenderer = new _itemRenderer();
					item.data = dataProvider[i];
					_container.addChild(item);
				}
			}
		}
	}
}