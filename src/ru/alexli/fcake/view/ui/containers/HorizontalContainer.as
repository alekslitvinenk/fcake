package ru.alexli.fcake.view.ui.containers
{
	import flash.geom.Point;

	public class HorizontalContainer extends AlignContainer
	{
		public function HorizontalContainer(alignment:PaddingVO=null)
		{
			super(alignment);
		}
		
		override protected function getNextObjPos():Point
		{
			var i:int = (numChildren - 1);
			
			var pt:Point = new Point(i * (_padding.paddingLeft + itemWidth + _padding.paddingRight), _padding.paddingTop);
			
			if(i > 0)
			{
				pt.x += _padding.horizontalGap * i;
			}
			
			_usedColums = numChildren;
			_usedRows = 1;
			
			return pt;
		}
	}
}