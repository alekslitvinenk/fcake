package ru.alexli.fcake.view.ui.containers
{
	import flash.geom.Point;

	public class VerticalContainer extends AlignContainer
	{
		public function VerticalContainer(alignment:PaddingVO=null)
		{
			super(alignment);
		}
		
		override protected function getNextObjPos():Point
		{
			var i:int = (numChildren - 1);
			
			var pt:Point = new Point(_padding.paddingLeft, i * (_padding.paddingTop + itemHeight + _padding.paddingBottom));
			
			if(i > 0){
				pt.y += _padding.verticalGap * i;
			}
			
			return pt;
		}
	}
}