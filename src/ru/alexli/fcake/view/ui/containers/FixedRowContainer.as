package ru.alexli.fcake.view.ui.containers
{
	import flash.geom.Point;

	public class FixedRowContainer extends AlignContainer
	{
		
		private var rows:uint;
		
		public function FixedRowContainer(rows:uint = 2, alignment:PaddingVO=null)
		{
			super(alignment);
			this.rows = rows;
		}
		
		override protected function getNextObjPos():Point
		{
			var i:int = (numChildren - 1) % rows;
			var j:int = (numChildren - 1) / rows;
			
			var pt:Point = new Point(j * (_padding.paddingLeft + itemWidth + _padding.paddingRight), i * (_padding.paddingTop + itemHeight + _padding.paddingBottom));
			
			if(i > 0){
				pt.y += _padding.verticalGap * i;
			}
			
			if(j > 0){
				pt.x += _padding.horizontalGap * j;
			}
			
			_usedColums = j + 1;
			_usedRows = rows;
			
			return pt;
		}
	}
}