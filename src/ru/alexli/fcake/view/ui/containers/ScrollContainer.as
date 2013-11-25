package ru.alexli.fcake.view.ui.containers
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import ru.alexli.fcake.utils.Coord;
	import ru.alexli.fcake.view.AbstractVisualObject;
	
	public class ScrollContainer extends AbstractVisualObject
	{
		
		protected var rows:uint;
		protected var columns:uint;
		
		protected var viewPort:Rectangle;
		
		public function ScrollContainer(rows:uint = 2, columns:uint = 2, container:AlignContainer = null)
		{
			_container = container;
			this.rows = rows;
			this.columns = columns;
			addChild(_container);
		}
		
		override protected function onShow():void{
			super.onShow();
			
			_container.addEventListener(Event.ADDED, onItemAdded, true);
		}
		
		protected var _container:AlignContainer;

		public function get container():AlignContainer
		{
			return _container;
		}

		public function set container(value:AlignContainer):void
		{
			_container = value;
		}

		public function scrollToZero():void
		{
			if(viewPort)
			{
				viewPort.x = 0;
				viewPort.y = 0;
				
				_container.scrollRect = viewPort;
			}
		}
		
		public function scrollRowDown():void{
			
		}
		
		public function scrollRowUp():void{
			
		}
		
		public function scrollColumnRight():void{
			
		}
		
		public function scrollColumnLeft():void{
			
		}
		
		public function scrollPageDown():void
		{
			if(viewPort.y < height)
			{
				viewPort.y += viewPort.height;
				_container.scrollRect = viewPort;
			}
		}
		
		public function scrollPageUp():void
		{
			if(viewPort.y > 0)
			{
				viewPort.y -= viewPort.height;
				_container.scrollRect = viewPort;
			}
		}
		
		public function scrollPageRight():void
		{
			viewPort.x += viewPort.width;
			_container.scrollRect = viewPort;
		}
		
		public function scrollPageLeft():void
		{
			if(viewPort.x > 0)
			{
				viewPort.x -= viewPort.width;
				_container.scrollRect = viewPort;
			}
		}
		
		protected function onViewportCreated():void
		{
			
		}
		
		//events
		protected function onItemAdded(evt:Event):void
		{
			var obj:DisplayObject = evt.target as DisplayObject;
			
			if(obj.parent == _container)
			{
				if(!viewPort){
					
					var pad:PaddingVO = _container.padding;
					
					var w:Number = columns * (pad.paddingLeft + _container.itemWidth + pad.paddingRight);
					var h:Number = pad.paddingTop + rows * (/*pad.paddingTop + */_container.itemHeight/* + pad.paddingBottom*/);
					
					if(w > 1){
						w += pad.horizontalGap * columns;
					}
					
					if(h > 1){
						h += pad.verticalGap * rows;
					}
					
					viewPort = new Rectangle(0, 0, w, h);
					
					_container.scrollRect = viewPort;
					
					onViewportCreated();
				}
			}
		}
	}
}