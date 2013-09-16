package ru.alexli.fcake.view.ui.containers
{
	import flash.geom.Point;

	public class FixedColumnContainer extends AlignContainer
	{
		
		private var columns:uint;
		
		public function FixedColumnContainer(columns:uint = 2, alignment:PaddingVO=null)
		{
			super(alignment);
			this.columns = columns;
		}
		
		override protected function getNextObjPos():Point
		{
			var j:int = (numChildren - 1) % columns;
			var i:int = (numChildren - 1) / columns;
			
			var pt:Point = new Point(j * (_padding.paddingLeft + itemWidth + _padding.paddingRight), i * (_padding.paddingTop + itemHeight + _padding.paddingBottom));
			
			if(i > 0){
				pt.y += _padding.verticalGap * i;
			}
			
			if(j > 0){
				pt.x += _padding.horizontalGap * j;
			}
			
			return pt;
		}
	}
}