package ru.alexli.fcake.view.ui.containers
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.geom.Point;
	
	import ru.alexli.fcake.utils.Coord;
	import ru.alexli.fcake.view.AbstractVisualObject;
	
	public class AlignContainer extends AbstractVisualObject
	{
		protected var _usedRows:uint;

		public function get usedRows():uint
		{
			return _usedRows;
		}

		protected var _usedColums:uint;

		public function get usedColums():uint
		{
			return _usedColums;
		}

		
		public function AlignContainer(padding:PaddingVO = null)
		{
			_padding = padding || new PaddingVO();
		}
		
		protected var _itemWidth:Number; 
		
		public function get itemWidth():Number
		{
			return _itemWidth;
		}
		
		protected var _itemHeight:Number; 
		
		public function get itemHeight():Number
		{
			return _itemHeight;
		}
		
		protected var _padding:PaddingVO
		
		public function get padding():PaddingVO
		{
			return _padding;
		}

		public function set padding(value:PaddingVO):void
		{
			_padding = value;
		}

		override protected function init():void
		{
			super.init();
			
			addEventListener(Event.ADDED, onItemAdded, true);
		}
		
		virtual protected function getNextObjPos():Point
		{
			return null;
		}
		
		public function addChildren(children:Array):void
		{
			for(var i:uint = 0; i < children.length; i++)
			{
				addChild(children[i]);
			}
		}
		
		//events
		protected function onItemAdded(evt:Event):void
		{
			//evt.stopPropagation();
			
			var obj:DisplayObject = evt.target as DisplayObject;
			
			if(obj.parent == this)
			{
				if(numChildren == 1)
				{
					_itemWidth = obj.width;
					_itemHeight = obj.height;
				}
				
				Coord.move(getNextObjPos(), obj);
			}
		}
	}
}